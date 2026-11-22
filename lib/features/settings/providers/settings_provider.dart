import 'dart:ui' show PlatformDispatcher;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSettingsState {
  static const List<String> supportedLanguageCodes = [
    'en',
    'tr',
    'da',
    'de',
    'es',
    'pt',
    'fr',
    'it',
    'nl',
    'sv',
  ];

  static const Map<String, String> languageDisplayNames = {
    'en': 'English',
    'tr': 'Türkçe',
    'da': 'Dansk',
    'de': 'Deutsch',
    'es': 'Español',
    'pt': 'Português',
    'fr': 'Français',
    'it': 'Italiano',
    'nl': 'Nederlands',
    'sv': 'Svenska',
  };

  final String languageCode;
  final bool isDarkMode;

  const AppSettingsState({
    this.languageCode = 'en',
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
            languageCode: resolveInitialLanguageCode(_prefs),
            isDarkMode: _prefs.getBool(_keyDark) ?? false,
          ),
        );

  /// Resolves the initial UI & report language in priority order:
  /// 1. Explicit URL query parameter `?lang=en` / `?lang=da` / `?lang=tr`
  /// 2. Persisted user preference in local storage
  /// 3. Browser / OS locale if supported, otherwise international English ('en')
  static String resolveInitialLanguageCode(SharedPreferences prefs) {
    try {
      final queryLang = Uri.base.queryParameters['lang']?.trim().toLowerCase();
      if (queryLang != null &&
          AppSettingsState.supportedLanguageCodes.contains(queryLang)) {
        return queryLang;
      }
    } catch (_) {}

    final saved = prefs.getString(_keyLang)?.trim().toLowerCase();
    if (saved != null &&
        AppSettingsState.supportedLanguageCodes.contains(saved)) {
      return saved;
    }

    try {
      final deviceLang =
          PlatformDispatcher.instance.locale.languageCode.toLowerCase();
      if (AppSettingsState.supportedLanguageCodes.contains(deviceLang)) {
        return deviceLang;
      }
    } catch (_) {}

    return 'en';
  }

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
