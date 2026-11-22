import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/japandi_colors.dart';
import '../../../l10n/app_localizations.dart';
import '../../settings/providers/settings_provider.dart';
import '../providers/hr_analysis_provider.dart';
import 'hr_report_detail_screen.dart';

class HrArchiveScreen extends ConsumerWidget {
  const HrArchiveScreen({super.key});

  String _clearAllLabel(String lang) => switch (lang) {
        'tr' => 'Arşivi Temizle',
        'da' => 'Ryd arkiv',
        'de' => 'Alle löschen',
        _ => 'Clear All',
      };

  String _deleteTooltip(String lang) => switch (lang) {
        'tr' => 'Kaydı Sil',
        'da' => 'Slet rapport',
        'de' => 'Löschen',
        _ => 'Delete',
      };

  String _localPrivacyNotice(String lang) => switch (lang) {
        'tr' =>
          'Sıfır Sunucu Kaydı: Bu listedeki raporlar yalnızca bu tarayıcı/cihazın yerel belleğinde tutulur, sunucularımızda saklanmaz. İstediğiniz an tek tıkla silebilirsiniz.',
        'da' =>
          'Nul serverlagring (GDPR): Rapporterne her gemmes kun lokalt i denne browser/enhed og aldrig på eksterne servere. Du kan slette dem når som helst.',
        'de' =>
          'Keine Serverspeicherung (DSGVO): Diese Berichte werden ausschließlich lokal auf diesem Gerät gespeichert, niemals auf unseren Servern.',
        _ =>
          'Zero Server Retention (GDPR): Reports shown here are stored strictly inside this browser/device\'s local storage—never on remote servers—and can be cleared anytime.',
      };

  Future<void> _confirmClearAll(
    BuildContext context,
    WidgetRef ref,
    String lang,
  ) async {
    final title = switch (lang) {
      'tr' => 'Yerel İK Arşivini Temizle',
      'da' => 'Ryd lokalt HR-arkiv',
      'de' => 'Lokales HR-Archiv löschen',
      _ => 'Clear Local HR Archive',
    };
    final body = switch (lang) {
      'tr' =>
        'Bu tarayıcıda/cihazda saklanan tüm aday değerlendirme kayıtları kalıcı olarak silinecektir. Onaylıyor musunuz?',
      'da' =>
        'Alle kandidatvurderinger gemt lokalt på denne enhed slettes permanent. Vil du fortsætte?',
      'de' =>
        'Alle lokal auf diesem Gerät gespeicherten Kandidatenberichte werden dauerhaft gelöscht. Fortfahren?',
      _ =>
        'All candidate assessment dossiers stored locally on this device will be permanently deleted. Continue?',
    };
    final cancelLabel = switch (lang) {
      'tr' => 'Vazgeç',
      'da' => 'Annuller',
      'de' => 'Abbrechen',
      _ => 'Cancel',
    };
    final confirmLabel = switch (lang) {
      'tr' => 'Tümünü Sil',
      'da' => 'Slet alle',
      'de' => 'Alle löschen',
      _ => 'Delete All',
    };

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: Text(body),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text(cancelLabel),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: JapandiColors.terracottaClay,
            ),
            onPressed: () => Navigator.of(ctx).pop(true),
            child: Text(confirmLabel),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await ref.read(hrAnalysisProvider.notifier).clearAllArchivedReports();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final reports = ref.watch(hrAnalysisProvider).archivedReports;
    final lang = ref.watch(settingsProvider).languageCode;

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 780),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      l10n.archiveTitle,
                      style: theme.textTheme.displaySmall,
                    ),
                  ),
                  if (reports.isNotEmpty)
                    OutlinedButton.icon(
                      onPressed: () => _confirmClearAll(context, ref, lang),
                      icon: const Icon(
                        Icons.delete_sweep_outlined,
                        size: 18,
                        color: JapandiColors.terracottaClay,
                      ),
                      label: Text(
                        _clearAllLabel(lang),
                        style: theme.textTheme.labelMedium?.copyWith(
                          color: JapandiColors.terracottaClay,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  color: JapandiColors.bambooGreen.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: JapandiColors.bambooGreen.withValues(alpha: 0.25),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 1),
                      child: Icon(
                        Icons.lock_outline,
                        size: 16,
                        color: JapandiColors.bambooGreenLight,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        _localPrivacyNotice(lang),
                        style: theme.textTheme.bodySmall?.copyWith(height: 1.4),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: reports.isEmpty
                    ? Center(
                        child: Text(
                          l10n.archiveEmpty,
                          style: theme.textTheme.bodyMedium,
                          textAlign: TextAlign.center,
                        ),
                      )
                    : ListView.separated(
                        itemCount: reports.length,
                        separatorBuilder: (_, _) => const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final r = reports[index];
                          final dateStr = DateFormat('dd.MM.yyyy HH:mm')
                              .format(r.createdAt);
                          return Card(
                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 18,
                                vertical: 10,
                              ),
                              leading: const Icon(
                                Icons.badge_outlined,
                                color: JapandiColors.brassGold,
                              ),
                              title: Text(
                                '${r.candidateLabel}  •  $dateStr',
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(top: 6),
                                child: Text(
                                  r.executiveSummary,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    tooltip: _deleteTooltip(lang),
                                    icon: Icon(
                                      Icons.delete_outline,
                                      size: 20,
                                      color: theme.colorScheme.onSurface
                                          .withValues(alpha: 0.65),
                                    ),
                                    onPressed: () {
                                      ref
                                          .read(hrAnalysisProvider.notifier)
                                          .deleteArchivedReport(r.id);
                                    },
                                  ),
                                  const Icon(Icons.chevron_right),
                                ],
                              ),
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        HrReportDetailScreen(report: r),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
