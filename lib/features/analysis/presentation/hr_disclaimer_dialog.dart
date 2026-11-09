import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/network/api_constants.dart';
import '../../../core/theme/japandi_colors.dart';
import '../../../l10n/app_localizations.dart';

class HrDisclaimerBanner extends StatelessWidget {
  const HrDisclaimerBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: JapandiColors.terracottaClay.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: JapandiColors.terracottaClay.withValues(alpha: 0.35),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 2),
                child: Icon(
                  Icons.verified_user_outlined,
                  size: 18,
                  color: JapandiColors.terracottaClay,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  l10n.disclaimerShortText,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurface,
                    height: 1.45,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: InkWell(
              borderRadius: BorderRadius.circular(6),
              onTap: () => showHrDisclaimerDialog(context),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.info_outline,
                      size: 14,
                      color: JapandiColors.brassGold,
                    ),
                    const SizedBox(width: 5),
                    Flexible(
                      child: Text(
                        l10n.disclaimerLinkLabel,
                        style: theme.textTheme.labelMedium?.copyWith(
                          color: JapandiColors.brassGold,
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Future<void> showHrDisclaimerDialog(BuildContext context) async {
  final l10n = AppLocalizations.of(context)!;
  final theme = Theme.of(context);

  await showDialog<void>(
    context: context,
    builder: (ctx) => AlertDialog(
      backgroundColor: theme.cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: JapandiColors.hairlineLight),
      ),
      title: Row(
        children: [
          const Icon(
            Icons.gavel_outlined,
            color: JapandiColors.brassGold,
            size: 22,
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
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              l10n.disclaimerDialogBody,
              style: theme.textTheme.bodyMedium?.copyWith(height: 1.58),
            ),
            const SizedBox(height: 16),
            InkWell(
              onTap: () async {
                final uri = Uri.parse(ApiConstants.officialDisclaimerUrl);
                await launchUrl(uri, mode: LaunchMode.externalApplication);
              },
              child: Row(
                children: [
                  const Icon(
                    Icons.open_in_new,
                    size: 15,
                    color: JapandiColors.brassGold,
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      ApiConstants.officialDisclaimerUrl,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: JapandiColors.brassGold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () => Navigator.of(ctx).pop(),
          child: Text(l10n.closeButton),
        ),
      ],
    ),
  );
}
