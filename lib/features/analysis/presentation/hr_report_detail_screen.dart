import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import '../../../core/theme/japandi_colors.dart';
import '../../../l10n/app_localizations.dart';
import '../models/analysis_mode.dart';
import '../models/hr_candidate_report.dart';
import 'hr_disclaimer_dialog.dart';

class HrReportDetailScreen extends StatelessWidget {
  final HrCandidateReport report;

  const HrReportDetailScreen({super.key, required this.report});

  String _roleLabel(AppLocalizations l10n, TargetRoleProfile role) {
    switch (role) {
      case TargetRoleProfile.general:
        return l10n.roleGeneral;
      case TargetRoleProfile.leadership:
        return l10n.roleLeadership;
      case TargetRoleProfile.execution:
        return l10n.roleExecution;
      case TargetRoleProfile.sales:
        return l10n.roleSales;
      case TargetRoleProfile.technical:
        return l10n.roleTechnical;
    }
  }

  String _modeLabel(AppLocalizations l10n, AnalysisMode mode) {
    switch (mode) {
      case AnalysisMode.handwriting:
        return l10n.modeHandwritingTitle;
      case AnalysisMode.signature:
        return l10n.modeSignatureTitle;
      case AnalysisMode.combined:
        return l10n.modeCombinedTitle;
    }
  }

  String _emphasisMetricLabel(String locale) {
    return switch (locale) {
      'tr' => 'Vurgu & İşaretleme Dinamiği',
      'de' => 'Betonung & Markierungsdynamik',
      'es' => 'Énfasis y Marcas Operativas',
      'da' => 'Fremhævelse & Markeringer',
      'pt' => 'Ênfase e Marcações Operacionais',
      'fr' => 'Soulignements & Gestes d\'Insistance',
      'it' => 'Enfasi e Segni Operativi',
      'nl' => 'Nadruk & Markeringen',
      'sv' => 'Betoning & Markeringar',
      _ => 'Emphasis & Prioritization Gestures',
    };
  }

  String _copyTooltip(String locale) {
    return switch (locale) {
      'tr' => 'Raporu Kopyala',
      'de' => 'Bericht kopieren',
      'es' => 'Copiar informe',
      'da' => 'Kopiér rapport',
      'pt' => 'Copiar relatório',
      'fr' => 'Copier le rapport',
      'it' => 'Copia rapporto',
      'nl' => 'Rapport kopiëren',
      'sv' => 'Kopiera rapport',
      _ => 'Copy Dossier',
    };
  }

  String _shareTooltip(String locale) {
    return switch (locale) {
      'tr' => 'Raporu Paylaş',
      'de' => 'Bericht teilen',
      'es' => 'Compartir informe',
      'da' => 'Del rapport',
      'pt' => 'Partilhar relatório',
      'fr' => 'Partager le rapport',
      'it' => 'Condividi rapporto',
      'nl' => 'Rapport delen',
      'sv' => 'Dela rapport',
      _ => 'Share Dossier',
    };
  }

  String _copiedToast(String locale) {
    return switch (locale) {
      'tr' => 'İK aday değerlendirme raporu panoya kopyalandı.',
      'de' => 'HR-Bewertungsbericht in die Zwischenablage kopiert.',
      'es' => 'Informe de RR. HH. copiado al portapapeles.',
      'da' => 'HR-rapport kopieret til udklipsholder.',
      'pt' => 'Relatório de RH copiado para a área de transferência.',
      'fr' => 'Rapport RH copié dans le presse-papiers.',
      'it' => 'Rapporto HR copiato negli appunti.',
      'nl' => 'HR-rapport gekopieerd naar klembord.',
      'sv' => 'HR-rapport kopierad till urklipp.',
      _ => 'HR candidate assessment copied to clipboard.',
    };
  }

  String _engineBadgeLabel(String locale, bool isLiveAi) {
    if (isLiveAi) {
      return switch (locale) {
        'tr' => 'Canlı Görsel AI',
        'de' => 'Live-Vision-KI',
        'es' => 'IA Visual en Vivo',
        'fr' => 'IA Visuelle en Direct',
        _ => 'Live AI Vision',
      };
    }
    return switch (locale) {
      'tr' => 'Çevrimdışı Geometrik Sentez',
      'de' => 'Lokale Geometrie-Synthese',
      'es' => 'Síntesis Geométrica Local',
      'fr' => 'Synthèse Géométrique Locale',
      _ => 'Offline Geometric Synthesis',
    };
  }

