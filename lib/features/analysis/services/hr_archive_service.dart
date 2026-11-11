import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/analysis_mode.dart';
import '../models/hr_candidate_report.dart';

class HrArchiveService {
  static const String _archiveKey = 'graphology_hr_archived_dossiers_v1';

  Future<List<HrCandidateReport>> loadReports() async {
    final prefs = await SharedPreferences.getInstance();
    final rawList = prefs.getStringList(_archiveKey) ?? const [];
    final reports = <HrCandidateReport>[];
    for (final raw in rawList) {
      try {
        final decoded = jsonDecode(raw) as Map<String, dynamic>;
        reports.add(HrCandidateReport.fromJson(decoded));
      } catch (_) {}
    }
    return reports;
  }

  /// Returns an existing Live AI report if the exact same image, mode, targetRole,
  /// and locale were already analyzed—avoiding unnecessary 25s waits.
  Future<HrCandidateReport?> findCachedReport({
    required String imageHash,
    required AnalysisMode mode,
    required TargetRoleProfile targetRole,
    required String localeCode,
  }) async {
    if (imageHash.isEmpty) return null;
    final reports = await loadReports();
    for (final r in reports) {
      if (r.isLiveAi &&
          r.imageHash == imageHash &&
          r.mode == mode &&
          r.targetRole == targetRole &&
          r.localeCode == localeCode) {
        return r;
      }
    }
    return null;
  }

  Future<void> saveReport(HrCandidateReport report) async {
    final prefs = await SharedPreferences.getInstance();
    final current = await loadReports();
    final updated = [
      report,
      ...current.where(
        (r) =>
            r.id != report.id &&
            !(r.imageHash.isNotEmpty &&
                r.imageHash == report.imageHash &&
                r.mode == report.mode &&
                r.targetRole == report.targetRole &&
                r.localeCode == report.localeCode),
      ),
    ].take(50).toList();
    await prefs.setStringList(
      _archiveKey,
      updated.map((r) => jsonEncode(r.toJson())).toList(),
    );
  }

  Future<void> deleteReport(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final current = await loadReports();
    final updated = current.where((r) => r.id != id).toList();
    await prefs.setStringList(
      _archiveKey,
      updated.map((r) => jsonEncode(r.toJson())).toList(),
    );
  }

  Future<void> clearAllReports() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_archiveKey);
  }
}
