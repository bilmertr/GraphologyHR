import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
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

  Future<void> saveReport(HrCandidateReport report) async {
    final prefs = await SharedPreferences.getInstance();
    final current = await loadReports();
    final updated = [
      report,
      ...current.where((r) => r.id != report.id),
    ].take(50).toList();
    await prefs.setStringList(
      _archiveKey,
      updated.map((r) => jsonEncode(r.toJson())).toList(),
    );
  }
}