  String _methodologyNote(String locale) {
    return switch (locale) {
      'tr' =>
        'Bilimsel Grafoloji Metodoloji Notu: Bu rapor bütünsel (Gestalt) grafoloji ilkelerine dayanır; tekil bir harf veya çizgiye dayanarak kesin hüküm verilmez. Çizgili/kareli defter kullanımı satır istikametini dışarıdan yönlendirebilir; hızlı toplantı notları ve kalem ucu kalınlığı baskı algısını etkileyebilir. Tüm bulgular yapılandırılmış mülakat ve referans kontrolüyle birlikte değerlendirilmelidir.',
      'de' =>
        'Methodischer Hinweis: Dieser Bericht folgt ganzheitlichen (Gestalt-)Prinzipien der Graphologie. Liniertes Papier, Schreibtempo und Stiftart beeinflussen die Strichmechanik. Alle Hinweise sind im strukturierten Interview zu validieren.',
      _ =>
        'Scientific Graphology Methodology Note: This assessment applies holistic Gestalt graphology principles—no hiring hypothesis rests on an isolated stroke. Ruled paper artificially guides baseline alignment, while note-taking speed and pen nib type influence stroke pressure. Validate all behavioral hypotheses via structured interviews and reference checks.',
    };
  }

  String _formatShareText(AppLocalizations l10n) {
    final buffer = StringBuffer();
    buffer.writeln('=== ${l10n.appTitle}: ${l10n.reportSummaryTitle} ===');
    buffer.writeln('${l10n.candidateContextTitle}: ${report.candidateLabel}');
    buffer.writeln(
        '${l10n.targetRoleLabel}: ${_roleLabel(l10n, report.targetRole)}');
    buffer.writeln();
    buffer.writeln('⚠️ ${l10n.disclaimerShortText}');
    buffer.writeln();
    buffer.writeln('--- ${l10n.reportSummaryTitle} ---');
    buffer.writeln(report.executiveSummary);
    buffer.writeln();
    buffer.writeln('--- ${l10n.spectrumSectionTitle} ---');
    buffer.writeln(
        '• ${l10n.axisManageability}: ${report.corporateSpectrum.manageability}');
    buffer.writeln(
        '• ${l10n.axisRoleType}: ${report.corporateSpectrum.roleArchetype}');
    buffer.writeln(
        '• ${l10n.axisResilience}: ${report.corporateSpectrum.resilience}');
    buffer.writeln(
        '• ${l10n.axisDiscipline}: ${report.corporateSpectrum.discipline}');
    buffer.writeln();
    if (report.mode == AnalysisMode.combined &&
        report.comparativeSynthesis != null &&
        report.comparativeSynthesis!.isNotEmpty) {
      buffer.writeln('--- ${l10n.reportComparisonTitle} ---');
      buffer.writeln(report.comparativeSynthesis);
      buffer.writeln();
    }
    buffer.writeln('--- ${l10n.reportDimensionsTitle} ---');
    buffer.writeln(l10n.dimDiscipline);
    buffer.writeln(report.dimensions.discipline);
    buffer.writeln();
    buffer.writeln(l10n.dimManageability);
    buffer.writeln(report.dimensions.manageability);
    buffer.writeln();
    buffer.writeln(l10n.dimRoleNature);
    buffer.writeln(report.dimensions.roleNature);
    buffer.writeln();
    buffer.writeln(l10n.dimResilience);
    buffer.writeln(report.dimensions.resilience);
    buffer.writeln();
    buffer.writeln(l10n.dimTeamEgo);
    buffer.writeln(report.dimensions.teamEgo);
    buffer.writeln();
    buffer.writeln(l10n.dimRedFlags);
    buffer.writeln(report.dimensions.redFlags);
    buffer.writeln();
    buffer.writeln('ℹ️ ${_methodologyNote(report.localeCode)}');
    return buffer.toString();
  }

  Future<void> _shareReport(BuildContext context, AppLocalizations l10n) async {
    final text = _formatShareText(l10n);
    try {
      await Share.share(
        text,
        subject: '${l10n.appTitle} - ${report.candidateLabel}',
      );
    } catch (_) {
      if (context.mounted) {
        await _copyReport(context, l10n);
      }
    }
  }

