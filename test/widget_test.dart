import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart' as img;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:graphology_hr/core/network/api_constants.dart';
import 'package:graphology_hr/features/analysis/models/analysis_mode.dart';
import 'package:graphology_hr/features/analysis/services/hr_graphology_api_service.dart';
import 'package:graphology_hr/features/analysis/services/pixel_graphology_extractor.dart';
import 'package:graphology_hr/features/settings/providers/settings_provider.dart';
import 'package:graphology_hr/main.dart';

Uint8List _createBlankPaperImage() {
  final canvas = img.Image(width: 240, height: 160);
  img.fill(canvas, color: img.ColorRgb8(248, 245, 240));
  return Uint8List.fromList(img.encodePng(canvas));
}

Uint8List _createHandwritingNoteImage() {
  final canvas = img.Image(width: 240, height: 160);
  img.fill(canvas, color: img.ColorRgb8(248, 245, 240));
  for (int row = 28; row <= 120; row += 22) {
    for (int x = 24; x < 210; x++) {
      final yOffset = ((x * 7 + row) % 5) - 2;
      canvas.setPixelRgb(x, row + yOffset, 28, 26, 23);
      canvas.setPixelRgb(x, row + yOffset + 1, 35, 32, 28);
    }
  }
  return Uint8List.fromList(img.encodePng(canvas));
}

void main() {
  testWidgets(
      'Graphology HR renders corporate studio, hides paywall badge, shows HR disclaimer, and supports all 10 languages',
      (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();

    // Verify paywall is kept in infrastructure but hidden in UI
    expect(ApiConstants.enablePaywallInUi, isFalse);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(prefs),
        ],
        child: const GraphologyHrApp(),
      ),
    );
    await tester.pumpAndSettle();

    // Verify Turkish default title and HR disclaimer banner are visible
    expect(find.text('Graphology HR'), findsWidgets);
    expect(
      find.textContaining('Yasal Uyarı'),
      findsWidgets,
    );

    // Verify zero astrology tabs exist
    expect(find.text('Kozmik Profil'), findsNothing);

    // Switch through all 10 supported locales
    final container = ProviderScope.containerOf(
      tester.element(find.byType(GraphologyHrApp)),
    );
    for (final code in AppSettingsState.supportedLanguageCodes) {
      await container.read(settingsProvider.notifier).setLanguage(code);
      await tester.pumpAndSettle();
      expect(find.byType(NavigationBar), findsOneWidget);
    }
  });

  test(
      'Pixel CV Gatekeeper rejects blank images and generates 6-dimension corporate HR report for valid handwriting',
      () async {
    final blankBytes = _createBlankPaperImage();
    final blankTelemetry = PixelGraphologyExtractor.analyzeBytes(blankBytes);
    expect(blankTelemetry.isValidInkSample, isFalse);

    final validBytes = _createHandwritingNoteImage();
    final validTelemetry = PixelGraphologyExtractor.analyzeBytes(validBytes);
    expect(validTelemetry.isValidInkSample, isTrue);

    final api = HrGraphologyApiService();
    final report = await api.analyzeSample(
      mode: AnalysisMode.handwriting,
      targetRole: TargetRoleProfile.leadership,
      candidateLabel: 'ADAY-2026-01',
      localeCode: 'tr',
      imageBytes: validBytes,
    );

    expect(report.candidateLabel, 'ADAY-2026-01');
    expect(report.executiveSummary.isNotEmpty, isTrue);
    expect(report.corporateSpectrum.manageability.isNotEmpty, isTrue);
    expect(report.corporateSpectrum.roleArchetype.isNotEmpty, isTrue);
    expect(report.corporateSpectrum.resilience.isNotEmpty, isTrue);
    expect(report.corporateSpectrum.discipline.isNotEmpty, isTrue);
    expect(report.dimensions.discipline.isNotEmpty, isTrue);
    expect(report.dimensions.manageability.isNotEmpty, isTrue);
    expect(report.dimensions.roleNature.isNotEmpty, isTrue);
    expect(report.dimensions.resilience.isNotEmpty, isTrue);
    expect(report.dimensions.teamEgo.isNotEmpty, isTrue);
    expect(report.dimensions.redFlags.isNotEmpty, isTrue);
  });
}
