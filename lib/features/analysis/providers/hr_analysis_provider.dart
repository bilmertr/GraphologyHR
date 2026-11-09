import 'dart:typed_data';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/analysis_mode.dart';
import '../models/hr_candidate_report.dart';
import '../services/hr_archive_service.dart';
import '../services/hr_graphology_api_service.dart';

class HrAnalysisState {
  final AnalysisMode mode;
  final TargetRoleProfile targetRole;
  final String candidateLabel;
  final Uint8List? imageBytes;
  final bool isLoading;
  final HrCandidateReport? activeReport;
  final String? rejectionError;
  final List<HrCandidateReport> archivedReports;

  const HrAnalysisState({
    this.mode = AnalysisMode.handwriting,
    this.targetRole = TargetRoleProfile.general,
    this.candidateLabel = '',
    this.imageBytes,
    this.isLoading = false,
    this.activeReport,
    this.rejectionError,
    this.archivedReports = const [],
  });

  bool get canSubmit => imageBytes != null && !isLoading;

  HrAnalysisState copyWith({
    AnalysisMode? mode,
    TargetRoleProfile? targetRole,
    String? candidateLabel,
    Uint8List? imageBytes,
    bool clearImage = false,
    bool? isLoading,
    HrCandidateReport? activeReport,
    String? rejectionError,
    bool clearError = false,
    List<HrCandidateReport>? archivedReports,
  }) {
    return HrAnalysisState(
      mode: mode ?? this.mode,
      targetRole: targetRole ?? this.targetRole,
      candidateLabel: candidateLabel ?? this.candidateLabel,
      imageBytes: clearImage ? null : (imageBytes ?? this.imageBytes),
      isLoading: isLoading ?? this.isLoading,
      activeReport: activeReport ?? this.activeReport,
      rejectionError:
          clearError ? null : (rejectionError ?? this.rejectionError),
      archivedReports: archivedReports ?? this.archivedReports,
    );
  }
}

class HrAnalysisNotifier extends StateNotifier<HrAnalysisState> {
  final HrGraphologyApiService _apiService;
  final HrArchiveService _archiveService;

  HrAnalysisNotifier(this._apiService, this._archiveService)
      : super(const HrAnalysisState()) {
    _loadArchive();
  }

  Future<void> _loadArchive() async {
    final saved = await _archiveService.loadReports();
    state = state.copyWith(archivedReports: saved);
  }

  void setMode(AnalysisMode mode) {
    state = state.copyWith(mode: mode, clearError: true);
  }

  void setTargetRole(TargetRoleProfile role) {
    state = state.copyWith(targetRole: role, clearError: true);
  }

  void setCandidateLabel(String label) {
    state = state.copyWith(candidateLabel: label);
  }

  void setImageBytes(Uint8List bytes) {
    state = state.copyWith(imageBytes: bytes, clearError: true);
  }

  void clearError() {
    state = state.copyWith(clearError: true);
  }

  Future<HrCandidateReport?> runAnalysis({required String localeCode}) async {
    if (state.imageBytes == null) return null;
    state = state.copyWith(isLoading: true, clearError: true);

    try {
      final report = await _apiService.analyzeSample(
        mode: state.mode,
        targetRole: state.targetRole,
        candidateLabel: state.candidateLabel,
        localeCode: localeCode,
        imageBytes: state.imageBytes!,
      );
      await _archiveService.saveReport(report);
      final updatedArchive = await _archiveService.loadReports();
      state = state.copyWith(
        isLoading: false,
        activeReport: report,
        archivedReports: updatedArchive,
      );
      return report;
    } on GraphologyValidationException catch (e) {
      state = state.copyWith(
        isLoading: false,
        rejectionError: e.reasonKey,
      );
      return null;
    } catch (_) {
      state = state.copyWith(
        isLoading: false,
        rejectionError: 'INVALID_SAMPLE',
      );
      return null;
    }
  }
}

final hrAnalysisProvider =
    StateNotifierProvider<HrAnalysisNotifier, HrAnalysisState>((ref) {
  return HrAnalysisNotifier(
    HrGraphologyApiService(),
    HrArchiveService(),
  );
});
