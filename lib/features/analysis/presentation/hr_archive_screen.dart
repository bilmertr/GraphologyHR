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

  Future<void> _confirmClearAll(
    BuildContext context,
    WidgetRef ref,
    String lang,
  ) async {
    final isTr = lang == 'tr';
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          isTr ? 'Yerel İK Arşivini Temizle' : 'Clear Local HR Archive',
        ),
        content: Text(
          isTr
              ? 'Bu tarayıcıda/cihazda saklanan tüm aday değerlendirme kayıtları kalıcı olarak silinecektir. Onaylıyor musunuz?'
              : 'All candidate assessment dossiers stored locally on this device will be permanently deleted. Continue?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text(isTr ? 'Vazgeç' : 'Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: JapandiColors.terracottaClay,
            ),
            onPressed: () => Navigator.of(ctx).pop(true),
            child: Text(isTr ? 'Tümünü Sil' : 'Delete All'),
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
    final isTr = lang == 'tr';

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
                        isTr ? 'Arşivi Temizle' : 'Clear All',
                        style: theme.textTheme.labelMedium?.copyWith(
                          color: JapandiColors.terracottaClay,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                ],
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
                                    tooltip: isTr ? 'Kaydı Sil' : 'Delete',
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
