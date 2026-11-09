// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'Graphology HR';

  @override
  String get appSubtitle =>
      'Kandidaten-Temperament, Selbstdisziplin & Rollenpassung im Unternehmen';

  @override
  String get navStudio => 'Kandidatenanalyse';

  @override
  String get navArchive => 'Archiv';

  @override
  String get navSettings => 'Einstellungen';

  @override
  String get candidateContextTitle => 'KANDIDAT & ZIELROLLE (OPTIONAL)';

  @override
  String get candidateNameHint =>
      'Kandidatencode oder Name (z. B. Kandidat #104)';

  @override
  String get targetRoleLabel => 'Zielrollenprofil';

  @override
  String get roleGeneral => 'Allgemein / Corporate';

  @override
  String get roleLeadership => 'Führungskraft / Management';

  @override
  String get roleExecution => 'Operativ / Umsetzer (Doer)';

  @override
  String get roleSales => 'Vertrieb & Kommunikation';

  @override
  String get roleTechnical => 'Technik / Spezialist';

  @override
  String get modeSelectorLabel => 'BEWERTUNGSMODUS WÄHLEN';

  @override
  String get modeHandwritingTitle =>
      'Handschrift (Arbeitsdisziplin & Umsetzung)';

  @override
  String get modeHandwritingDesc =>
      'Selbstdisziplin, Organisationsfähigkeit, Resilienz und operative Zuverlässigkeit';

  @override
  String get modeSignatureTitle => 'Unterschrift (Auftreten, Autorität & Ego)';

  @override
  String get modeSignatureDesc =>
      'Souveränität, Ehrgeiz, Ego-Grenzen und Autoritätsanspruch';

  @override
  String get modeCombinedTitle =>
      'Handschrift + Unterschrift (Echte Arbeitsweise vs. Interview-Maske)';

  @override
  String get modeCombinedDesc =>
      'Vergleicht das Auftreten im Vorstellungsgespräch mit der tatsächlichen Arbeitsdisziplin';

  @override
  String get uploadHandwritingTitle => 'Handschrift / Notiz des Kandidaten';

  @override
  String get uploadSignatureTitle => 'Unterschrift des Kandidaten';

  @override
  String get captureGuideHandwriting =>
      'Laden Sie ein klares Foto der handschriftlichen Notiz des Kandidaten hoch.';

  @override
  String get captureGuideSignature =>
      'Laden Sie ein klares Foto der Unterschrift hoch.';

  @override
  String get cameraButton => 'Kamera';

  @override
  String get galleryButton => 'Datei / Galerie';

  @override
  String get analyzeButton => 'Unternehmenspassung & Charakter analysieren';

  @override
  String get analyzingWait =>
      'Selbstdisziplin, Führbarkeit, Resilienz und Rollenpassung werden geprüft...';

  @override
  String get disclaimerShortText =>
      'HR-Hinweis & Datenschutz: Dieser Bericht dient nur als Gesprächshilfe; KI kann Fehler machen. Keine Einstellungsentscheidung allein hierauf stützen. Bilder und Daten werden niemals gespeichert.';

  @override
  String get disclaimerLinkLabel =>
      'HR-Haftungsausschluss & Datenschutzhinweis lesen';

  @override
  String get disclaimerDialogTitle =>
      'HR-Entscheidungshilfe & Null-Datenspeicherung';

  @override
  String get disclaimerDialogBody =>
      '1. Ergänzende Entscheidungshilfe & KI-Fehlertoleranz:\nDiese Analyse dient ausschließlich als ergänzende Perspektive und Fragengenerator für Vorstellungsgespräche. KI-Modelle können irren. Treffen Sie niemals eine Zu- oder Absage allein auf Basis dieses Berichts.\n\n2. Null-Datenspeicherung (DSGVO):\nHochgeladene Bilder und Kandidatenangaben werden niemals auf Servern gespeichert, sondern nur flüchtig zur Analyse verarbeitet und sofort gelöscht.';

  @override
  String get reportSummaryTitle => 'Management-Zusammenfassung & Passung';

  @override
  String get spectrumSectionTitle => '4-Achsen-Unternehmensspektrum';

  @override
  String get axisManageability => 'Führbarkeit & Regelkonformität';

  @override
  String get axisRoleType => 'Operativer Rollentyp';

  @override
  String get axisResilience => 'Belastbarkeit (Resilienz vs. Fragilität)';

  @override
  String get axisDiscipline => 'Selbstdisziplin & Organisation';

  @override
  String get reportComparisonTitle =>
      'Echte Arbeitsweise (Schrift) vs. Interview-Maske (Signatur)';

  @override
  String get reportDimensionsTitle => '6-Dimensionale HR-Bewertung';

  @override
  String get dimDiscipline =>
      '1. Selbstdisziplin, Organisation & Umsetzungskraft';

  @override
  String get dimManageability =>
      '2. Umgang mit Autorität & Führbarkeit (Rebellisch vs. Kooperativ)';

  @override
  String get dimRoleNature =>
      '3. Rollenarchetyp: Führungskraft, Macher (Doer) oder Selbstdarsteller?';

  @override
  String get dimResilience =>
      '4. Stressresilienz vs. Emotionale Fragilität unter Druck';

  @override
  String get dimTeamEgo => '5. Teamkommunikation, Ego & Konfliktverhalten';

  @override
  String get dimRedFlags =>
      '6. Potenzielle Risiken (Red Flags) & Interview-Prüffragen';

  @override
  String get physicalMetricsTitle => 'Beobachtete Physische Merkmale';

  @override
  String get metricSlant => 'Schriftneigung';

  @override
  String get metricPressure => 'Schreibdruck';

  @override
  String get metricBaseline => 'Zeilenrichtung';

  @override
  String get metricSize => 'Schriftgröße';

  @override
  String get metricZones => 'Zonenbalance';

  @override
  String get metricConnectivity => 'Bindungsform';

  @override
  String get metricSpacing => 'Raumaufteilung';

  @override
  String get metricSignatureStyle => 'Signatur & Betonung';

  @override
  String get archiveTitle => 'Kandidatenarchiv';

  @override
  String get archiveEmpty => 'Noch keine Kandidatenanalysen archiviert.';

  @override
  String get settingsTitle => 'HR-Einstellungen';

  @override
  String get settingsLanguage => 'Berichtssprache';

  @override
  String get settingsTheme => 'Dunkelmodus';

  @override
  String get closeButton => 'Schließen';
}
