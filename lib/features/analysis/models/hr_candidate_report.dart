import 'analysis_mode.dart';

class ObservedGraphologyMetrics {
  final String slant;
  final String pressure;
  final String baseline;
  final String size;
  final String zones;
  final String connectivity;
  final String marginsAndSpacing;
  final String signatureGeometry;

  const ObservedGraphologyMetrics({
    required this.slant,
    required this.pressure,
    required this.baseline,
    required this.size,
    required this.zones,
    required this.connectivity,
    required this.marginsAndSpacing,
    required this.signatureGeometry,
  });

  factory ObservedGraphologyMetrics.fromJson(Map<String, dynamic> json) {
    return ObservedGraphologyMetrics(
      slant: (json['slant'] ?? '').toString(),
      pressure: (json['pressure'] ?? '').toString(),
      baseline: (json['baseline'] ?? '').toString(),
      size: (json['size'] ?? '').toString(),
      zones: (json['zones'] ?? '').toString(),
      connectivity: (json['connectivity'] ?? '').toString(),
      marginsAndSpacing: (json['marginsAndSpacing'] ?? '').toString(),
      signatureGeometry: (json['signatureGeometry'] ?? '').toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        'slant': slant,
        'pressure': pressure,
        'baseline': baseline,
        'size': size,
        'zones': zones,
        'connectivity': connectivity,
        'marginsAndSpacing': marginsAndSpacing,
        'signatureGeometry': signatureGeometry,
      };
}

class CorporateSpectrum {
  final String manageability;
  final String roleArchetype;
  final String resilience;
  final String discipline;

  const CorporateSpectrum({
    required this.manageability,
    required this.roleArchetype,
    required this.resilience,
    required this.discipline,
  });

  factory CorporateSpectrum.fromJson(Map<String, dynamic> json) {
    return CorporateSpectrum(
      manageability: (json['manageability'] ?? '').toString(),
      roleArchetype: (json['roleArchetype'] ?? '').toString(),
      resilience: (json['resilience'] ?? '').toString(),
      discipline: (json['discipline'] ?? '').toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        'manageability': manageability,
        'roleArchetype': roleArchetype,
        'resilience': resilience,
        'discipline': discipline,
      };
}

class HrDimensions {
  final String discipline;
  final String manageability;
  final String roleNature;
  final String resilience;
  final String teamEgo;
  final String redFlags;

  const HrDimensions({
    required this.discipline,
    required this.manageability,
    required this.roleNature,
    required this.resilience,
    required this.teamEgo,
    required this.redFlags,
  });

  factory HrDimensions.fromJson(Map<String, dynamic> json) {
    final discipline = (json['discipline'] ?? json['work'] ?? '').toString();
    final manageability =
        (json['manageability'] ?? json['intellectual'] ?? '').toString();
    final roleNature =
        (json['roleNature'] ?? json['social'] ?? '').toString();
    final resilience =
        (json['resilience'] ?? json['emotional'] ?? '').toString();
    final teamEgo = (json['teamEgo'] ?? json['social'] ?? '').toString();
    final redFlags = (json['redFlags'] ?? json['shadow'] ?? '').toString();

    return HrDimensions(
      discipline: discipline,
      manageability: manageability,
      roleNature: roleNature,
      resilience: resilience,
      teamEgo: teamEgo,
      redFlags: redFlags,
    );
  }

  Map<String, dynamic> toJson() => {
        'discipline': discipline,
        'manageability': manageability,
        'roleNature': roleNature,
        'resilience': resilience,
        'teamEgo': teamEgo,
        'redFlags': redFlags,
      };
}

class HrCandidateReport {
  final String id;
  final String imageHash;
  final DateTime createdAt;
  final AnalysisMode mode;
  final TargetRoleProfile targetRole;
  final String candidateLabel;
  final String localeCode;
  final ObservedGraphologyMetrics observedMetrics;
  final CorporateSpectrum corporateSpectrum;
  final String executiveSummary;
  final String? comparativeSynthesis;
  final HrDimensions dimensions;
  final bool isLiveAi;

  const HrCandidateReport({
    required this.id,
    this.imageHash = '',
    required this.createdAt,
    required this.mode,
    required this.targetRole,
    required this.candidateLabel,
    required this.localeCode,
    required this.observedMetrics,
    required this.corporateSpectrum,
    required this.executiveSummary,
    this.comparativeSynthesis,
    required this.dimensions,
    this.isLiveAi = true,
  });

  HrCandidateReport copyWithCandidateLabel(String newLabel) {
    if (newLabel.trim().isEmpty || newLabel.trim() == candidateLabel) {
      return this;
    }
    return HrCandidateReport(
      id: id,
      imageHash: imageHash,
      createdAt: createdAt,
      mode: mode,
      targetRole: targetRole,
      candidateLabel: newLabel.trim(),
      localeCode: localeCode,
      observedMetrics: observedMetrics,
      corporateSpectrum: corporateSpectrum,
      executiveSummary: executiveSummary,
      comparativeSynthesis: comparativeSynthesis,
      dimensions: dimensions,
      isLiveAi: isLiveAi,
    );
  }

  factory HrCandidateReport.fromJson(Map<String, dynamic> json) {
    final modeName = (json['mode'] ?? 'handwriting').toString();
    final roleName = (json['targetRole'] ?? 'general').toString();

    return HrCandidateReport(
      id: (json['id'] ?? '').toString(),
      imageHash: (json['imageHash'] ?? '').toString(),
      createdAt: DateTime.tryParse((json['createdAt'] ?? '').toString()) ??
          DateTime.now(),
      mode: AnalysisMode.values.firstWhere(
        (m) => m.name == modeName,
        orElse: () => AnalysisMode.handwriting,
      ),
      targetRole: TargetRoleProfile.values.firstWhere(
        (r) => r.name == roleName,
        orElse: () => TargetRoleProfile.general,
      ),
      candidateLabel: (json['candidateLabel'] ?? '').toString(),
      localeCode: (json['localeCode'] ?? 'tr').toString(),
      observedMetrics: ObservedGraphologyMetrics.fromJson(
        Map<String, dynamic>.from(json['observedMetrics'] ?? const {}),
      ),
      corporateSpectrum: CorporateSpectrum.fromJson(
        Map<String, dynamic>.from(json['corporateSpectrum'] ?? const {}),
      ),
      executiveSummary: (json['executiveSummary'] ?? '').toString(),
      comparativeSynthesis: json['comparativeSynthesis']?.toString(),
      dimensions: HrDimensions.fromJson(
        Map<String, dynamic>.from(json['dimensions'] ?? const {}),
      ),
      isLiveAi: (json['isLiveAi'] as bool?) ?? true,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'imageHash': imageHash,
        'createdAt': createdAt.toIso8601String(),
        'mode': mode.name,
        'targetRole': targetRole.name,
        'candidateLabel': candidateLabel,
        'localeCode': localeCode,
        'observedMetrics': observedMetrics.toJson(),
        'corporateSpectrum': corporateSpectrum.toJson(),
        'executiveSummary': executiveSummary,
        'comparativeSynthesis': comparativeSynthesis,
        'dimensions': dimensions.toJson(),
        'isLiveAi': isLiveAi,
      };
}
