// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get appTitle => 'Graphology HR';

  @override
  String get appSubtitle =>
      'Valutazione HR di Disciplina, Resilienza e Idoneità al Ruolo';

  @override
  String get navStudio => 'Valuta Candidato';

  @override
  String get navArchive => 'Archivio';

  @override
  String get navSettings => 'Impostazioni';

  @override
  String get candidateContextTitle => 'CANDIDATO E RUOLO TARGET (OPZIONALE)';

  @override
  String get candidateNameHint =>
      'Codice o nome del candidato (es. Candidato #104)';

  @override
  String get targetRoleLabel => 'Profilo del Ruolo';

  @override
  String get roleGeneral => 'Aziendale Generale';

  @override
  String get roleLeadership => 'Dirigenziale / Leadership';

  @override
  String get roleExecution => 'Operativo / Esecutore (Doer)';

  @override
  String get roleSales => 'Vendite e Relazioni';

  @override
  String get roleTechnical => 'Tecnico / Analitico';

  @override
  String get modeSelectorLabel => 'SELEZIONA MODALITÀ DI VALUTAZIONE';

  @override
  String get modeHandwritingTitle =>
      'Scrittura (Disciplina Lavorativa ed Esecuzione)';

  @override
  String get modeHandwritingDesc =>
      'Autodisciplina, capacità organizzativa, resilienza allo stress e concretezza operativa';

  @override
  String get modeSignatureTitle => 'Firma (Postura Aziendale, Autorità ed Ego)';

  @override
  String get modeSignatureDesc =>
      'Presenza esecutiva, ambizione, confini dell\'ego e proiezione di autorità';

  @override
  String get modeCombinedTitle =>
      'Scrittura + Firma (Abitudini Reali vs Maschera da Colloquio)';

  @override
  String get modeCombinedDesc =>
      'Confronta l\'immagine mostrata al colloquio con la reale disciplina operativa';

  @override
  String get uploadHandwritingTitle => 'Foto Scrittura / Appunti del Candidato';

  @override
  String get uploadSignatureTitle => 'Foto Firma del Candidato';

  @override
  String get captureGuideHandwriting =>
      'Carica una foto nitida degli appunti manoscritti del candidato.';

  @override
  String get captureGuideSignature =>
      'Carica una foto nitida della firma del candidato.';

  @override
  String get cameraButton => 'Fotocamera';

  @override
  String get galleryButton => 'File / Galleria';

  @override
  String get analyzeButton => 'Analizza Idoneità Aziendale e Carattere';

  @override
  String get analyzingWait =>
      'Valutazione di autodisciplina, gestibilità, resilienza e idoneità al ruolo...';

  @override
  String get disclaimerShortText =>
      'Avviso HR e Privacy: Strumento di supporto al colloquio; l\'IA può commettere errori. Non prendere decisioni di assunzione basandosi solo su questo report. Nessun dato viene salvato.';

  @override
  String get disclaimerLinkLabel =>
      'Leggi Informativa di Supporto Decisionale HR e Zero Conservazione Dati';

  @override
  String get disclaimerDialogTitle => 'Disclaimer HR e Zero Conservazione Dati';

  @override
  String get disclaimerDialogBody =>
      '1. Supporto al Colloquio e Fallibilità dell\'IA:\nQuesta analisi è uno strumento ausiliario per formulare domande di verifica durante il colloquio. L\'IA può sbagliare; non prendere mai decisioni di assunzione o esclusione basandosi esclusivamente su questo report.\n\n2. Zero Conservazione dei Dati (GDPR):\nLe immagini e i dati del candidato non vengono mai salvati sui server, ma elaborati solo temporaneamente in memoria per l\'analisi istantanea.';

  @override
  String get reportSummaryTitle => 'Sintesi Esecutiva e Idoneità Aziendale';

  @override
  String get spectrumSectionTitle => 'Spettro Aziendale a 4 Assi';

  @override
  String get axisManageability => 'Gestibilità e Allineamento alle Regole';

  @override
  String get axisRoleType => 'Archetipo di Ruolo Operativo';

  @override
  String get axisResilience =>
      'Tenuta sotto Pressione (Resilienza vs Fragilità)';

  @override
  String get axisDiscipline => 'Autodisciplina e Organizzazione';

  @override
  String get reportComparisonTitle =>
      'Abitudini Reali (Scrittura) vs Maschera da Colloquio (Firma)';

  @override
  String get reportDimensionsTitle => 'Valutazione HR in 6 Dimensioni';

  @override
  String get dimDiscipline =>
      '1. Autodisciplina, Organizzazione e Capacità di Completamento';

  @override
  String get dimManageability =>
      '2. Rapporto con l\'Autorità e Gestibilità (Ribelle vs Gestibile)';

  @override
  String get dimRoleNature =>
      '3. Archetipo di Ruolo: Leader, Esecutore Pratico (Doer) o Profilo di Vetrina?';

  @override
  String get dimResilience => '4. Resilienza allo Stress vs Fragilità Emotiva';

  @override
  String get dimTeamEgo =>
      '5. Comunicazione nel Team, Ego e Gestione dei Conflitti';

  @override
  String get dimRedFlags =>
      '6. Rischi di Assunzione (Red Flags) e Domande di Colloquio';

  @override
  String get physicalMetricsTitle => 'Evidenze Fisiche Osservate';

  @override
  String get metricSlant => 'Inclinazione';

  @override
  String get metricPressure => 'Pressione';

  @override
  String get metricBaseline => 'Direzione';

  @override
  String get metricSize => 'Calibro';

  @override
  String get metricZones => 'Zone';

  @override
  String get metricConnectivity => 'Continuità';

  @override
  String get metricSpacing => 'Ordine e Margini';

  @override
  String get metricSignatureStyle => 'Firma ed Enfasi';

  @override
  String get archiveTitle => 'Archivio Candidati';

  @override
  String get archiveEmpty => 'Nessuna valutazione candidato archiviata.';

  @override
  String get settingsTitle => 'Impostazioni HR';

  @override
  String get settingsLanguage => 'Lingua del Rapporto';

  @override
  String get settingsTheme => 'Modalità Scura';

  @override
  String get closeButton => 'Chiudi';
}