  Future<void> _copyReport(BuildContext context, AppLocalizations l10n) async {
    final text = _formatShareText(l10n);
    await Clipboard.setData(ClipboardData(text: text));
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_copiedToast(report.localeCode)),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final isCompact = MediaQuery.of(context).size.width < 520;
    final eighthMetricLabel = report.mode == AnalysisMode.handwriting
        ? _emphasisMetricLabel(report.localeCode)
        : l10n.metricSignatureStyle;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.reportSummaryTitle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        actions: [
          IconButton(
            tooltip: _copyTooltip(report.localeCode),
            onPressed: () => _copyReport(context, l10n),
            icon: const Icon(Icons.copy_all_outlined),
          ),
          IconButton(
            tooltip: _shareTooltip(report.localeCode),
            onPressed: () => _shareReport(context, l10n),
            icon: const Icon(
              Icons.share_outlined,
              color: JapandiColors.brassGold,
            ),
          ),
        ],
      ),
      body: SelectionArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: isCompact ? 14 : 24,
            vertical: isCompact ? 14 : 20,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 840),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Mandatory HR Disclaimer & Zero-Data-Retention Notice
                  const HrDisclaimerBanner(),
                  const SizedBox(height: 16),

                  // Candidate, Role, Mode & Engine Source Badges
                  Wrap(
                    spacing: 10,
                    runSpacing: 8,
                    children: [
                      _BadgeChip(
                        icon: Icons.badge_outlined,
                        label: report.candidateLabel,
                        accent: true,
                      ),
                      _BadgeChip(
                        icon: Icons.work_outline,
                        label: _roleLabel(l10n, report.targetRole),
                      ),
                      _BadgeChip(
                        icon: Icons.draw_outlined,
                        label: _modeLabel(l10n, report.mode),
                      ),
                      _BadgeChip(
                        icon: report.isLiveAi
                            ? Icons.visibility_outlined
                            : Icons.cloud_off_outlined,
                        label: _engineBadgeLabel(
                          report.localeCode,
                          report.isLiveAi,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),

                  // 1. Executive Summary Card
                  _NarrativeCard(
                    title: l10n.reportSummaryTitle,
                    icon: Icons.assignment_ind_outlined,
                    body: report.executiveSummary,
                    accentBorder: true,
                  ),
                  const SizedBox(height: 16),

                  // 2. 4-Axis Corporate Spectrum Card
                  Card(
                    child: Padding(
                      padding: EdgeInsets.all(isCompact ? 16 : 22),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.tune_outlined,
                                color: JapandiColors.brassGold,
                                size: 20,
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  l10n.spectrumSectionTitle,
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 14),
                          _MetricRow(
                            label: l10n.axisManageability,
                            value: report.corporateSpectrum.manageability,
                          ),
                          _MetricRow(
                            label: l10n.axisRoleType,
                            value: report.corporateSpectrum.roleArchetype,
                          ),
                          _MetricRow(
                            label: l10n.axisResilience,
                            value: report.corporateSpectrum.resilience,
                          ),
                          _MetricRow(
                            label: l10n.axisDiscipline,
                            value: report.corporateSpectrum.discipline,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // 3. Comparative Synthesis (Handwriting vs Signature Mask)
                  if (report.mode == AnalysisMode.combined &&
                      report.comparativeSynthesis != null &&
                      report.comparativeSynthesis!.isNotEmpty) ...[
                    _NarrativeCard(
                      title: l10n.reportComparisonTitle,
                      icon: Icons.compare_arrows_outlined,
                      body: report.comparativeSynthesis!,
                    ),
                    const SizedBox(height: 16),
                  ],

                  // 4. 6-Dimension Corporate HR Character Assessment
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Text(
                      l10n.reportDimensionsTitle,
                      style: theme.textTheme.headlineMedium,
                    ),
                  ),
                  const SizedBox(height: 8),

                  _DimensionCard(
                    title: l10n.dimDiscipline,
                    icon: Icons.fact_check_outlined,
                    body: report.dimensions.discipline,
                  ),
                  const SizedBox(height: 12),

                  _DimensionCard(
                    title: l10n.dimManageability,
                    icon: Icons.account_tree_outlined,
                    body: report.dimensions.manageability,
                  ),
                  const SizedBox(height: 12),

                  _DimensionCard(
                    title: l10n.dimRoleNature,
                    icon: Icons.engineering_outlined,
                    body: report.dimensions.roleNature,
                  ),
                  const SizedBox(height: 12),

                  _DimensionCard(
                    title: l10n.dimResilience,
                    icon: Icons.shield_outlined,
                    body: report.dimensions.resilience,
                  ),
                  const SizedBox(height: 12),

                  _DimensionCard(
                    title: l10n.dimTeamEgo,
                    icon: Icons.groups_outlined,
                    body: report.dimensions.teamEgo,
                  ),
                  const SizedBox(height: 12),

                  _DimensionCard(
                    title: l10n.dimRedFlags,
                    icon: Icons.warning_amber_rounded,
                    body: report.dimensions.redFlags,
                    isWarningCard: true,
                  ),
                  const SizedBox(height: 18),

                  // 5. Observed Physical Evidence (Grounding Matrix)
                  Card(
                    child: Padding(
                      padding: EdgeInsets.all(isCompact ? 16 : 22),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.straighten_outlined,
                                color: JapandiColors.brassGold,
                                size: 20,
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  l10n.physicalMetricsTitle,
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 14),
                          _MetricRow(
                            label: l10n.metricSlant,
                            value: report.observedMetrics.slant,
                          ),
                          _MetricRow(
                            label: l10n.metricPressure,
                            value: report.observedMetrics.pressure,
                          ),
                          _MetricRow(
                            label: l10n.metricBaseline,
                            value: report.observedMetrics.baseline,
                          ),
                          _MetricRow(
                            label: l10n.metricSize,
                            value: report.observedMetrics.size,
                          ),
                          _MetricRow(
                            label: l10n.metricZones,
                            value: report.observedMetrics.zones,
                          ),
                          _MetricRow(
                            label: l10n.metricConnectivity,
                            value: report.observedMetrics.connectivity,
                          ),
                          _MetricRow(
                            label: l10n.metricSpacing,
                            value: report.observedMetrics.marginsAndSpacing,
                          ),
                          if (report.observedMetrics.signatureGeometry
                              .trim()
                              .isNotEmpty)
                            _MetricRow(
                              label: eighthMetricLabel,
                              value: report.observedMetrics.signatureGeometry,
                            ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // 6. Scientific Graphology Methodology Footnote
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: theme.cardColor,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: theme.colorScheme.outline,
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 2),
                          child: Icon(
                            Icons.info_outline,
                            size: 16,
                            color: JapandiColors.brassGold,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            _methodologyNote(report.localeCode),
                            style: theme.textTheme.bodySmall?.copyWith(
                              height: 1.48,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 28),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _BadgeChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool accent;

  const _BadgeChip({
    required this.icon,
    required this.label,
    this.accent = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: accent
            ? JapandiColors.brassGold.withValues(alpha: 0.16)
            : theme.cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: accent ? JapandiColors.brassGold : theme.colorScheme.outline,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 14,
            color: accent
                ? JapandiColors.brassGold
                : JapandiColors.bambooGreenLight,
          ),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              label,
              style: theme.textTheme.labelMedium?.copyWith(
                color: theme.colorScheme.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MetricRow extends StatelessWidget {
  final String label;
  final String value;

  const _MetricRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: theme.textTheme.labelMedium?.copyWith(
              color: JapandiColors.brassGold,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.2,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: theme.textTheme.bodyMedium?.copyWith(height: 1.55),
          ),
          const SizedBox(height: 8),
          const Divider(height: 1),
        ],
      ),
    );
  }
}

class _NarrativeCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final String body;
  final bool accentBorder;

  const _NarrativeCard({
    required this.title,
    required this.icon,
    required this.body,
    this.accentBorder = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isCompact = MediaQuery.of(context).size.width < 520;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: accentBorder
              ? JapandiColors.brassGold
              : theme.colorScheme.outline,
          width: accentBorder ? 1.4 : 1.0,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(isCompact ? 16 : 22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: JapandiColors.brassGold, size: 20),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Text(
              body,
              style: theme.textTheme.bodyLarge?.copyWith(height: 1.65),
            ),
          ],
        ),
      ),
    );
  }
}

class _DimensionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final String body;
  final bool isWarningCard;

  const _DimensionCard({
    required this.title,
    required this.icon,
    required this.body,
    this.isWarningCard = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isCompact = MediaQuery.of(context).size.width < 520;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: isWarningCard
              ? JapandiColors.terracottaClay.withValues(alpha: 0.65)
              : theme.colorScheme.outline,
          width: isWarningCard ? 1.3 : 1.0,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(isCompact ? 16 : 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: isWarningCard
                      ? JapandiColors.terracottaClay
                      : JapandiColors.brassGold,
                  size: 19,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              body,
              style: theme.textTheme.bodyMedium?.copyWith(height: 1.6),
            ),
          ],
        ),
      ),
    );
  }
}
