// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get appTitle => 'Graphology HR';

  @override
  String get appSubtitle =>
      'Kurumsal Aday Mizaç, İç Disiplin & Rol Uyumu Analizi';

  @override
  String get navStudio => 'Aday Analizi';

  @override
  String get navArchive => 'Aday Arşivi';

  @override
  String get navSettings => 'Ayarlar';

  @override
  String get candidateContextTitle =>
      'ADAY & HEDEF POZİSYON BİLGİSİ (OPSİYONEL)';

  @override
  String get candidateNameHint =>
      'Aday Kodu veya Adı (Örn: Aday #104 - Operasyon Yöneticisi)';

  @override
  String get targetRoleLabel => 'Hedeflenen Rol Profili';

  @override
  String get roleGeneral => 'Genel Kurumsal';

  @override
  String get roleLeadership => 'Yönetici / Liderlik';

  @override
  String get roleExecution => 'Operasyon / İcracı (İşi Yapan)';

  @override
  String get roleSales => 'Satış & İletişim';

  @override
  String get roleTechnical => 'Teknik / Analitik Uzman';

  @override
  String get modeSelectorLabel => 'DEĞERLENDİRME MODUNU SEÇİN';

  @override
  String get modeHandwritingTitle => 'El Yazısı (İç Disiplin & İş Yapış Tarzı)';

  @override
  String get modeHandwritingDesc =>
      'İç disiplin, organizasyon yeteneği, stres direnci (resilience) ve mutfakta iş bitiricilik';

  @override
  String get modeSignatureTitle => 'İmza (Kurumsal Persona, Otorite & Ego)';

  @override
  String get modeSignatureDesc =>
      'Temsil gücü, özgüven, otorite algısı, ego sınırları ve savunma kalkanları';

  @override
  String get modeCombinedTitle =>
      'El Yazısı + İmza (Gerçek İş Alışkanlığı vs. Mülakat Maskesi)';

  @override
  String get modeCombinedDesc =>
      'Adayın mülakatta sunduğu kurumsal vitrin ile gerçek iş disiplini arasındaki uyum veya çelişki';

  @override
  String get uploadHandwritingTitle => 'Adayın El Yazısı / Not Fotoğrafı';

  @override
  String get uploadSignatureTitle => 'Adayın İmza Fotoğrafı';

  @override
  String get captureGuideHandwriting =>
      'Adayın başvuru notu, mülakat yazısı veya el yazısı örneğinin net fotoğrafını yükleyin.';

  @override
  String get captureGuideSignature =>
      'Adayın imzasının yer aldığı sayfanın net fotoğrafını yükleyin.';

  @override
  String get cameraButton => 'Kamera';

  @override
  String get galleryButton => 'Dosya / Galeri';

  @override
  String get analyzeButton => 'Adayın Kurumsal Uyum & Karakterini Analiz Et';

  @override
  String get analyzingWait =>
      'Adayın iç disiplini, yönetilebilirliği, stres direnci ve kurumsal rol uyumu inceleniyor...';

  @override
  String get disclaimerShortText =>
      'İK Yasal Uyarı & KVKK: Bu rapor yalnızca mülakat karar destek amaçlıdır; yapay zeka hata yapabilir. Tek başına olumlu veya olumsuz işe alım kararı vermek için kullanılmamalıdır. Görseller ve aday verileri sunucuda kesinlikle saklanmaz, yalnızca anlık analiz için kullanılır.';

  @override
  String get disclaimerLinkLabel =>
      'İK Karar Destek & Veri Gizliliği Beyanını Oku';

  @override
  String get disclaimerDialogTitle =>
      'İK Karar Destek Sorumluluk Reddi & Veri Gizliliği';

  @override
  String get disclaimerDialogBody =>
      '1. Karar Destek Niteliği ve Yapay Zeka Hata Payı:\nBu uygulama tarafından üretilen grafolojik ve davranışsal analizler, İnsan Kaynakları departmanlarına ve yöneticilere işe alım sürecinde yardımcı bir perspektif ve mülakat doğrulama soruları sunmak amacıyla geliştirilmiştir. Yapay zeka modelleri ve grafolojik çıkarımlar yanılabilir. Bir aday hakkında yalnızca bu rapora bakarak doğrudan olumlu veya olumsuz işe alım kararı vermek doğru değildir; buradaki gözlemler mutlaka yapılandırılmış mülakatlar, vaka çalışmaları ve referans kontrolleriyle birlikte değerlendirilmelidir.\n\n2. Sıfır Veri Saklama (KVKK & Gizlilik Güvencesi):\nYüklenen el yazısı/imza görselleri ve adaylarla ilgili bilgiler sunucularımızda kesinlikle saklanmaz, kaydedilmez ve üçüncü kişilerle paylaşılmaz. Veriler yalnızca anlık analiz üretimi için işlenir ve analiz tamamlandığı anda sunucu belleğinden silinir.';

  @override
  String get reportSummaryTitle => 'Yönetici Özeti & Kurumsal Uyum Sentezi';

  @override
  String get spectrumSectionTitle => '4 Eksenli Kurumsal Karakter Spektrumu';

  @override
  String get axisManageability => 'Yönetilebilirlik & Kurumsal Uyum';

  @override
  String get axisRoleType => 'Operasyonel Rol Doğası';

  @override
  String get axisResilience =>
      'Baskı Altında Direnç (Resilience vs. Kırılganlık)';

  @override
  String get axisDiscipline => 'İç Disiplin & Organizasyon Yeteneği';

  @override
  String get reportComparisonTitle =>
      'Gerçek İş Alışkanlığı (Yazı) vs. Mülakat Maskesi (İmza)';

  @override
  String get reportDimensionsTitle => '6 Boyutlu Kurumsal İK Karakter Tahlili';

  @override
  String get dimDiscipline =>
      '1. İç Disiplin, Organizasyon Yeteneği & İş Bitiricilik';

  @override
  String get dimManageability =>
      '2. Otoriteyle İlişki, Kurumsal Uyum & Yönetilebilirlik (Asi mi, Yönetilir mi?)';

  @override
  String get dimRoleNature =>
      '3. Rol Arketipi: Lider mi, İşi Yapan (İcracı) mı, Vitrin Odaklı mı?';

  @override
  String get dimResilience =>
      '4. Stres Direnci (Resilience) vs. Duygusal Kırılganlık (Fragility)';

  @override
  String get dimTeamEgo =>
      '5. Takım İçi İletişim, Ego Sınırları & Çatışma Tarzı';

  @override
  String get dimRedFlags =>
      '6. Dikkat Edilmesi Gereken Riskler (Red Flags) & Mülakat Soruları';

  @override
  String get physicalMetricsTitle => 'Ölçülen Fiziksel Kanıtlar';

  @override
  String get metricSlant => 'Harf Eğimi';

  @override
  String get metricPressure => 'Kalem Baskısı';

  @override
  String get metricBaseline => 'Satır İstikameti';

  @override
  String get metricSize => 'Harf Boyutu';

  @override
  String get metricZones => 'Bölge Baskınlığı';

  @override
  String get metricConnectivity => 'Harf Bağlantıları';

  @override
  String get metricSpacing => 'Alan & Boşluk Dengesi';

  @override
  String get metricSignatureStyle => 'İmza & Vurgu Yapısı';

  @override
  String get archiveTitle => 'Aday Dosyaları Arşivi';

  @override
  String get archiveEmpty =>
      'Bu cihazda henüz arşivlenmiş bir aday analizi bulunmuyor.';

  @override
  String get settingsTitle => 'Kurumsal İK Ayarları';

  @override
  String get settingsLanguage => 'Analiz & Rapor Dili (10 Dil)';

  @override
  String get settingsTheme => 'Koyu Tema';

  @override
  String get closeButton => 'Kapat';
}
