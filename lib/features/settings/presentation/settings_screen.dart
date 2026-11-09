import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/japandi_colors.dart';
import '../../../l10n/app_localizations.dart';
import '../../analysis/presentation/hr_disclaimer_dialog.dart';
import '../providers/settings_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  static const Map<String, String> _languageNames = {
    'tr': 'Türkçe',
    'en': 'English',
    'de': 'Deutsch',
    'es': 'Español',
    'da': 'Dansk',
    'pt': 'Português',
    'fr': 'Français',
    'it': 'Italiano',
    'nl': 'Nederlands',
    'sv': 'Svenska',
  };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final settings = ref.watch(settingsProvider);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 780),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(l10n.settingsTitle, style: theme.textTheme.displaySmall),
              const SizedBox(height: 18),

              // HR Disclaimer & Zero Data Retention Card
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.verified_user_outlined,
                            color: JapandiColors.brassGold,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              l10n.disclaimerDialogTitle,
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        l10n.disclaimerDialogBody,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          height: 1.55,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Align(
                        alignment: Alignment.centerRight,
                        child: OutlinedButton.icon(
                          onPressed: () => showHrDisclaimerDialog(context),
                          icon: const Icon(Icons.info_outline, size: 18),
                          label: Text(l10n.disclaimerLinkLabel),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Dark Mode Switch Card
              Card(
                child: SwitchListTile(
                  secondary: const Icon(
                    Icons.dark_mode_outlined,
                    color: JapandiColors.brassGold,
                  ),
                  title: Text(
                    l10n.settingsTheme,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  value: settings.isDarkMode,
                  onChanged: (val) =>
                      ref.read(settingsProvider.notifier).setDarkMode(val),
                ),
              ),
              const SizedBox(height: 16),

              // Language Selector Card
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.language_outlined,
                            color: JapandiColors.brassGold,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            l10n.settingsLanguage,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      ...AppSettingsState.supportedLanguageCodes.map((code) {
                        final isSelected = code == settings.languageCode;
                        return ListTile(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          leading: Icon(
                            isSelected
                                ? Icons.radio_button_checked
                                : Icons.radio_button_unchecked,
                            color: isSelected
                                ? JapandiColors.brassGold
                                : JapandiColors.hairlineLight,
                          ),
                          title: Text(
                            _languageNames[code] ?? code,
                            style: theme.textTheme.bodyLarge?.copyWith(
                              fontWeight: isSelected
                                  ? FontWeight.w700
                                  : FontWeight.w500,
                            ),
                          ),
                          trailing: isSelected
                              ? const Icon(
                                  Icons.check_circle,
                                  color: JapandiColors.brassGold,
                                  size: 18,
                                )
                              : null,
                          onTap: () {
                            ref
                                .read(settingsProvider.notifier)
                                .setLanguage(code);
                          },
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
