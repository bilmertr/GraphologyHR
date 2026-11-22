import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/network/api_constants.dart';
import '../../../core/theme/japandi_colors.dart';
import '../../../l10n/app_localizations.dart';
import '../../paywall/providers/paywall_provider.dart';
import '../../settings/providers/settings_provider.dart';
import '../models/analysis_mode.dart';
import '../providers/hr_analysis_provider.dart';
import 'hr_disclaimer_dialog.dart';
import 'hr_report_detail_screen.dart';

class HrStudioScreen extends ConsumerStatefulWidget {
  const HrStudioScreen({super.key});

  @override
  ConsumerState<HrStudioScreen> createState() => _HrStudioScreenState();
}

class _HrStudioScreenState extends ConsumerState<HrStudioScreen> {
  final ImagePicker _picker = ImagePicker();
  final TextEditingController _candidateController = TextEditingController();

  @override
  void dispose() {
    _candidateController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final file = await _picker.pickImage(
        source: source,
        maxWidth: 1600,
        imageQuality: 86,
      );
      if (file == null) return;
      final bytes = await file.readAsBytes();
      if (!mounted) return;
      ref.read(hrAnalysisProvider.notifier).setImageBytes(bytes);
    } catch (_) {
      if (!mounted) return;
      final lang = ref.read(settingsProvider).languageCode;
      final msg = switch (lang) {
        'tr' => 'Seçilen dosya geçerli bir görsel olarak yüklenemedi. Lütfen JPEG veya PNG yükleyin.',
        'da' => 'Den valgte fil kunne ikke indlæses som billede. Brug venligst JPEG eller PNG.',
        'de' => 'Die ausgewählte Datei konnte nicht als Bild geladen werden. Bitte JPEG oder PNG verwenden.',
        _ => 'Could not load the selected file as an image. Please upload a valid JPEG or PNG photo.',
      };
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(msg), behavior: SnackBarBehavior.floating),
      );
    }
  }

  void _showImageZoomDialog(BuildContext context, Uint8List bytes) {
    showDialog<void>(
      context: context,
      builder: (ctx) => Dialog(
        backgroundColor: Colors.black87,
        insetPadding: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: InteractiveViewer(
                minScale: 0.8,
                maxScale: 4.5,
                child: Image.memory(bytes, fit: BoxFit.contain),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: IconButton.filledTonal(
                onPressed: () => Navigator.of(ctx).pop(),
                icon: const Icon(Icons.close),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _submitAnalysis() async {
    final quota = ref.read(quotaProvider);
    if (ApiConstants.enablePaywallInUi && !quota.canAnalyze) {
      return;
    }

    final localeCode = ref.read(settingsProvider).languageCode;
    final report = await ref
        .read(hrAnalysisProvider.notifier)
        .runAnalysis(localeCode: localeCode);

    if (report != null && mounted) {
      if (report.isLiveAi) {
        await ref.read(quotaProvider.notifier).consumeValidAnalysis();
      }
      if (!mounted) return;
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => HrReportDetailScreen(report: report),
        ),
      );
    }
  }

  String _roleLabel(AppLocalizations l10n, TargetRoleProfile role) {
    return switch (role) {
      TargetRoleProfile.general => l10n.roleGeneral,
      TargetRoleProfile.leadership => l10n.roleLeadership,
      TargetRoleProfile.execution => l10n.roleExecution,
      TargetRoleProfile.sales => l10n.roleSales,
      TargetRoleProfile.technical => l10n.roleTechnical,
    };
  }

  String _localizedRejectionText(
    String lang,
    String reasonKey,
    String? customMessage,
  ) {
    if (customMessage != null && customMessage.trim().isNotEmpty) {
      return customMessage.trim();
    }
    switch (reasonKey) {
      case 'BLANK_OR_NO_INK':
        return switch (lang) {
          'tr' =>
            'Yüklenen görselde analiz edilebilecek yeterli el yazısı veya imza izi tespit edilemedi. Lütfen boş veya çok silik olmayan, net bir örnek yükleyin.',
          'da' =>
            'Der blev ikke fundet nok håndskrift eller underskrift på billedet. Upload venligst et tydeligt, læseligt billede.',
          'de' =>
            'Auf dem Bild wurde zu wenig Handschrift oder Unterschrift erkannt. Bitte laden Sie ein klares Dokumentfoto hoch.',
          _ =>
            'Insufficient handwriting or signature ink strokes detected in the uploaded image. Please upload a clearer, higher-contrast photo.',
        };
      case 'NOT_A_DOCUMENT_OR_TOO_DARK':
        return switch (lang) {
          'tr' =>
            'Yüklenen fotoğraf aydınlatma veya kontrast açısından geçerli bir kağıt belge gibi görünmüyor. Lütfen kağıdın tamamının iyi aydınlatıldığı net bir fotoğraf çekin.',
          'da' =>
            'Billedet ligner ikke et tydeligt oplyst papirdokument (for mørkt eller for kraftige farver). Prøv et foto i bedre belysning.',
          'de' =>
            'Das Foto wirkt nicht wie ein gut beleuchtetes Papierdokument (zu dunkel oder zu kontrastarm). Bitte bei gutem Licht neu aufnehmen.',
          _ =>
            'The uploaded photo does not resemble a well-lit paper document (too dark or overly saturated background). Please retake in even lighting.',
        };
      case 'IMAGE_EMPTY_OR_TOO_LARGE':
        return switch (lang) {
          'tr' =>
            'Görsel dosyası boş veya izin verilen 18 MB boyut sınırını aşıyor. Lütfen daha küçük bir JPEG/PNG yükleyin.',
          'da' =>
            'Billedfilen er tom eller overskrider grænsen på 18 MB. Upload venligst en mindre JPEG- eller PNG-fil.',
          'de' =>
            'Die Bilddatei ist leer oder größer als 18 MB. Bitte laden Sie eine kleinere JPEG-/PNG-Datei hoch.',
          _ =>
            'The uploaded image file is empty or exceeds the 18 MB size limit. Please select a standard JPEG or PNG photo.',
        };
      case 'UNDECODABLE_OR_TOO_SMALL':
        return switch (lang) {
          'tr' =>
            'Görsel formatı okunamadı veya çözünürlük çok düşük. Lütfen standart bir JPEG/PNG fotoğraf yükleyin.',
          'da' =>
            'Billedformatet kunne ikke læses, eller opløsningen er for lav. Brug venligst en standard JPEG/PNG-fil.',
          'de' =>
            'Das Bildformat ist ungültig oder die Auflösung zu gering. Bitte eine normale JPEG- oder PNG-Datei wählen.',
          _ =>
            'Unable to decode the image format or resolution is too low. Please upload a sharp JPEG or PNG photo.',
        };
      case 'AI_REJECTED_NON_INK':
        return switch (lang) {
          'tr' =>
            'Görsel AI doğrulayıcı bu fotoğrafta gerçek el yazısı veya el ile atılmış bir imza tespit edemedi. Dijital/bilgisayar yazısı yerine kalemle yazılmış kağıt örneği yükleyin.',
          'da' =>
            'Den visuelle AI-kontrol registrerede ingen ægte håndskrift eller håndskrevet signatur. Upload venligst håndskrevne noter på papir frem for trykt tekst.',
          'de' =>
            'Die visuelle KI-Prüfung konnte keine echte Handschrift oder handschriftliche Signatur erkennen (stattdessen z. B. gedruckter Text). Bitte ein handgeschriebenes Blatt hochladen.',
          _ =>
            'Visual AI validation could not confirm genuine handwriting or a handwritten signature (e.g., digitally typed text or non-document photo). Please upload real pen-on-paper writing.',
        };
      default:
        return switch (lang) {
          'tr' =>
            'Örnek doğrulanamadı. Lütfen el yazısının ve/veya imzanın net göründüğü başka bir fotoğraf yükleyin.',
          'da' =>
            'Prøven kunne ikke valideres. Upload venligst et andet tydeligt foto af håndskrift eller underskrift.',
          'de' =>
            'Die Probe konnte nicht validiert werden. Bitte laden Sie ein anderes klares Foto von Handschrift oder Unterschrift hoch.',
          _ =>
            'The sample could not be validated. Please upload another clear photo of handwriting or a signature on paper.',
        };
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final state = ref.watch(hrAnalysisProvider);
    final lang = ref.watch(settingsProvider).languageCode;
    final isCompact = MediaQuery.of(context).size.width < 520;

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: isCompact ? 16 : 24,
        vertical: isCompact ? 16 : 24,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 780),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header + Quick Language Switcher Pill
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      l10n.appTitle,
                      style: isCompact
                          ? theme.textTheme.headlineMedium
                          : theme.textTheme.displaySmall,
                    ),
                  ),
                  const SizedBox(width: 8),
                  PopupMenuButton<String>(
                    tooltip: l10n.settingsLanguage,
                    initialValue: lang,
                    onSelected: (code) =>
                        ref.read(settingsProvider.notifier).setLanguage(code),
                    itemBuilder: (_) => AppSettingsState.supportedLanguageCodes
                        .map(
                          (code) => PopupMenuItem<String>(
                            value: code,
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 28,
                                  child: Text(
                                    code.toUpperCase(),
                                    style:
                                        theme.textTheme.labelMedium?.copyWith(
                                      color: JapandiColors.brassGold,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: Text(
                                    AppSettingsState
                                            .languageDisplayNames[code] ??
                                        code,
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      fontWeight: code == lang
                                          ? FontWeight.w700
                                          : FontWeight.w500,
                                    ),
                                  ),
                                ),
                                if (code == lang)
                                  const Icon(
                                    Icons.check,
                                    size: 16,
                                    color: JapandiColors.brassGold,
                                  ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: theme.cardColor,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: JapandiColors.brassGold.withValues(alpha: 0.55),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.language_outlined,
                            size: 15,
                            color: JapandiColors.brassGold,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            lang.toUpperCase(),
                            style: theme.textTheme.labelMedium?.copyWith(
                              color: JapandiColors.brassGold,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(width: 2),
                          const Icon(
                            Icons.keyboard_arrow_down,
                            size: 16,
                            color: JapandiColors.brassGold,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                l10n.appSubtitle,
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),

              // Prominent HR Disclaimer & Zero-Data-Retention Link
              const HrDisclaimerBanner(),
              const SizedBox(height: 20),

              // Candidate Dossier Context Card (Optional Name/Code + Target Role)
              Card(
                child: Padding(
                  padding: EdgeInsets.all(isCompact ? 16 : 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.candidateContextTitle,
                        style: theme.textTheme.labelMedium?.copyWith(
                          letterSpacing: 0.9,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: _candidateController,
                        maxLength: 60,
                        onChanged: (val) => ref
                            .read(hrAnalysisProvider.notifier)
                            .setCandidateLabel(val),
                        decoration: InputDecoration(
                          counterText: '',
                          hintText: l10n.candidateNameHint,
                          prefixIcon: const Icon(
                            Icons.badge_outlined,
                            color: JapandiColors.brassGold,
                          ),
                          suffixIcon: _candidateController.text.isNotEmpty
                              ? IconButton(
                                  icon: const Icon(Icons.clear, size: 18),
                                  onPressed: () {
                                    _candidateController.clear();
                                    ref
                                        .read(hrAnalysisProvider.notifier)
                                        .setCandidateLabel('');
                                    setState(() {});
                                  },
                                )
                              : null,
                          filled: true,
                          fillColor: theme.scaffoldBackgroundColor,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: theme.colorScheme.outline,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: theme.colorScheme.outline,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        l10n.targetRoleLabel,
                        style: theme.textTheme.labelMedium,
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: TargetRoleProfile.values.map((role) {
                          final selected = state.targetRole == role;
                          return ChoiceChip(
                            label: Text(_roleLabel(l10n, role)),
                            selected: selected,
                            selectedColor:
                                JapandiColors.brassGold.withValues(alpha: 0.22),
                            onSelected: (_) => ref
                                .read(hrAnalysisProvider.notifier)
                                .setTargetRole(role),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Mode Selector
              Text(
                l10n.modeSelectorLabel.toUpperCase(),
                style: theme.textTheme.labelMedium?.copyWith(
                  letterSpacing: 1.1,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              _ModeCard(
                title: l10n.modeHandwritingTitle,
                subtitle: l10n.modeHandwritingDesc,
                icon: Icons.article_outlined,
                selected: state.mode == AnalysisMode.handwriting,
                onTap: () => ref
                    .read(hrAnalysisProvider.notifier)
                    .setMode(AnalysisMode.handwriting),
              ),
              const SizedBox(height: 10),
              _ModeCard(
                title: l10n.modeSignatureTitle,
                subtitle: l10n.modeSignatureDesc,
                icon: Icons.draw_outlined,
                selected: state.mode == AnalysisMode.signature,
                onTap: () => ref
                    .read(hrAnalysisProvider.notifier)
                    .setMode(AnalysisMode.signature),
              ),
              const SizedBox(height: 10),
              _ModeCard(
                title: l10n.modeCombinedTitle,
                subtitle: l10n.modeCombinedDesc,
                icon: Icons.compare_arrows_outlined,
                selected: state.mode == AnalysisMode.combined,
                onTap: () => ref
                    .read(hrAnalysisProvider.notifier)
                    .setMode(AnalysisMode.combined),
              ),
              const SizedBox(height: 16),

              // Scientific HR Graphology Sample Collection Guide
              _HrSamplingGuideCard(
                locale: lang,
                mode: state.mode,
              ),
              const SizedBox(height: 16),

              // Unified Photo Upload Card
              _buildUploadCard(context, l10n, state, lang),

              // Rejection Error Banner if invalid sample
              if (state.rejectionError != null) ...[
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: JapandiColors.terracottaClay.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: JapandiColors.terracottaClay),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.error_outline,
                        color: JapandiColors.terracottaClay,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          _localizedRejectionText(
                            lang,
                            state.rejectionError!,
                            state.rejectionMessage,
                          ),
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: JapandiColors.terracottaClay,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],

              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: state.canSubmit ? _submitAnalysis : null,
                icon: state.isLoading
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Icon(Icons.fact_check_outlined, size: 20),
                label: Text(
                  state.isLoading ? l10n.analyzingWait : l10n.analyzeButton,
                ),
              ),
              const SizedBox(height: 28),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUploadCard(
    BuildContext context,
    AppLocalizations l10n,
    HrAnalysisState state,
    String lang,
  ) {
    final theme = Theme.of(context);
    final isSignatureOnly = state.mode == AnalysisMode.signature;
    final cardTitle = isSignatureOnly
        ? l10n.uploadSignatureTitle
        : l10n.uploadHandwritingTitle;
    final cardHint = isSignatureOnly
        ? l10n.captureGuideSignature
        : l10n.captureGuideHandwriting;
    final clearTooltip = switch (lang) {
      'tr' => 'Görseli Kaldır',
      'da' => 'Fjern foto',
      'de' => 'Foto entfernen',
      _ => 'Remove Photo',
    };
    final zoomHint = switch (lang) {
      'tr' => 'Okunaklılığı kontrol etmek için görsele dokunup yakınlaştırın',
      'da' => 'Tryk på billedet for at zoome og kontrollere skriften',
      'de' => 'Zum Vergrößern und Prüfen auf das Bild tippen',
      _ => 'Tap image to zoom & inspect stroke clarity',
    };

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.document_scanner_outlined,
                  color: JapandiColors.brassGold,
                  size: 20,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    cardTitle,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                if (state.imageBytes != null) ...[
                  const Icon(
                    Icons.check_circle,
                    color: JapandiColors.bambooGreenLight,
                    size: 20,
                  ),
                  const SizedBox(width: 4),
                  IconButton(
                    visualDensity: VisualDensity.compact,
                    tooltip: clearTooltip,
                    onPressed: () =>
                        ref.read(hrAnalysisProvider.notifier).clearImage(),
                    icon: Icon(
                      Icons.close,
                      size: 19,
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 6),
            Text(cardHint, style: theme.textTheme.bodyMedium),
            const SizedBox(height: 16),
            if (state.imageBytes != null) ...[
              InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () => _showImageZoomDialog(context, state.imageBytes!),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxHeight: 220),
                        child: Image.memory(
                          state.imageBytes!,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.zoom_in_outlined,
                          size: 14,
                          color: JapandiColors.brassGold,
                        ),
                        const SizedBox(width: 4),
                        Flexible(
                          child: Text(
                            zoomHint,
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: JapandiColors.brassGold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
            ],
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _pickImage(ImageSource.camera),
                    icon: const Icon(Icons.camera_alt_outlined, size: 18),
                    label: Text(l10n.cameraButton),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _pickImage(ImageSource.gallery),
                    icon: const Icon(Icons.photo_library_outlined, size: 18),
                    label: Text(l10n.galleryButton),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _HrSamplingGuideCard extends StatelessWidget {
  final String locale;
  final AnalysisMode mode;

  const _HrSamplingGuideCard({
    required this.locale,
    required this.mode,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final title = switch (locale) {
      'tr' => 'İK Mülakatı İçin Doğru El Yazısı Örneği Rehberi',
      'da' => 'Protokol for Håndskriftprøve ved Jobsamtale',
      'de' => 'Leitfaden zur Schriftproben-Erfassung im Interview',
      _ => 'HR Interview Handwriting Collection Protocol',
    };

    final body = switch (locale) {
      'tr' =>
        '• Çizgisiz A4 Kağıt Standartı: Çizgili veya kareli defterler satır istikametini yapay olarak hizalar; adayın kendi iç düzenini ve enerji kontrolünü görmek için mülakatta çizgisiz beyaz A4 kağıt verin (çizgili not yüklenirse motorumuz bunu algılayıp çizgiyle kurulan ilişkiyi analiz eder).\n'
            '• Doğaçlama İş Notu (6–10 Satır): Adaydan ezbere/kopyalanmış bir metin yerine "önceki rolündeki bir projeyi veya çalışma tarzını" kendi cümleleriyle yazıp altını imzalamasını isteyin.\n'
            '• İçerik-Körlüğü (Content-Blind) İlkesi: Yalnızca kalem hareket mekaniği (baskı, eğim, ritim, marjin) ölçülür; yazının konusu veya geçen kelimeler karakter analizini etkilemez.\n'
            '• Mod Sınırı Uyarısı: ${mode == AnalysisMode.signature ? "Şu an seçili olan Sadece İmza modu yalnızca adayın dış otorite iddiasını ve mülakat maskesini ölçer; günlük iş takibi ve iç disiplin için El Yazısı + İmza modu önerilir." : "El Yazısı + İmza modu, adayın gerçek iş alışkanlığı ile mülakat vitrini arasındaki farkı yakalamak için en güvenilir moddur."}',
      'da' =>
        '• Ulinjeret A4-papir: Linjeret papir styrer linjeføringen kunstigt; brug helst blankt hvidt A4-papir til at vurdere egen organisering (vores motor genkender dog linjeret papir og vurderer afvigelser fra linjen).\n'
            '• Spontan tekst (6–10 linjer): Bed kandidaten beskrive et projekt eller arbejdsstil med egne ord og underskrive under teksten.\n'
            '• Indholdsblindhed (Content-Blind): Kun penbevægelsens mekanik vurderes (tryk, hældning, rytme, marginer) — aldrig selve ordene eller emnet i noten.\n'
            '• Tilstandsgrænse: ${mode == AnalysisMode.signature ? "Kun Underskrift måler udelukkende ydre autoritet og samtale-persona; brug Håndskrift + Underskrift for daglig arbejdsdisciplin." : "Håndskrift + Underskrift giver højeste validitet ved at sammenligne daglig eksekvering med ydre facade."}',
      'de' =>
        '• Unliniertes A4-Papier: Linierte Hefte geben die Zeilenführung künstlich vor; nutzen Sie weißes A4-Papier (bei linierten Notizen erkennt unsere Engine dies automatisch).\n'
            '• Spontane Arbeitsnotiz (6–10 Zeilen): Bitten Sie um eine kurze freie Projektbeschreibung samt Unterschrift.\n'
            '• Inhaltsblindes Prinzip: Bewertet wird ausschließlich die Schreibmechanik (Druck, Neigung, Rhythmus, Ränder), niemals der Textinhalt.\n'
            '• Modus-Hinweis: ${mode == AnalysisMode.signature ? "Reine Unterschriftsanalyse erfasst nur das äußere Auftreten; wählen Sie Handschrift + Unterschrift für Arbeitsdisziplin." : "Handschrift + Unterschrift bietet die höchste Aussagekraft."}',
      _ =>
        '• Unlined A4 Paper Standard: Ruled notebook lines artificially stabilize baseline slope; provide unlined white A4 paper during interviews to observe authentic self-organization (if ruled notes are uploaded, our engine detects them and evaluates deviations relative to the rule).\n'
            '• Spontaneous Prompt (6–10 Lines): Ask the candidate to briefly describe a recent project or workflow in their own words and sign beneath it rather than copying printed text.\n'
            '• Content-Blind Principle: Only physical pen movement mechanics are evaluated (pressure, slant, rhythm, zones, margins)—never the semantic topic or words written in the note.\n'
            '• Mode Validity Note: ${mode == AnalysisMode.signature ? "Signature-Only mode measures projected authority and interview persona only; use Combined mode to assess daily operational discipline." : "Combined (Handwriting + Signature) mode provides the highest validity by contrasting daily execution habits against interview persona."}',
    };

    return Card(
      child: Theme(
        data: theme.copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
          childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
          leading: const Icon(
            Icons.menu_book_outlined,
            size: 19,
            color: JapandiColors.brassGold,
          ),
          title: Text(
            title,
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          children: [
            Text(
              body,
              style: theme.textTheme.bodySmall?.copyWith(height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}

class _ModeCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  const _ModeCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        decoration: BoxDecoration(
          color: selected
              ? JapandiColors.brassGold.withValues(alpha: 0.10)
              : theme.cardColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color:
                selected ? JapandiColors.brassGold : theme.colorScheme.outline,
            width: selected ? 1.5 : 1.0,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: selected
                  ? JapandiColors.brassGold
                  : theme.colorScheme.onSurface.withValues(alpha: 0.72),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: selected
                          ? JapandiColors.brassGold
                          : theme.colorScheme.onSurface,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(subtitle, style: theme.textTheme.bodyMedium),
                ],
              ),
            ),
            Icon(
              selected
                  ? Icons.radio_button_checked
                  : Icons.radio_button_unchecked,
              color: selected
                  ? JapandiColors.brassGold
                  : theme.colorScheme.outline,
            ),
          ],
        ),
      ),
    );
  }
}
