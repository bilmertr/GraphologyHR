import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/theme/japandi_theme.dart';
import 'features/home/presentation/home_shell.dart';
import 'features/settings/providers/settings_provider.dart';
import 'l10n/app_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
      ],
      child: const GraphologyHrApp(),
    ),
  );
}

class GraphologyHrApp extends ConsumerWidget {
  const GraphologyHrApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);

    return MaterialApp(
      title: 'Graphology HR',
      debugShowCheckedModeBanner: false,
      theme: JapandiTheme.light(),
      darkTheme: JapandiTheme.dark(),
      themeMode: settings.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      locale: Locale(settings.languageCode),
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      home: const HomeShell(),
    );
  }
}
