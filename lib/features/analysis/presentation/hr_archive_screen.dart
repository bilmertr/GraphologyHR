import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/japandi_colors.dart';
import '../../../l10n/app_localizations.dart';
import '../providers/hr_analysis_provider.dart';
import 'hr_report_detail_screen.dart';

class HrArchiveScreen extends ConsumerWidget {
  const HrArchiveScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final reports = ref.watch(hrAnalysisProvider).archivedReports;

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 780),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l10n.archiveTitle, style: theme.textTheme.displaySmall),
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
                          final dateStr =
                              DateFormat('dd.MM.yyyy HH:mm').format(r.createdAt);
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
                              trailing: const Icon(Icons.chevron_right),
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
