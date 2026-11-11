import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as img;
import '../../../core/network/api_constants.dart';
import '../models/analysis_mode.dart';
import '../models/hr_candidate_report.dart';
import 'pixel_graphology_extractor.dart';

class GraphologyValidationException implements Exception {
  final String reasonKey;
  const GraphologyValidationException(this.reasonKey);
}

class HrGraphologyApiService {
  static String _generateId(String hash) =>
      '${DateTime.now().millisecondsSinceEpoch}_${hash.substring(0, 8)}';

  /// Neutralizes client-side prompt injection attempts inside the Candidate Code / Name field
  /// before sending to the AI BFF or interpolating into directives.
  static String sanitizeCandidateLabel(
    String raw, {
    required String fallbackHash,
  }) {
    final fallback = 'HR-${fallbackHash.substring(0, 6).toUpperCase()}';
    final trimmed = raw.trim();
    if (trimmed.isEmpty) return fallback;

    final cleaned = trimmed
        .replaceAll(RegExp(r'[\r\n\t`"<>{}\[\]\\]'), ' ')
        .replaceAll(
          RegExp(
            r'\b(ignore|override|system|prompt|instruction|assistant)\b',
            caseSensitive: false,
          ),
          '',
        )
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();

    if (cleaned.isEmpty) return fallback;
    return cleaned.length > 60 ? cleaned.substring(0, 60).trim() : cleaned;
  }

  /// Compresses and normalizes image bytes to a lightweight JPEG (max 1024px)
  /// so the Cloudflare Worker + Gemini Vision call responds reliably.
  Uint8List _optimizeForUpload(Uint8List rawBytes) {
    try {
      final decoded = img.decodeImage(rawBytes);
      if (decoded == null) return rawBytes;
      final resized = decoded.width > 1024
          ? img.copyResize(decoded, width: 1024)
          : decoded;
      return Uint8List.fromList(img.encodeJpg(resized, quality: 82));
    } catch (_) {
      return rawBytes;
    }
  }

  Future<HrCandidateReport> analyzeSample({
    required AnalysisMode mode,
    required TargetRoleProfile targetRole,
    required String candidateLabel,
    required String localeCode,
    required Uint8List imageBytes,
  }) async {
    // Stage 1: Deterministic Pixel CV Gatekeeper & Telemetry Extraction
    final telemetry = PixelGraphologyExtractor.analyzeBytes(imageBytes);
    if (!telemetry.isValidInkSample) {
      throw GraphologyValidationException(
        telemetry.invalidReasonKey ?? 'INVALID_SAMPLE',
      );
    }

    final normalizedCandidate = sanitizeCandidateLabel(
      candidateLabel,
      fallbackHash: telemetry.sha256Hash,
    );

    // Stage 2: Grounded AI Corporate HR Synthesis via Cloudflare Worker (Gemini Vision)
    try {
      final optimizedBytes = _optimizeForUpload(imageBytes);
      final encodedImage = base64Encode(optimizedBytes);

      final payload = <String, dynamic>{
        'edition': 'hr',
        'mode': mode.name,
        'targetRole': targetRole.name,
        'candidateRef': normalizedCandidate,
        'locale': localeCode,
        'handwritingImageBase64': encodedImage,
        'includeAstroSynthesis': false,
        'pixelTelemetry': telemetry.toJson(),
        'styleDirective': _buildHrStyleDirective(
          mode: mode,
          targetRole: targetRole,
          candidateLabel: normalizedCandidate,
          localeCode: localeCode,
          hasRuledLines: telemetry.hasRuledLines,
        ),
      };

      final response = await http
          .post(
            Uri.parse(ApiConstants.cloudflareWorkerUrl),
            headers: {
              'Content-Type': 'application/json',
              'X-Graphology-Client': ApiConstants.clientHeaderValue,
            },
            body: jsonEncode(payload),
          )
          .timeout(ApiConstants.requestTimeout);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        if (data['isValidSample'] == false || data['validSample'] == false) {
          throw const GraphologyValidationException('AI_REJECTED_NON_INK');
        }
        if (data['executiveSummary'] != null && data['dimensions'] != null) {
          return _parseAndEnrichWorkerResponse(
            data: data,
            telemetry: telemetry,
            mode: mode,
            targetRole: targetRole,
            candidateLabel: normalizedCandidate,
            localeCode: localeCode,
          );
        }
      }
    } on GraphologyValidationException {
      rethrow;
    } catch (_) {
      // Fallback to deterministic pixel-grounded HR report below if offline
    }

