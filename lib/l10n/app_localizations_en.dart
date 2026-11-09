// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Graphology HR';

  @override
  String get appSubtitle =>
      'Corporate Candidate Temperament, Self-Discipline & Role Fit Assessment';

  @override
  String get navStudio => 'Candidate Analysis';

  @override
  String get navArchive => 'Candidate Archive';

  @override
  String get navSettings => 'Settings';

  @override
  String get candidateContextTitle => 'CANDIDATE & TARGET ROLE (OPTIONAL)';

  @override
  String get candidateNameHint =>
      'Candidate Code or Name (e.g. Candidate #104 - Ops Manager)';

  @override
  String get targetRoleLabel => 'Target Role Profile';

  @override
  String get roleGeneral => 'General Corporate';

  @override
  String get roleLeadership => 'Executive / Leadership';

  @override
  String get roleExecution => 'Operations / Doer & Executor';

  @override
  String get roleSales => 'Sales & Client Relations';

  @override
  String get roleTechnical => 'Technical / Analytical Specialist';

  @override
  String get modeSelectorLabel => 'SELECT ASSESSMENT MODE';

  @override
  String get modeHandwritingTitle =>
      'Handwriting (Work Discipline & Execution)';

  @override
  String get modeHandwritingDesc =>
      'Self-discipline, organizational capability, stress resilience, and operational follow-through';

  @override
  String get modeSignatureTitle =>
      'Signature (Corporate Persona, Authority & Ego)';

  @override
  String get modeSignatureDesc =>
      'Executive presence, ambition, ego boundaries, and authority projection';

  @override
  String get modeCombinedTitle =>
      'Handwriting + Signature (Actual Work Habits vs. Interview Mask)';

  @override
  String get modeCombinedDesc =>
      'Compares the candidate\'s polished interview persona against their actual day-to-day execution habits';

  @override
  String get uploadHandwritingTitle => 'Candidate Handwriting / Note Photo';

  @override
  String get uploadSignatureTitle => 'Candidate Signature Photo';

  @override
  String get captureGuideHandwriting =>
      'Upload a clear photo of the candidate\'s handwritten note, application form, or interview notes.';

  @override
  String get captureGuideSignature =>
      'Upload a clear photo of the candidate\'s signature on paper.';

  @override
  String get cameraButton => 'Camera';

  @override
  String get galleryButton => 'File / Gallery';

  @override
  String get analyzeButton => 'Analyze Candidate Corporate Fit & Character';

  @override
  String get analyzingWait =>
      'Evaluating candidate self-discipline, manageability, stress resilience, and corporate role fit...';

  @override
  String get disclaimerShortText =>
      'HR Disclaimer & Privacy: This assessment is a supplementary interview aid; AI can make mistakes. Never make hiring or rejection decisions solely based on this report. Uploaded images and candidate data are never stored on servers.';

  @override
  String get disclaimerLinkLabel =>
      'Read Full HR Decision-Support & Zero-Data-Retention Notice';

  @override
  String get disclaimerDialogTitle =>
      'HR Decision-Support Disclaimer & Zero Data Retention';

  @override
  String get disclaimerDialogBody =>
      '1. Supplementary Decision-Support & AI Fallibility:\nThis graphological and behavioral analysis is designed strictly as a supplementary perspective and interview question generator for HR professionals and hiring managers. AI models and graphological interpretations can make mistakes. It is not appropriate to make a direct positive or negative hiring decision about a candidate based solely on this report; all insights must be cross-verified through structured interviews, competency assessments, and reference checks.\n\n2. Zero Data Retention (Privacy Guarantee):\nUploaded handwriting/signature images and candidate reference labels are never stored on our servers, never saved to external databases, and never shared with third parties. Images are processed transiently in memory solely for instant analysis and immediately discarded.';

  @override
  String get reportSummaryTitle => 'Executive Brief & Corporate Fit Synthesis';

  @override
  String get spectrumSectionTitle => '4-Axis Corporate Character Spectrum';

  @override
  String get axisManageability => 'Manageability & Corporate Alignment';

  @override
  String get axisRoleType => 'Operational Role Archetype';

  @override
  String get axisResilience => 'Pressure Tolerance (Resilience vs. Fragility)';

  @override
  String get axisDiscipline => 'Self-Discipline & Organization';

  @override
  String get reportComparisonTitle =>
      'Actual Work Habits (Handwriting) vs. Interview Mask (Signature)';

  @override
  String get reportDimensionsTitle => '6-Dimension Corporate HR Assessment';

  @override
  String get dimDiscipline =>
      '1. Self-Discipline, Organizational Skill & Execution Follow-Through';

  @override
  String get dimManageability =>
      '2. Attitude Toward Authority, Rule Compliance & Manageability (Rebellious vs. Coachable)';

  @override
  String get dimRoleNature =>
      '3. Role Archetype: Leader, Hands-On Doer, or Image-Driven Showman?';

  @override
  String get dimResilience =>
      '4. Stress Resilience vs. Emotional Fragility Under Pressure';

  @override
  String get dimTeamEgo =>
      '5. Team Communication, Ego Boundaries & Conflict Style';

  @override
  String get dimRedFlags =>
      '6. Potential Hiring Risks (Red Flags) & Interview Probing Questions';

  @override
  String get physicalMetricsTitle => 'Observed Physical Evidence';

  @override
  String get metricSlant => 'Emotional Slant';

  @override
  String get metricPressure => 'Drive & Pressure';

  @override
  String get metricBaseline => 'Goal Direction';

  @override
  String get metricSize => 'Focus & Scale';

  @override
  String get metricZones => 'Zone Dominance';

  @override
  String get metricConnectivity => 'Thought Flow';

  @override
  String get metricSpacing => 'Order & Margins';

  @override
  String get metricSignatureStyle => 'Signature vs. Text';

  @override
  String get archiveTitle => 'Candidate Dossier Archive';

  @override
  String get archiveEmpty =>
      'No candidate assessments archived on this device yet.';

  @override
  String get settingsTitle => 'Corporate HR Settings';

  @override
  String get settingsLanguage => 'Assessment & Report Language';

  @override
  String get settingsTheme => 'Dark Mode';

  @override
  String get closeButton => 'Close';
}
