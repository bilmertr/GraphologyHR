// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Swedish (`sv`).
class AppLocalizationsSv extends AppLocalizations {
  AppLocalizationsSv([String locale = 'sv']) : super(locale);

  @override
  String get appTitle => 'Graphology HR';

  @override
  String get appSubtitle =>
      'Företagsbedömning av Kandidatens Självdisciplin, Resiliens & Rollpassning';

  @override
  String get navStudio => 'Kandidatanalys';

  @override
  String get navArchive => 'Arkiv';

  @override
  String get navSettings => 'Inställningar';

  @override
  String get candidateContextTitle => 'KANDIDAT & MÅLROLL (VALFRITT)';

  @override
  String get candidateNameHint =>
      'Kandidatkod eller namn (t.ex. Kandidat #104)';

  @override
  String get targetRoleLabel => 'Målrollsprofil';

  @override
  String get roleGeneral => 'Allmänt Företag';

  @override
  String get roleLeadership => 'Ledarskap / Chef';

  @override
  String get roleExecution => 'Operativ / Utförare (Doer)';

  @override
  String get roleSales => 'Försäljning & Kommunikation';

  @override
  String get roleTechnical => 'Teknisk / Specialist';

  @override
  String get modeSelectorLabel => 'VÄLJ BEDÖMNINGSLÄGE';

  @override
  String get modeHandwritingTitle =>
      'Handstil (Arbetsdisciplin & Genomförande)';

  @override
  String get modeHandwritingDesc =>
      'Självdisciplin, organisationsförmåga, stresstålighet och operativ leverans';

  @override
  String get modeSignatureTitle =>
      'Namnteckning (Företagspersona, Auktoritet & Ego)';

  @override
  String get modeSignatureDesc =>
      'Exekutiv närvaro, ambition, egogränser och auktoritetsanspråk';

  @override
  String get modeCombinedTitle =>
      'Handstil + Namnteckning (Verklig Arbetsstil vs. Intervjufasad)';

  @override
  String get modeCombinedDesc =>
      'Jämför kandidatens polerade intervjufasad med den faktiska arbetsdisciplinen';

  @override
  String get uploadHandwritingTitle =>
      'Foto av Kandidatens Handstil / Anteckning';

  @override
  String get uploadSignatureTitle => 'Foto av Kandidatens Namnteckning';

  @override
  String get captureGuideHandwriting =>
      'Ladda upp ett tydligt foto av kandidatens handskrivna anteckning.';

  @override
  String get captureGuideSignature =>
      'Ladda upp ett tydligt foto av kandidatens namnteckning.';

  @override
  String get cameraButton => 'Kamera';

  @override
  String get galleryButton => 'Fil / Galleri';

  @override
  String get analyzeButton => 'Analysera Företagspassning & Karaktär';

  @override
  String get analyzingWait =>
      'Utvärderar självdisciplin, styrbarhet, stresstålighet och rollpassning...';

  @override
  String get disclaimerShortText =>
      'HR-Ansvarsfriskrivning & Integritet: Endast ett stöd vid intervjuer; AI kan göra fel. Fatta aldrig anställningsbeslut enbart utifrån denna rapport. Ingen data sparas.';

  @override
  String get disclaimerLinkLabel => 'Läs HR-Beslutsstöd & Noll-Datalagring';

  @override
  String get disclaimerDialogTitle =>
      'HR-Ansvarsfriskrivning & Noll-Datalagring';

  @override
  String get disclaimerDialogBody =>
      '1. Kompletterande Intervjustöd & AI-Felmarginal:\nDenna rapport är endast ett hjälpmedel för att ta fram kontrollfrågor inför intervjuer. AI kan ha fel; fatta aldrig ett positivt eller negativt anställningsbeslut enbart baserat på rapporten.\n\n2. Noll Datalagring (GDPR):\nUppladdade bilder och kandidatuppgifter sparas aldrig på servrar utan bearbetas endast tillfälligt i minnet.';

  @override
  String get reportSummaryTitle => 'Exekutiv Sammanfattning & Rollpassning';

  @override
  String get spectrumSectionTitle => '4-Axlad Företagsprofil';

  @override
  String get axisManageability => 'Styrbarhet & Regelefterlevnad';

  @override
  String get axisRoleType => 'Operativ Rollarketyp';

  @override
  String get axisResilience => 'Presstålighet (Resilient vs. Sårbar)';

  @override
  String get axisDiscipline => 'Självdisciplin & Organisation';

  @override
  String get reportComparisonTitle =>
      'Verklig Arbetsstil (Skrift) vs. Intervjufasad (Namnteckning)';

  @override
  String get reportDimensionsTitle => '6-Dimensionell HR-Bedömning';

  @override
  String get dimDiscipline =>
      '1. Självdisciplin, Organisationsförmåga & Slutförande';

  @override
  String get dimManageability =>
      '2. Förhållningssätt till Auktoritet & Styrbarhet (Rebellisk vs. Ledbar)';

  @override
  String get dimRoleNature =>
      '3. Rollarketyp: Ledare, Praktisk Utförare (Doer) eller Fasadperson?';

  @override
  String get dimResilience =>
      '4. Stresstålighet (Resilience) vs. Emotionell Sårbarhet';

  @override
  String get dimTeamEgo => '5. Teamkommunikation, Ego & Konfliktstil';

  @override
  String get dimRedFlags =>
      '6. Rekryteringsrisker (Red Flags) & Intervjufrågor';

  @override
  String get physicalMetricsTitle => 'Observerade Fysiska Spår';

  @override
  String get metricSlant => 'Lutning';

  @override
  String get metricPressure => 'Penntryck';

  @override
  String get metricBaseline => 'Radriktning';

  @override
  String get metricSize => 'Storlek';

  @override
  String get metricZones => 'Zoner';

  @override
  String get metricConnectivity => 'Bindningar';

  @override
  String get metricSpacing => 'Ordning & Marginaler';

  @override
  String get metricSignatureStyle => 'Signatur & Betoning';

  @override
  String get archiveTitle => 'Kandidatarkiv';

  @override
  String get archiveEmpty => 'Inga kandidatbedömningar arkiverade ännu.';

  @override
  String get settingsTitle => 'HR-Inställningar';

  @override
  String get settingsLanguage => 'Rapportspråk';

  @override
  String get settingsTheme => 'Mörkt Läge';

  @override
  String get closeButton => 'Stäng';
}
