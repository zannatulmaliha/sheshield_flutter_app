/// One row of GET /api/v1/admin/reports -- mirrors the Go backend's
/// report.Report exactly (internal/report/model.go). Plain Dart (no
/// freezed/build_runner) so this file works without a codegen step.
class AdminReport {
  const AdminReport({
    required this.id,
    required this.reporterId,
    required this.reportedId,
    required this.reporterRole,
    required this.category,
    this.sosId,
    required this.reviewStatus,
    this.reviewerId,
    this.resolution,
    required this.createdAt,
    this.reviewedAt,
  });

  final String id;
  final String reporterId;
  final String reportedId;

  /// 'user' | 'helper' | 'system' (an automated rate-limit flag).
  final String reporterRole;
  final String category;
  final String? sosId;

  /// 'pending' | 'reviewing' | 'actioned' | 'dismissed'.
  final String reviewStatus;
  final String? reviewerId;
  final String? resolution;
  final DateTime createdAt;
  final DateTime? reviewedAt;

  bool get isSystemFlag => reporterRole == 'system';
  bool get isPending =>
      reviewStatus == 'pending' || reviewStatus == 'reviewing';

  factory AdminReport.fromJson(Map<String, dynamic> json) {
    String? optString(String key) {
      final v = json[key];
      return (v is String && v.isNotEmpty) ? v : null;
    }

    return AdminReport(
      id: json['id'] as String,
      reporterId: json['reporterId'] as String? ?? '',
      reportedId: json['reportedId'] as String? ?? '',
      reporterRole: json['reporterRole'] as String? ?? '',
      category: json['category'] as String? ?? '',
      sosId: optString('sosId'),
      reviewStatus: json['reviewStatus'] as String? ?? 'pending',
      reviewerId: optString('reviewerId'),
      resolution: optString('resolution'),
      createdAt: DateTime.tryParse(json['createdAt'] as String? ?? '') ??
          DateTime.now(),
      reviewedAt: DateTime.tryParse(json['reviewedAt'] as String? ?? ''),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'reporterId': reporterId,
        'reportedId': reportedId,
        'reporterRole': reporterRole,
        'category': category,
        if (sosId != null) 'sosId': sosId,
        'reviewStatus': reviewStatus,
        if (reviewerId != null) 'reviewerId': reviewerId,
        if (resolution != null) 'resolution': resolution,
        'createdAt': createdAt.toIso8601String(),
        if (reviewedAt != null) 'reviewedAt': reviewedAt!.toIso8601String(),
      };
}