    return _buildDeterministicHrReport(
      telemetry: telemetry,
      mode: mode,
      targetRole: targetRole,
      candidateLabel: normalizedCandidate,
      localeCode: localeCode,
      isLiveAi: false,
    );
  }

  String _buildHrStyleDirective({
    required AnalysisMode mode,
    required TargetRoleProfile targetRole,
    required String candidateLabel,
    required String localeCode,
    required bool hasRuledLines,
  }) {
    return 'IMPORTANT OVERRIDE — CORPORATE HR & TALENT ACQUISITION EDITION (Language: $localeCode, Candidate Ref: $candidateLabel, Target Role Profile: ${targetRole.name}):\n'
        'You are acting as an incisive, realistic Senior Corporate HR & Organizational Behavior Graphology Assessor evaluating a job candidate from their handwriting/notes/signature.\n'
        '1. ZERO ASTROLOGY & ZERO RAW NUMBERS: Never mention astrology/zodiac signs, and never output raw degree (°) or percentage (%) numbers.\n'
        '2. INCISIVE, REALISTIC, UNVARNISHED HR TONE — YET PROBABILISTIC & GESTALT-GROUNDED: Be significantly more candid and realistic than a consumer app ("pembe tablo çizme"). Surface corporate friction points honestly: authority resistance, micro-management intolerance, delegation anxiety, ego defensiveness, organizational scatter, or fragility under KPI stress. HOWEVER, follow holistic Gestalt graphology (never judge from a single isolated sign) and frame all findings strictly as behavioral tendencies, probabilities, and hypotheses to verify in structured interviews.\n'
        '3. PAPER SUPPORT & INSTRUMENT CONTEXT (CV Ruled-Paper Flag: $hasRuledLines): Inspect whether the sample is on UNLINED paper or RULED/LINED notebook paper (possibly with a vertical margin rule). On ruled paper, horizontal lines artificially guide the baseline — do NOT mistake printed line alignment for exceptional internal baseline stability; instead evaluate how the candidate relates to the printed rule (clinging rigidly, riding above, cutting below, or ignoring the margin rule) and account for rapid working notes vs. slow formal script.\n'
        '4. MODE-SPECIFIC GRAPHOLOGICAL VALIDITY (Current mode: "${mode.name}"):\n'
        '   - If mode is "signature" (isolated signature without multi-line text): In scientific graphology, an isolated signature reveals ONLY external authority projection, ambition, and interview persona/ego shield — it CANNOT directly confirm day-to-day operational follow-through or routine organization. Explicitly warn HR inside "discipline" and "executiveSummary" that multi-line handwriting notes should be requested to verify actual daily execution habits!\n'
        '   - If mode is "handwriting" (no standalone signature): Use observedMetrics.signatureStructure strictly to analyze underlining (straight/wavy), exclamation marks, arrows, and numeric target framing as operational prioritization gestures WITHOUT calling them an official signature ("imza"), and set "comparativeSynthesis": "".\n'
        '5. PUBLIC-FIGURE IDENTITY BLINDNESS: Ignore any famous/political identity in the text or signature; treat strictly as an anonymous candidate.\n'
        '6. JSON OUTPUT KEYS MANDATE:\n'
        '   - Include "corporateSpectrum": { "manageability": "...", "roleArchetype": "...", "resilience": "...", "discipline": "..." }\n'
        '   - Inside "dimensions", output ONLY these 6 keys (each 4-6 complete analytical sentences): "discipline", "manageability", "roleNature", "resilience", "teamEgo", and "redFlags" (3 concrete hiring watch-outs + 3 tailored behavioral interview probing questions).\n'
        '   - Set "astroGraphologySynthesis": "".';
  }

  HrCandidateReport _parseAndEnrichWorkerResponse({
    required Map<String, dynamic> data,
    required PixelTelemetry telemetry,
    required AnalysisMode mode,
    required TargetRoleProfile targetRole,
    required String candidateLabel,
    required String localeCode,
  }) {
    final fallback = _buildDeterministicHrReport(
      telemetry: telemetry,
      mode: mode,
      targetRole: targetRole,
      candidateLabel: candidateLabel,
      localeCode: localeCode,
      isLiveAi: false,
    );

    final rawMetrics =
        Map<String, dynamic>.from(data['observedMetrics'] ?? const {});
    final rawSpectrum =
        Map<String, dynamic>.from(data['corporateSpectrum'] ?? const {});
    final rawDims = Map<String, dynamic>.from(data['dimensions'] ?? const {});

    final observedMetrics = ObservedGraphologyMetrics(
      slant: _nonEmpty(rawMetrics['slant'], fallback.observedMetrics.slant),
      pressure:
          _nonEmpty(rawMetrics['pressure'], fallback.observedMetrics.pressure),
      baseline:
          _nonEmpty(rawMetrics['baseline'], fallback.observedMetrics.baseline),
      size: _nonEmpty(rawMetrics['size'], fallback.observedMetrics.size),
      zones: _nonEmpty(
        rawMetrics['zones'] ?? rawMetrics['zoneDominance'],
        fallback.observedMetrics.zones,
      ),
      connectivity: _nonEmpty(
          rawMetrics['connectivity'], fallback.observedMetrics.connectivity),
      marginsAndSpacing: _nonEmpty(
        rawMetrics['marginsAndSpacing'] ?? rawMetrics['spacing'],
        fallback.observedMetrics.marginsAndSpacing,
      ),
      signatureGeometry: _nonEmpty(
        rawMetrics['signatureGeometry'] ?? rawMetrics['signatureStructure'],
        fallback.observedMetrics.signatureGeometry,
      ),
    );

    final corporateSpectrum = CorporateSpectrum(
      manageability: _nonEmpty(
        rawSpectrum['manageability'],
        fallback.corporateSpectrum.manageability,
      ),
      roleArchetype: _nonEmpty(
        rawSpectrum['roleArchetype'],
        fallback.corporateSpectrum.roleArchetype,
      ),
      resilience: _nonEmpty(
        rawSpectrum['resilience'],
        fallback.corporateSpectrum.resilience,
      ),
      discipline: _nonEmpty(
        rawSpectrum['discipline'],
        fallback.corporateSpectrum.discipline,
      ),
    );

    final dimensions = HrDimensions(
      discipline: _nonEmpty(
        rawDims['discipline'] ?? rawDims['work'],
        fallback.dimensions.discipline,
      ),
      manageability: _nonEmpty(
        rawDims['manageability'] ?? rawDims['intellectual'],
        fallback.dimensions.manageability,
      ),
      roleNature: _nonEmpty(
        rawDims['roleNature'] ?? rawDims['work'],
        fallback.dimensions.roleNature,
      ),
      resilience: _nonEmpty(
        rawDims['resilience'] ?? rawDims['emotional'],
        fallback.dimensions.resilience,
      ),
      teamEgo: _nonEmpty(
        rawDims['teamEgo'] ?? rawDims['social'],
        fallback.dimensions.teamEgo,
      ),
      redFlags: _nonEmpty(
        rawDims['redFlags'] ?? rawDims['shadow'],
        fallback.dimensions.redFlags,
      ),
    );

    return HrCandidateReport(
      id: _generateId(telemetry.sha256Hash),
      imageHash: telemetry.sha256Hash,
      createdAt: DateTime.now(),
      mode: mode,
      targetRole: targetRole,
      candidateLabel: candidateLabel,
      localeCode: localeCode,
      observedMetrics: observedMetrics,
      corporateSpectrum: corporateSpectrum,
      executiveSummary:
          _nonEmpty(data['executiveSummary'], fallback.executiveSummary),
      comparativeSynthesis: mode == AnalysisMode.combined
          ? _nonEmpty(
              data['comparativeSynthesis'],
              fallback.comparativeSynthesis ?? '',
            )
          : '',
      dimensions: dimensions,
      isLiveAi: true,
    );
  }

  String _nonEmpty(dynamic value, String fallback) {
    final s = (value ?? '').toString().trim();
    return s.isEmpty ? fallback : s;
  }

  HrCandidateReport _buildDeterministicHrReport({
    required PixelTelemetry telemetry,
    required AnalysisMode mode,
    required TargetRoleProfile targetRole,
    required String candidateLabel,
    required String localeCode,
    required bool isLiveAi,
  }) {
    final isFirmPressure = telemetry.pressureIndex >= 0.56;
    final isLightPressure = telemetry.pressureIndex < 0.42;
    final isRightSlant = telemetry.slantDegrees > 4.0;
    final isLeftOrVertical = telemetry.slantDegrees <= 1.5;
    final isAscending = telemetry.baselineSlopeDegrees > 1.5;
    final isDescending = telemetry.baselineSlopeDegrees < -1.5;
    final isAngular = telemetry.strokeAngularityIndex >= 0.52;
    final isConnected = telemetry.connectivityIndex >= 0.50;
    final isWideMargin =
        (telemetry.leftMarginRatio + telemetry.rightMarginRatio) >= 0.22;
    final isSignatureOnly = mode == AnalysisMode.signature;

    if (localeCode == 'tr') {
      final baselineTr = telemetry.hasRuledLines
          ? 'Çizgili kağıt referans alınarak ilerleyen satır düzeni; dışsal yapı ve çerçeve sunulduğunda hizayı koruma eğilimini, yer yer çizgi üstü taşmalarda ise kendi temposunu koruma arzusunu yansıtmaktadır.'
          : (isAscending
              ? 'Çizgisiz zeminde satır sonlarına doğru hafifçe yükselen hat; hedef odaklı hırsı ve inisiyatif alma isteğini desteklerken, rutin süreçlerde sabırsızlık gösterme potansiyeli taşımaktadır.'
              : (isDescending
                  ? 'Satır sonunda hafifçe düşen istikamet; uzun süreli belirsizlik veya tekrarlayan operasyonel yükler altında motivasyon dalgalanması yaşanabileceğine işaret etmektedir.'
                  : 'Düz ve istikrarlı satır hattı; prosedürlere sadakat, planlı ilerleme ve duygusal dalgalanmalardan az etkilenen bir iş rutini sergilemektedir.'));

      final observed = ObservedGraphologyMetrics(
        slant: isRightSlant
            ? 'Sağa doğru yönelen akış; dış dünyayla temas kurma, sonuç alma ve operasyonel hız arayışının yüksek olduğuna işaret etmektedir.'
            : (isLeftOrVertical
                ? 'Dik ve kontrollü duruş; duygusal mesafeyi koruma, kurumsal süreçlerde temkinli hareket etme ve dış etkilere karşı seçici kalma eğilimini yansıtmaktadır.'
                : 'Dengeli ve kontrollü harf eğimi; sosyal uyum ile rasyonel öz-denetim arasında ölçülü bir denge kurulduğunu göstermektedir.'),
        pressure: isFirmPressure
            ? 'Kağıt yüzeyine kararlı ve tok biçimde nüfuz eden kalem baskısı; yüksek irade direnci, stres altında geri adım atmama, fakat aynı zamanda görüşlerinde ısrarcı olma eğilimi taşımaktadır.'
            : (isLightPressure
                ? 'Yüzeyde hafif ve esnek ilerleyen kalem teması; değişen koşullara hızlı adaptasyon sağlarken, sert çatışma ve yoğun politik baskı ortamlarında enerjisini koruma açısından kırılganlık riski barındırmaktadır.'
                : 'Orta-dengeli kalem baskısı; görev takibinde istikrarlı bir enerji yönetimi ve aşırı uçlara kaçmayan bir gerilim kontrolü sunmaktadır.'),
        baseline: baselineTr,
        size: telemetry.middleZoneRatio >= 0.42
            ? 'Kompakt ve orta bölge odaklı harf gövdeleri; soyut teorilerden ziyade günlük somut çıktılara ve pratik uygulamaya odaklanma eğilimini göstermektedir.'
            : 'Belirgin uzantılara sahip harf boyutları; geniş perspektif arayışı ile kendi alanını görünür kılma arzusunun bir arada işlediğini yansıtmaktadır.',
        zones: telemetry.upperZoneRatio >= telemetry.lowerZoneRatio
            ? 'Üst ve orta bölge ağırlıklı dağılım; kavramsal planlama, stratejik kurgu ve zihinsel tasarım süreçlerinin ağır bastığını ortaya koymaktadır.'
            : 'Orta ve alt bölge ağırlıklı dağılım; somut uygulama, maddi sonuç alma ve sahada işi bizzat takip etme dürtüsünün baskın olduğunu göstermektedir.',
        connectivity: isConnected
            ? 'Birbirine bağlı ve kesintisiz ilerleyen geçişler; neden-sonuç ilişkilerini kurumsal bir zincir halinde takip eden sistematik bir yapıya işaret etmektedir.'
            : 'Yer yer kopuk ve bağımsız geçişler; sezgisel sıçramalarla hızlı çözüm üretme yeteneği sunarken, standart prosedürleri kendi yöntemine göre esnetme eğilimi barındırmaktadır.',
        marginsAndSpacing: isWideMargin
            ? 'Belirgin kenar hizası ve dengeli boşluklar; zaman planlamasına, kurumsal hiyerarşi sınırlarına ve zihinsel tasnife özen gösterildiğini doğrulamaktadır.'
            : 'Sayfa alanını yoğun kullanan yerleşim; gündemi hızla doldurma ve çoklu iş yükü üstlenme eğilimi taşırken, önceliklendirme disiplininde zaman zaman sıkışma riski göstermektedir.',
        signatureGeometry: mode == AnalysisMode.handwriting
            ? 'Sayfada bağımsız bir imza bulunmamakla birlikte, kilit kavramların altına çekilen vurgu çizgileri, ünlem ve ok işaretleri; adayın önceliklerini net biçimde çerçevelediğini ve görev dağılımında somutluk talep ettiğini göstermektedir.'
            : 'İmza kurgusunda gözlenen keskin hatlar ve çerçeveleme; dış dünyaya güçlü, kontrollü ve kolay taviz vermeyen bir profesyonel vitrin sunma arzusuna işaret etmektedir.',
      );

      final spectrum = CorporateSpectrum(
        manageability: isAngular && !isConnected
            ? 'Bağımsız İnisiyatif & Seçici Uyum Eğilimi: Mantığına yatmayan talimatlara karşı içsel direnç geliştirme potansiyeli taşır; mikro-yönetim altında verimi düşebilir, gerekçesi açıklanan hedeflerde ise yüksek sahiplenme gösterir.'
            : 'Yapılandırılmış Kurumsal Uyum: Belirlenmiş iş akışlarına ve raporlama standartlarına uyum sağlama eğilimi yüksektir; ancak aşırı bürokraside inisiyatif almak için üst yönetimin onayını bekleyebilir.',
        roleArchetype: isFirmPressure && isAscending
            ? 'Yönlendirici & Sonuç Zorlayıcı (Driver / İcracı Lider): Süreçleri ve insanları hedefe doğru itme eğilimi baskındır; ancak kendi hızına yetişemeyen ekip üyelerine karşı sabırsızlaşma riski barındırır.'
            : 'Operasyonel İcracı & Sistem Takipçisi (Doer / Uygulayıcı): Vitrin şovundan ziyade mutfakta işi tamamlamaya odaklanır; stratejik vizyon sunmaktan çok mevcut planı eksiksiz işletmeye yatkındır.',
        resilience: isFirmPressure && !isDescending
            ? 'Yüksek Stres Direnci (Resilient) — Sertleşme Riskiyle: Kriz ve baskı altında dağılmaz, bilakis daha odaklı hale gelir; fakat stres uzadığında empatiyi azaltıp mekanik ve sert bir iletişime geçme eğilimi taşır.'
            : 'Hassas / Kırılgan Denge (Fragile Risk): Sert geri bildirimleri ve açık çatışmaları kişisel algılama potansiyeli taşır; destekleyici ve net sınırları olan bir yönetim ikliminde performansı belirgin biçimde artar.',
        discipline: isSignatureOnly
            ? 'Dış Temsil & Hedef İddiası (İmza Kısıtı): Tekil imza dış dünyaya sunulan kararlılık iddiasını yansıtır; gerçek günlük iş takibi ve masa başı organizasyon disiplininin doğrulanması için çok satırlı el yazısı örneği önerilir.'
            : (isWideMargin && !isDescending
                ? 'Yüksek Öz-Disiplin & Yapılandırılmış Takip: Dış denetime ihtiyaç duymadan kendi ajandasını ve önceliklerini organize etme eğilimi güçlüdür; belirsiz iş tanımlarından rahatsızlık duyabilir.'
                : 'Esnek / Dış Çerçeve Gerektiren Organizasyon: Kısa vadeli acil işlerde hızlı reaksiyon verirken, uzun soluklu ve çok paydaşlı projelerde kilometre taşlarının net biçimde denetlenmesine ihtiyaç duyabilir.'),
      );

      final execSummary =
          'İncelenen çizgi ve yerleşim mekaniği ($candidateLabel), kurumsal hayata pembe bir uyum vaadinden ziyade, güçlü operasyonel refleksler ile yönetilmesi gereken keskin sınırların bir arada bulunduğunu göstermektedir. '
          'Kalemin kağıt üzerindeki ${isFirmPressure ? "tok ve kararlı baskısı" : "kontrollü ve temkinli akışı"}, adayın iş ortamında kendi çalışma standartlarını ve özerklik alanını koruma eğiliminde olduğuna işaret eder.'
          '${isSignatureOnly ? " Bununla birlikte bilimsel grafoloji ilkeleri gereği yalnızca imza üzerinden yapılan bu okuma adayın kurumsal vitrinini ve otorite iddiasını yansıtır; günlük operasyonel disiplini teyit etmek için mülakatta el yazısı notu da alınmalıdır." : ""}\n\n'
          'İşe alım ve ekip uyumu perspektifinden bakıldığında, bu profilin en yüksek verimi "ne yapılacağının net olduğu ancak nasıl yapılacağı konusunda kendisine hareket alanı bırakılan" rollerde üretme olasılığı yüksektir. '
          'Buna karşılık, sürekli anlık kontrol (mikro-yönetim), belirsiz yetki sınırları veya politik laf kalabalığı içeren ortamlarda sabırsızlık, savunmacı iletişim veya motivasyon kaybı geliştirme riski mülakat sorularıyla somut olarak sınanmalıdır.';

      final compSynthesis = mode == AnalysisMode.combined
          ? 'Günlük çalışma notlarındaki doğal, sonuca odaklı ve doğrudan akış ile dış dünyaya sunulan kontrollü imza duruşu karşılaştırıldığında, adayın mülakat ortamında özgüvenli ve düzenli bir profesyonel profil çizme kapasitesinin yüksek olduğu görülmektedir. '
              'Ancak yazı içindeki keskin geçişler ve vurgu hareketleri, sakin görünümün altında zaman baskısına ve verimsizliğe karşı düşük bir tolerans eşiği yatabileceğine işaret eder; mülakattaki diplomatik üslubun operasyonel stres altında ne kadar korunduğu referans kontrollerinde özellikle doğrulanmalıdır.'
          : '';

      final dims = HrDimensions(
        discipline: isSignatureOnly
            ? 'Klasik grafoloji ilkelerine göre tek başına incelenen imza, adayın dış dünyaya yansıttığı özgüven, hedef iddiası ve statü beklentisini gösterir; ancak rutin iş takibi ve detay organizasyonunu doğrudan kanıtlamaz. '
                'İmzadaki çizgi bütünlüğü adayın sorumluluk üstlenme ve kararlı görünme arzusunun güçlü olduğuna işaret etmektedir. '
                'Bununla birlikte masa başı planlama sabrı ile dışarıya sunulan bu iddialı duruş arasında fark olup olmadığı mutlaka yazılı bir vaka çalışmasıyla test edilmelidir. '
                'Tam kapsamlı iç disiplin tespiti için adayın 6–8 satırlık doğal el yazısıyla birlikte "El Yazısı + İmza" modunda değerlendirilmesi önerilir.'
            : 'Adayın satır düzeni ve sayfa marjinleriyle kurduğu ilişki, iş takibinde yapılandırılmış bir iç disipline ve önceliklendirme bilincine sahip olma eğilimini yansıtmaktadır. '
                'Önemli başlıkları ve sayısal hedefleri belirginleştirme refleksi, başladığı işi havada bırakmamak adına kendi iç denetim mekanizmasını çalıştırdığını düşündürür. '
                'Bununla birlikte, kendi kurduğu sistemin dışına çıkılması veya son dakika öncelik değişiklikleriyle planının bozulması durumunda esneklik kaybı yaşama riski barındırır. '
                'Süreçlerin neden aksadığına dair detaylarda seçici davranarak zaman zaman operasyonel hızı kendi standartlarına göre zorlama potansiyeli taşır.',
        manageability:
            'Otoriteyle ilişki ve yönetilebilirlik ekseninde, adayın körü körüne itaat eden pasif bir profil olmaktan ziyade, yöneticisinin yetkinliğini ve kararların rasyonel temelini tartan seçici bir uyum sergileme olasılığı yüksektir. '
            'Çizgi bağlantılarındaki ${isConnected ? "sistematik süreklilik" : "bağımsız geçişler"}, kurumsal kuralları amaca hizmet ettiği sürece benimsediğini, ancak bürokratik engelleri kendi yöntemiyle aşma eğilimi taşıyabileceğini gösterir. '
            'Sürekli omuz üzerinden izlenen bir mikro-yönetim tarzı bu profilde pasif direnç veya içsel kopuş yaratma riski taşır. '
            'Net hedefler, şeffaf performans kriterleri ve yetki alanı tanımlandığında ise yönetilebilirliği ve kurumsal aidiyeti belirgin biçimde güçlenme eğilimindedir.',
        roleNature:
            'Operasyonel rol doğası incelendiğinde, profilin vitrin odaklı bir şovmenden ziyade, somut çıktı ve uygulama üzerinden konuşan "işi yapan / yönlendiren icracı" arketipine daha yakın durduğu görülmektedir. '
            'Orta bölge yoğunluğu ve vurgu işaretleri, toplantılarda kavramsal tartışmaları uzatmak yerine aksiyon maddelerine ve ölçülebilir sonuçlara geçme dürtüsünü destekler. '
            'Liderlik pozisyonlarında vizyoner bir ilham vericiden çok, standartları belirleyen ve takibi sıkı tutan talepkar bir yönetici olma potansiyeli taşır. '
            'Eğer rol tamamen rutin ve inisiyatifsiz bir operasyon içeriyorsa, adayın bir süre sonra rolü dar bulup süreçlere müdahale etme eğilimi göstermesi olasıdır.',
        resilience:
            'Baskı altında direnç (resilience) ve kırılganlık dengesinde, kalem baskısının ${isFirmPressure ? "kararlılığı kriz anlarında kolay pes etmeyen bir dayanıklılığa" : "hassas dengesi yoğun stres altında zihinsel yorgunluk biriktirme riskine"} işaret etmektedir. '
            'İş yükü ve teknik zorluklar karşısında dirençli durma kapasitesi yüksek görünmekle birlikte, asıl sınavını belirsizlik ve kişilerarası politik gerilimlerde verme olasılığı vardır. '
            'Beklentilerin karşılanmadığı veya emeğinin görünmediği durumlarda kırılganlığını dışarıya duygusal olarak değil, mesafeli ve sertleşen bir tutumla yansıtma eğilimi taşıyabilir. '
            'Uzun süreli yüksek tempo sonrasında tükenmişlik yaşamaması için görev sınırlarının gerçekçi çizilmesi önem taşır.',
        teamEgo:
            'Takım içi iletişimde boşluk dengesi ve dik duruş, profesyonel sınırlarını koruyan, laubalilikten hoşlanmayan ve iş odaklı ilişki kuran bir mizaca işaret etmektedir. '
            'Kendi uzmanlık alanına müdahale edildiğinde veya hazırlıksız argümanlarla karşılaştığında ego sınırlarını koruyarak savunmacı veya eleştirel bir tona geçme riski barındırır. '
            'Yüksek performanslı ve net sorumluluk sahibi ekip arkadaşlarıyla uyumlu çalışırken, düşük tempolu veya dağınık profillere karşı tahammülsüzlük geliştirme potansiyeli vardır. '
            'Geri bildirim verirken yapıcı diplomasiyi koruyup korumadığı ekip içi huzur açısından kritik bir faktör olacaktır.',
        redFlags:
            'Dikkat Edilmesi Gereken Potansiyel Riskler: (1) Kendi doğrusuna aşırı güvenerek ekip içi farklı yöntemlere kapalı kalma veya delegasyonda zorlanma eğilimi; (2) Yetki alanına müdahale edildiğinde veya mikro-yönetim altında motivasyon ve uyum kaybı riski; (3) Stres altında iletişimi fazla doğrudan ve sert kurarak kırıcı olma potansiyeli.\n'
            'Mülakatta Sorulması Gereken Doğrulama Soruları:\n'
            '• "Geçmişte yöneticinizin aldığı ancak sizin mantıksız veya verimsiz bulduğunuz bir kararda nasıl bir yol izlediniz, sonuç ne oldu?"\n'
            '• "Sizin çalışma hızınıza ve kalite standardınıza yetişemeyen bir ekip üyesiyle aynı projede sorumluluk paylaştığınızda süreci nasıl yönettiniz?"\n'
            '• "Tamamen belirsiz ve kuralları henüz yazılmamış kaotik bir projede ilk 30 günde ne yaparsınız, sizi en çok ne zorlar?"',
      );

      return HrCandidateReport(
        id: _generateId(telemetry.sha256Hash),
        imageHash: telemetry.sha256Hash,
        createdAt: DateTime.now(),
        mode: mode,
        targetRole: targetRole,
        candidateLabel: candidateLabel,
        localeCode: localeCode,
        observedMetrics: observed,
        corporateSpectrum: spectrum,
        executiveSummary: execSummary,
        comparativeSynthesis: compSynthesis,
        dimensions: dims,
        isLiveAi: isLiveAi,
      );
    }

    // English & International Fallback
    final baselineEn = telemetry.hasRuledLines
        ? 'Ruled-paper guided baseline alignment indicating structured adherence to external frameworks, with occasional upward stroke energy reflecting personal drive.'
        : (isAscending
            ? 'Upward-trending baseline on unlined space pointing to goal-oriented ambition and initiative, with a potential risk of impatience during slow bureaucratic routines.'
            : 'Steady horizontal baseline alignment reflecting procedural consistency, methodical pacing, and emotional containment across daily deliverables.');

    final observedEn = ObservedGraphologyMetrics(
      slant: isRightSlant
          ? 'Forward-leaning stroke flow indicating strong operational drive, external responsiveness, and a tendency to push for rapid execution.'
          : 'Controlled vertical-to-measured stroke stance reflecting emotional restraint, analytical distance, and selective compliance in corporate workflows.',
      pressure: isFirmPressure
          ? 'Firm, decisive pen pressure into the paper surface, signaling strong willpower and stamina under pressure, paired with a tendency toward stubbornness when challenged.'
          : 'Measured-to-adaptive stroke pressure suggesting cognitive agility, though potentially vulnerable to energy depletion in prolonged high-conflict environments.',
      baseline: baselineEn,
      size:
          'Compact, function-oriented letter proportions prioritizing concrete operational execution and factual clarity over decorative self-presentation.',
      zones:
          'Balanced upper-to-middle zone distribution combining conceptual planning with day-to-day practical task implementation.',
      connectivity: isConnected
          ? 'Continuous, linked stroke transitions indicating sequential cause-and-effect reasoning and structured follow-through.'
          : 'Segmented stroke transitions combined with deliberate spacing, indicating rapid intuitive problem-solving paired with a preference for operational autonomy.',
      marginsAndSpacing:
          'Deliberate left-margin alignment and clear vertical spacing demonstrating structured prioritization, time awareness, and firm personal boundaries.',
      signatureGeometry: mode == AnalysisMode.handwriting
          ? 'While no standalone formal signature is present, decisive underlining, exclamation marks, and target framing act as operational emphasis gestures demanding clarity and execution focus.'
          : 'Structured signature geometry projecting a composed, self-reliant professional persona that guards internal vulnerabilities closely.',
    );

    final spectrumEn = CorporateSpectrum(
      manageability:
          'Selective & Rational Compliance: Tends to align well when objectives and rationale are transparent, but carries a risk of internal resistance or disengagement under rigid micro-management.',
      roleArchetype:
          'Hands-On Operational Driver (Doer / Directive Executor): Strongly oriented toward tangible delivery and structured execution rather than superficial self-promotion.',
      resilience:
          'Task-Resilient with Defensive Guardrails: Maintains operational focus under deadline stress, though prolonged organizational ambiguity may trigger guarded or overly blunt communication.',
      discipline: isSignatureOnly
          ? 'External Ambition Projection (Signature-Only Scope): Isolated signature strokes reflect outward authority posture; multi-line handwriting is recommended to confirm daily operational follow-through.'
          : 'High Internal Structure & Prioritization: Demonstrates strong self-organization and target tracking, with a low tolerance for chaotic or poorly defined workflows.',
    );

    return HrCandidateReport(
      id: _generateId(telemetry.sha256Hash),
      imageHash: telemetry.sha256Hash,
      createdAt: DateTime.now(),
      mode: mode,
      targetRole: targetRole,
      candidateLabel: candidateLabel,
      localeCode: localeCode,
      observedMetrics: observedEn,
      corporateSpectrum: spectrumEn,
      executiveSummary:
          'The analyzed stroke mechanics ($candidateLabel) point to a candidate profile defined by structured execution habits alongside distinct autonomy boundaries that require thoughtful management. '
          'Rather than projecting passive compliance, the physical stroke pressure and spatial layout suggest an individual who actively structures their workload and expects rationality and clarity from leadership.'
          '${isSignatureOnly ? " Note: Per classical graphology principles, an isolated signature reflects interview persona and authority projection rather than daily routine execution; pair with a handwriting sample for full operational verification." : ""}\n\n'
          'From a talent acquisition perspective, this profile is most likely to thrive in roles with clear accountability metrics and operational ownership. '
          'Conversely, environments characterized by heavy micro-management, shifting political priorities, or vague authority lines carry a heightened risk of friction, impatience, or defensive withdrawal.',
      comparativeSynthesis: mode == AnalysisMode.combined
          ? 'Comparing spontaneous operational notes with external signature framing suggests a candidate capable of presenting a composed, disciplined demeanor in interviews while harboring a low threshold for inefficiency in daily operations.'
          : '',
      dimensions: HrDimensions(
        discipline: isSignatureOnly
            ? 'In scientific graphology, an isolated signature represents projected ambition, status boundaries, and outer decisiveness rather than day-to-day administrative follow-through. '
                'The firm stroke framing indicates a desire to project competence and self-command during high-visibility interactions. '
                'However, verify through work-sample tests whether routine task patience matches this confident outward emblem. '
                'For a complete assessment of daily organization, request 6–8 spontaneous lines of handwriting in Combined mode.'
            : 'Margin discipline and spatial organization indicate a strong tendency toward self-directed planning and structured task completion. '
                'Paragraphic emphasis markers show a habit of isolating key deliverables and numerical targets without waiting for external prompting. '
                'However, when established plans are abruptly disrupted by poorly communicated changes, the candidate may exhibit rigidity or frustration. '
                'They are likely to hold both themselves and surrounding workflows to exacting operational standards.',
        manageability:
            'Rather than exhibiting unconditional compliance, this profile tends to evaluate leadership directives through a lens of practical logic and efficiency. '
            'When managed via clear KPIs and mutual respect, corporate alignment is likely to be strong and dependable. '
            'Under intrusive micro-management or arbitrary authority, there is a notable risk of quiet resistance or insistence on their own methodology. '
            'Clear role boundaries and transparent decision rationale are essential for smooth onboarding.',
        roleNature:
            'Stroke density and middle-zone focus align closely with a hands-on executor and operational driver rather than a purely theatrical presenter. '
            'The candidate is inclined to translate abstract strategy into concrete action items and measurable milestones. '
            'In leadership scenarios, they are more likely to lead through demanding standards and direct follow-up than through soft diplomatic persuasion. '
            'Purely repetitive roles with zero decision latitude may quickly lead to restlessness.',
        resilience:
            'Under technical or deadline pressure, stroke consistency suggests solid stamina and the capacity to remain task-focused. '
            'However, interpersonal politics, chronic ambiguity, or unacknowledged effort may trigger a guarded, overly direct defensive posture. '
            'Rather than displaying overt emotional fragility, stress is more likely to surface as impatience, bluntness, or reluctance to delegate. '
            'Sustained performance benefits from objective feedback loops and predictable escalation paths.',
        teamEgo:
            'Word spacing and vertical alignment point to professional distance, clear ego boundaries, and a preference for competence-based collaboration. '
            'While reliable alongside high-ownership peers, the candidate may show low patience for disorganized or slow-moving teammates. '
            'When their domain expertise is challenged without data, defensive or overly critical responses are a potential risk. '
            'Peer collaboration should be evaluated for diplomatic flexibility during cross-functional disagreements.',
        redFlags:
            'Potential Watch-Outs: (1) Risk of delegation hesitancy or impatience with slower team members; (2) Friction under heavy micro-management or ambiguous reporting lines; (3) Tendency toward overly blunt communication under prolonged KPI stress.\n'
            'Recommended Behavioral Interview Questions:\n'
            '• "Tell me about a time you strongly disagreed with a manager\'s directive—how did you handle it and what was the outcome?"\n'
            '• "How do you manage shared deliverables when a colleague consistently fails to meet your pace or quality bar?"\n'
            '• "Describe a situation where project priorities changed abruptly at the last minute—how did you adapt?"',
      ),
      isLiveAi: isLiveAi,
    );
  }
}
