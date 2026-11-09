import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_da.dart';
import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_it.dart';
import 'app_localizations_nl.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_sv.dart';
import 'app_localizations_tr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('da'),
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('it'),
    Locale('nl'),
    Locale('pt'),
    Locale('sv'),
    Locale('tr'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Graphology HR'**
  String get appTitle;

  /// No description provided for @appSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Corporate Candidate Temperament, Self-Discipline & Role Fit Assessment'**
  String get appSubtitle;

  /// No description provided for @navStudio.
  ///
  /// In en, this message translates to:
  /// **'Candidate Analysis'**
  String get navStudio;

  /// No description provided for @navArchive.
  ///
  /// In en, this message translates to:
  /// **'Candidate Archive'**
  String get navArchive;

  /// No description provided for @navSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get navSettings;

  /// No description provided for @candidateContextTitle.
  ///
  /// In en, this message translates to:
  /// **'CANDIDATE & TARGET ROLE (OPTIONAL)'**
  String get candidateContextTitle;

  /// No description provided for @candidateNameHint.
  ///
  /// In en, this message translates to:
  /// **'Candidate Code or Name (e.g. Candidate #104 - Ops Manager)'**
  String get candidateNameHint;

  /// No description provided for @targetRoleLabel.
  ///
  /// In en, this message translates to:
  /// **'Target Role Profile'**
  String get targetRoleLabel;

  /// No description provided for @roleGeneral.
  ///
  /// In en, this message translates to:
  /// **'General Corporate'**
  String get roleGeneral;

  /// No description provided for @roleLeadership.
  ///
  /// In en, this message translates to:
  /// **'Executive / Leadership'**
  String get roleLeadership;

  /// No description provided for @roleExecution.
  ///
  /// In en, this message translates to:
  /// **'Operations / Doer & Executor'**
  String get roleExecution;

  /// No description provided for @roleSales.
  ///
  /// In en, this message translates to:
  /// **'Sales & Client Relations'**
  String get roleSales;

  /// No description provided for @roleTechnical.
  ///
  /// In en, this message translates to:
  /// **'Technical / Analytical Specialist'**
  String get roleTechnical;

  /// No description provided for @modeSelectorLabel.
  ///
  /// In en, this message translates to:
  /// **'SELECT ASSESSMENT MODE'**
  String get modeSelectorLabel;

  /// No description provided for @modeHandwritingTitle.
  ///
  /// In en, this message translates to:
  /// **'Handwriting (Work Discipline & Execution)'**
  String get modeHandwritingTitle;

  /// No description provided for @modeHandwritingDesc.
  ///
  /// In en, this message translates to:
  /// **'Self-discipline, organizational capability, stress resilience, and operational follow-through'**
  String get modeHandwritingDesc;

  /// No description provided for @modeSignatureTitle.
  ///
  /// In en, this message translates to:
  /// **'Signature (Corporate Persona, Authority & Ego)'**
  String get modeSignatureTitle;

  /// No description provided for @modeSignatureDesc.
  ///
  /// In en, this message translates to:
  /// **'Executive presence, ambition, ego boundaries, and authority projection'**
  String get modeSignatureDesc;

  /// No description provided for @modeCombinedTitle.
  ///
  /// In en, this message translates to:
  /// **'Handwriting + Signature (Actual Work Habits vs. Interview Mask)'**
  String get modeCombinedTitle;

  /// No description provided for @modeCombinedDesc.
  ///
  /// In en, this message translates to:
  /// **'Compares the candidate\'s polished interview persona against their actual day-to-day execution habits'**
  String get modeCombinedDesc;

  /// No description provided for @uploadHandwritingTitle.
  ///
  /// In en, this message translates to:
  /// **'Candidate Handwriting / Note Photo'**
  String get uploadHandwritingTitle;

  /// No description provided for @uploadSignatureTitle.
  ///
  /// In en, this message translates to:
  /// **'Candidate Signature Photo'**
  String get uploadSignatureTitle;

  /// No description provided for @captureGuideHandwriting.
  ///
  /// In en, this message translates to:
  /// **'Upload a clear photo of the candidate\'s handwritten note, application form, or interview notes.'**
  String get captureGuideHandwriting;

  /// No description provided for @captureGuideSignature.
  ///
  /// In en, this message translates to:
  /// **'Upload a clear photo of the candidate\'s signature on paper.'**
  String get captureGuideSignature;

  /// No description provided for @cameraButton.
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get cameraButton;

  /// No description provided for @galleryButton.
  ///
  /// In en, this message translates to:
  /// **'File / Gallery'**
  String get galleryButton;

  /// No description provided for @analyzeButton.
  ///
  /// In en, this message translates to:
  /// **'Analyze Candidate Corporate Fit & Character'**
  String get analyzeButton;

  /// No description provided for @analyzingWait.
  ///
  /// In en, this message translates to:
  /// **'Evaluating candidate self-discipline, manageability, stress resilience, and corporate role fit...'**
  String get analyzingWait;

  /// No description provided for @disclaimerShortText.
  ///
  /// In en, this message translates to:
  /// **'HR Disclaimer & Privacy: This assessment is a supplementary interview aid; AI can make mistakes. Never make hiring or rejection decisions solely based on this report. Uploaded images and candidate data are never stored on servers.'**
  String get disclaimerShortText;

  /// No description provided for @disclaimerLinkLabel.
  ///
  /// In en, this message translates to:
  /// **'Read Full HR Decision-Support & Zero-Data-Retention Notice'**
  String get disclaimerLinkLabel;

  /// No description provided for @disclaimerDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'HR Decision-Support Disclaimer & Zero Data Retention'**
  String get disclaimerDialogTitle;

  /// No description provided for @disclaimerDialogBody.
  ///
  /// In en, this message translates to:
  /// **'1. Supplementary Decision-Support & AI Fallibility:\nThis graphological and behavioral analysis is designed strictly as a supplementary perspective and interview question generator for HR professionals and hiring managers. AI models and graphological interpretations can make mistakes. It is not appropriate to make a direct positive or negative hiring decision about a candidate based solely on this report; all insights must be cross-verified through structured interviews, competency assessments, and reference checks.\n\n2. Zero Data Retention (Privacy Guarantee):\nUploaded handwriting/signature images and candidate reference labels are never stored on our servers, never saved to external databases, and never shared with third parties. Images are processed transiently in memory solely for instant analysis and immediately discarded.'**
  String get disclaimerDialogBody;

  /// No description provided for @reportSummaryTitle.
  ///
  /// In en, this message translates to:
  /// **'Executive Brief & Corporate Fit Synthesis'**
  String get reportSummaryTitle;

  /// No description provided for @spectrumSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'4-Axis Corporate Character Spectrum'**
  String get spectrumSectionTitle;

  /// No description provided for @axisManageability.
  ///
  /// In en, this message translates to:
  /// **'Manageability & Corporate Alignment'**
  String get axisManageability;

  /// No description provided for @axisRoleType.
  ///
  /// In en, this message translates to:
  /// **'Operational Role Archetype'**
  String get axisRoleType;

  /// No description provided for @axisResilience.
  ///
  /// In en, this message translates to:
  /// **'Pressure Tolerance (Resilience vs. Fragility)'**
  String get axisResilience;

  /// No description provided for @axisDiscipline.
  ///
  /// In en, this message translates to:
  /// **'Self-Discipline & Organization'**
  String get axisDiscipline;

  /// No description provided for @reportComparisonTitle.
  ///
  /// In en, this message translates to:
  /// **'Actual Work Habits (Handwriting) vs. Interview Mask (Signature)'**
  String get reportComparisonTitle;

  /// No description provided for @reportDimensionsTitle.
  ///
  /// In en, this message translates to:
  /// **'6-Dimension Corporate HR Assessment'**
  String get reportDimensionsTitle;

  /// No description provided for @dimDiscipline.
  ///
  /// In en, this message translates to:
  /// **'1. Self-Discipline, Organizational Skill & Execution Follow-Through'**
  String get dimDiscipline;

  /// No description provided for @dimManageability.
  ///
  /// In en, this message translates to:
  /// **'2. Attitude Toward Authority, Rule Compliance & Manageability (Rebellious vs. Coachable)'**
  String get dimManageability;

  /// No description provided for @dimRoleNature.
  ///
  /// In en, this message translates to:
  /// **'3. Role Archetype: Leader, Hands-On Doer, or Image-Driven Showman?'**
  String get dimRoleNature;

  /// No description provided for @dimResilience.
  ///
  /// In en, this message translates to:
  /// **'4. Stress Resilience vs. Emotional Fragility Under Pressure'**
  String get dimResilience;

  /// No description provided for @dimTeamEgo.
  ///
  /// In en, this message translates to:
  /// **'5. Team Communication, Ego Boundaries & Conflict Style'**
  String get dimTeamEgo;

  /// No description provided for @dimRedFlags.
  ///
  /// In en, this message translates to:
  /// **'6. Potential Hiring Risks (Red Flags) & Interview Probing Questions'**
  String get dimRedFlags;

  /// No description provided for @physicalMetricsTitle.
  ///
  /// In en, this message translates to:
  /// **'Observed Physical Evidence'**
  String get physicalMetricsTitle;

  /// No description provided for @metricSlant.
  ///
  /// In en, this message translates to:
  /// **'Emotional Slant'**
  String get metricSlant;

  /// No description provided for @metricPressure.
  ///
  /// In en, this message translates to:
  /// **'Drive & Pressure'**
  String get metricPressure;

  /// No description provided for @metricBaseline.
  ///
  /// In en, this message translates to:
  /// **'Goal Direction'**
  String get metricBaseline;

  /// No description provided for @metricSize.
  ///
  /// In en, this message translates to:
  /// **'Focus & Scale'**
  String get metricSize;

  /// No description provided for @metricZones.
  ///
  /// In en, this message translates to:
  /// **'Zone Dominance'**
  String get metricZones;

  /// No description provided for @metricConnectivity.
  ///
  /// In en, this message translates to:
  /// **'Thought Flow'**
  String get metricConnectivity;

  /// No description provided for @metricSpacing.
  ///
  /// In en, this message translates to:
  /// **'Order & Margins'**
  String get metricSpacing;

  /// No description provided for @metricSignatureStyle.
  ///
  /// In en, this message translates to:
  /// **'Signature vs. Text'**
  String get metricSignatureStyle;

  /// No description provided for @archiveTitle.
  ///
  /// In en, this message translates to:
  /// **'Candidate Dossier Archive'**
  String get archiveTitle;

  /// No description provided for @archiveEmpty.
  ///
  /// In en, this message translates to:
  /// **'No candidate assessments archived on this device yet.'**
  String get archiveEmpty;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Corporate HR Settings'**
  String get settingsTitle;

  /// No description provided for @settingsLanguage.
  ///
  /// In en, this message translates to:
  /// **'Assessment & Report Language'**
  String get settingsLanguage;

  /// No description provided for @settingsTheme.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get settingsTheme;

  /// No description provided for @closeButton.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get closeButton;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'da',
    'de',
    'en',
    'es',
    'fr',
    'it',
    'nl',
    'pt',
    'sv',
    'tr',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'da':
      return AppLocalizationsDa();
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'it':
      return AppLocalizationsIt();
    case 'nl':
      return AppLocalizationsNl();
    case 'pt':
      return AppLocalizationsPt();
    case 'sv':
      return AppLocalizationsSv();
    case 'tr':
      return AppLocalizationsTr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
