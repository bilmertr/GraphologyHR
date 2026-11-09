import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSettingsState {
  static const List<String> supportedLanguageCodes = [
    'tr',
    'en',
    'de',
    'es',
    'da',
    'pt',
    'fr',
    'it',
    'nl',
    'sv',
  ];

  final String languageCode;
  final bool isDarkMode;

  const AppSettingsState({
    this.languageCode = 'tr',
    this.isDarkMode = false,
  });

  AppSettingsState copyWith({
    String? languageCode,
    bool? isDarkMode,
  }) {
    return AppSettingsState(
      languageCode: languageCode ?? this.languageCode,
      isDarkMode: isDarkMode ?? this.isDarkMode,
    );
  }
}

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('sharedPreferencesProvider must be overridden');
});

class SettingsNotifier extends StateNotifier<AppSettingsState> {
  static const String _keyLang = 'hr_graphology_lang';
  static const String _keyDark = 'hr_graphology_dark';

  final SharedPreferences _prefs;

  SettingsNotifier(this._prefs)
      : super(
          AppSettingsState(
            languageCode: _prefs.getString(_keyLang) ?? 'tr',
            isDarkMode: _prefs.getBool(_keyDark) ?? false,
          ),
        );

  Future<void> setLanguage(String code) async {
    if (!AppSettingsState.supportedLanguageCodes.contains(code)) return;
    await _prefs.setString(_keyLang, code);
    state = state.copyWith(languageCode: code);
  }

  Future<void> setDarkMode(bool isDark) async {
    await _prefs.setBool(_keyDark, isDark);
    state = state.copyWith(isDarkMode: isDark);
  }
}

final settingsProvider =
    StateNotifierProvider<SettingsNotifier, AppSettingsState>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return SettingsNotifier(prefs);
});
