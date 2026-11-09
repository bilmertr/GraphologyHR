// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Danish (`da`).
class AppLocalizationsDa extends AppLocalizations {
  AppLocalizationsDa([String locale = 'da']) : super(locale);

  @override
  String get appTitle => 'Graphology HR';

  @override
  String get appSubtitle =>
      'Vurdering af Kandidatens Selvdisciplin, Robusthed og Rollematch';

  @override
  String get navStudio => 'Kandidatanalyse';

  @override
  String get navArchive => 'Arkiv';

  @override
  String get navSettings => 'Indstillinger';

  @override
  String get candidateContextTitle => 'KANDIDAT & MÅLROLLE (VALGFRIT)';

  @override
  String get candidateNameHint =>
      'Kandidatkode eller navn (f.eks. Kandidat #104)';

  @override
  String get targetRoleLabel => 'Målrolleprofil';

  @override
  String get roleGeneral => 'Generel Virksomhed';

  @override
  String get roleLeadership => 'Ledelse / Management';

  @override
  String get roleExecution => 'Drift / Udførende (Doer)';

  @override
  String get roleSales => 'Salg & Relationer';

  @override
  String get roleTechnical => 'Teknisk / Specialist';

  @override
  String get modeSelectorLabel => 'VÆLG VURDERINGSTILSTAND';

  @override
  String get modeHandwritingTitle =>
      'Håndskrift (Arbejdsdisciplin & Eksekvering)';

  @override
  String get modeHandwritingDesc =>
      'Selvdisciplin, organisatorisk evne, robusthed (resilience) og opfølgning';

  @override
  String get modeSignatureTitle =>
      'Underskrift (Virksomhedsprofil, Autoritet & Ego)';

  @override
  String get modeSignatureDesc =>
      'Gennemslagskraft, ambition, egogrænser og autoritet';

  @override
  String get modeCombinedTitle =>
      'Håndskrift + Underskrift (Reelle Arbejdsvaner vs. Interviewmaske)';

  @override
  String get modeCombinedDesc =>
      'Sammenligner kandidatens facade ved samtalen med den reelle arbejdsdisciplin';

  @override
  String get uploadHandwritingTitle => 'Kandidatens Håndskrift / Notat';

  @override
  String get uploadSignatureTitle => 'Kandidatens Underskrift';

  @override
  String get captureGuideHandwriting =>
      'Upload et tydeligt billede af kandidatens håndskrevne notat.';

  @override
  String get captureGuideSignature =>
      'Upload et tydeligt billede af kandidatens underskrift.';

  @override
  String get cameraButton => 'Kamera';

  @override
  String get galleryButton => 'Fil / Galleri';

  @override
  String get analyzeButton => 'Analyser Kandidatens Virksomhedsmatch';

  @override
  String get analyzingWait =>
      'Vurderer selvdisciplin, ledelighed, robusthed og rollematch...';

  @override
  String get disclaimerShortText =>
      'HR-Ansvarsfraskrivelse & Privatliv: Kun til beslutningsstøtte ved samtaler; AI kan fejle. Træf aldrig ansættelsesbeslutninger alene ud fra denne rapport. Data gemmes aldrig.';

  @override
  String get disclaimerLinkLabel =>
      'Læs HR-Ansvarsfraskrivelse & Nul-Datalagring';

  @override
  String get disclaimerDialogTitle => 'HR-Beslutningsstøtte & Nul-Datalagring';

  @override
  String get disclaimerDialogBody =>
      '1. Supplerende Værktøj & AI-Usikkerhed:\nDenne rapport er udelukkende et supplerende interviewværktøj. AI kan tage fejl; træf aldrig en positiv eller negativ ansættelsesbeslutning alene på baggrund af rapporten.\n\n2. Nul Datalagring:\nUploadede billeder og kandidatoplysninger gemmes aldrig på servere, men behandles kun midlertidigt til analysen.';

  @override
  String get reportSummaryTitle => 'Ledelsesresumé & Virksomhedsmatch';

  @override
  String get spectrumSectionTitle => '4-Akset Virksomhedsprofil';

  @override
  String get axisManageability => 'Ledelighed & Regelbundenhed';

  @override
  String get axisRoleType => 'Operationel Rollearketyp';

  @override
  String get axisResilience => 'Presrobusthed (Resilient vs. Skrøbelig)';

  @override
  String get axisDiscipline => 'Selvdisciplin & Organisering';

  @override
  String get reportComparisonTitle =>
      'Reelle Arbejdsvaner (Skrift) vs. Interviewmaske (Signatur)';

  @override
  String get reportDimensionsTitle => '6-Dimensionel HR-Vurdering';

  @override
  String get dimDiscipline =>
      '1. Selvdisciplin, Organisering & Gennemførelsesevne';

  @override
  String get dimManageability =>
      '2. Forhold til Autoritet & Ledelighed (Rebelsk vs. Styrbar)';

  @override
  String get dimRoleNature =>
      '3. Rollearketyp: Leder, Praktisk Udfører (Doer) eller Facademenneske?';

  @override
  String get dimResilience =>
      '4. Stressrobusthed (Resilience) vs. Følelsesmæssig Skrøbelighed';

  @override
  String get dimTeamEgo => '5. Teamkommunikation, Ego & Konfliktstil';

  @override
  String get dimRedFlags =>
      '6. Ansættelsesrisici (Red Flags) & Interviewspørgsmål';

  @override
  String get physicalMetricsTitle => 'Observerede Fysiske Spor';

  @override
  String get metricSlant => 'Hældning';

  @override
  String get metricPressure => 'Pennetryk';

  @override
  String get metricBaseline => 'Linjeretning';

  @override
  String get metricSize => 'Størrelse';

  @override
  String get metricZones => 'Zoner';

  @override
  String get metricConnectivity => 'Forbindelse';

  @override
  String get metricSpacing => 'Orden & Marginer';

  @override
  String get metricSignatureStyle => 'Signatur & Fremhævelse';

  @override
  String get archiveTitle => 'Kandidatarkiv';

  @override
  String get archiveEmpty => 'Ingen kandidatanalyser arkiveret endnu.';

  @override
  String get settingsTitle => 'HR-Indstillinger';

  @override
  String get settingsLanguage => 'Rapportsprog';

  @override
  String get settingsTheme => 'Mørkt Tema';

  @override
  String get closeButton => 'Luk';
}
