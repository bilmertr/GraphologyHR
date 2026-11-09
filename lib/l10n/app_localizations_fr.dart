// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Graphology HR';

  @override
  String get appSubtitle =>
      'Évaluation RH : Discipline, Résilience et Adéquation au Poste';

  @override
  String get navStudio => 'Évaluer Candidat';

  @override
  String get navArchive => 'Archives';

  @override
  String get navSettings => 'Paramètres';

  @override
  String get candidateContextTitle => 'CANDIDAT & POSTE CIBLÉ (OPTIONNEL)';

  @override
  String get candidateNameHint => 'Code ou nom du candidat (ex. Candidat #104)';

  @override
  String get targetRoleLabel => 'Profil du Poste';

  @override
  String get roleGeneral => 'Entreprise Général';

  @override
  String get roleLeadership => 'Direction / Leadership';

  @override
  String get roleExecution => 'Opérations / Exécutant (Doer)';

  @override
  String get roleSales => 'Ventes & Relations Clients';

  @override
  String get roleTechnical => 'Technique / Spécialiste';

  @override
  String get modeSelectorLabel => 'SÉLECTIONNEZ LE MODE D\'ÉVALUATION';

  @override
  String get modeHandwritingTitle =>
      'Écriture (Discipline de Travail & Exécution)';

  @override
  String get modeHandwritingDesc =>
      'Autodiscipline, sens de l\'organisation, résilience au stress et fiabilité opérationnelle';

  @override
  String get modeSignatureTitle =>
      'Signature (Posture Corporate, Autorité & Ego)';

  @override
  String get modeSignatureDesc =>
      'Présence exécutive, ambition, limites de l\'ego et rapport au pouvoir';

  @override
  String get modeCombinedTitle =>
      'Écriture + Signature (Habitudes Réelles vs Masque d\'Entretien)';

  @override
  String get modeCombinedDesc =>
      'Compare la vitrine présentée en entretien avec la discipline réelle de travail';

  @override
  String get uploadHandwritingTitle =>
      'Photo de l\'Écriture / Note du Candidat';

  @override
  String get uploadSignatureTitle => 'Photo de la Signature du Candidat';

  @override
  String get captureGuideHandwriting =>
      'Importez une photo nette de la note manuscrite du candidat.';

  @override
  String get captureGuideSignature =>
      'Importez une photo nette de la signature du candidat.';

  @override
  String get cameraButton => 'Caméra';

  @override
  String get galleryButton => 'Fichier / Galerie';

  @override
  String get analyzeButton => 'Analyser l\'Adéquation RH et le Caractère';

  @override
  String get analyzingWait =>
      'Analyse de l\'autodiscipline, de la dirigeabilité, de la résilience et du rôle...';

  @override
  String get disclaimerShortText =>
      'Avis RH & Confidentialité : Outil d\'aide à l\'entretien ; l\'IA peut se tromper. Ne prenez jamais de décision d\'embauche sur cette seule base. Aucune donnée n\'est conservée.';

  @override
  String get disclaimerLinkLabel =>
      'Lire l\'Avis d\'Aide à la Décision RH et Zéro Conservation des Données';

  @override
  String get disclaimerDialogTitle =>
      'Avertissement RH & Zéro Conservation des Données';

  @override
  String get disclaimerDialogBody =>
      '1. Aide à la Décision & Faillibilité de l\'IA :\nCe rapport est uniquement un support d\'entretien pour générer des questions de vérification. L\'IA peut commettre des erreurs ; ne prenez jamais une décision d\'embauche ou de rejet sur la seule base de ce rapport.\n\n2. Zéro Conservation des Données (RGPD) :\nLes images et informations du candidat ne sont jamais stockées sur nos serveurs ; elles sont traitées uniquement en mémoire vive puis immédiatement effacées.';

  @override
  String get reportSummaryTitle => 'Synthèse Exécutive & Adéquation RH';

  @override
  String get spectrumSectionTitle => 'Spectre Corporate à 4 Axes';

  @override
  String get axisManageability => 'Dirigeabilité & Respect du Cadre';

  @override
  String get axisRoleType => 'Archétype de Rôle Opérationnel';

  @override
  String get axisResilience =>
      'Tolérance à la Pression (Résilience vs Fragilité)';

  @override
  String get axisDiscipline => 'Autodiscipline & Organisation';

  @override
  String get reportComparisonTitle =>
      'Habitudes Réelles (Écriture) vs Masque d\'Entretien (Signature)';

  @override
  String get reportDimensionsTitle => 'Évaluation RH en 6 Dimensions';

  @override
  String get dimDiscipline =>
      '1. Autodiscipline, Organisation & Capacité d\'Exécution';

  @override
  String get dimManageability =>
      '2. Rapport à l\'Autorité & Dirigeabilité (Rebelle vs Gérable)';

  @override
  String get dimRoleNature =>
      '3. Archétype : Leader, Exécutant de Terrain (Doer) ou Profil Vitrine ?';

  @override
  String get dimResilience =>
      '4. Résilience au Stress vs Fragilité Émotionnelle';

  @override
  String get dimTeamEgo =>
      '5. Communication d\'Équipe, Ego & Gestion des Conflits';

  @override
  String get dimRedFlags =>
      '6. Risques de Recrutement (Red Flags) & Questions d\'Entretien';

  @override
  String get physicalMetricsTitle => 'Indices Physiques Observés';

  @override
  String get metricSlant => 'Inclinaison';

  @override
  String get metricPressure => 'Pression';

  @override
  String get metricBaseline => 'Direction';

  @override
  String get metricSize => 'Calibre';

  @override
  String get metricZones => 'Zones';

  @override
  String get metricConnectivity => 'Liaisons';

  @override
  String get metricSpacing => 'Ordre & Marges';

  @override
  String get metricSignatureStyle => 'Signature & Soulignements';

  @override
  String get archiveTitle => 'Archives des Candidats';

  @override
  String get archiveEmpty => 'Aucun dossier candidat archivé pour le moment.';

  @override
  String get settingsTitle => 'Paramètres RH';

  @override
  String get settingsLanguage => 'Langue du Rapport';

  @override
  String get settingsTheme => 'Mode Sombre';

  @override
  String get closeButton => 'Fermer';
}
