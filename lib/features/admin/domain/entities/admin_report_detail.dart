import 'admin_report.dart';

/// One entry of the reported account's audit trail (Go: audit.Entry).
class AuditEntry {
  const AuditEntry({
    required this.id,
    required this.actorId,
    required this.action,
    this.targetId,
    required this.createdAt,
  });

  final String id;
  final String actorId;
  final String action;
  final String? targetId;
  final DateTime createdAt;

  factory AuditEntry.fromJson(Map<String, dynamic> json) => AuditEntry(
        id: json['id'] as String? ?? '',
        actorId: json['actorId'] as String? ?? '',
        action: json['action'] as String? ?? '',
        targetId: json['targetId'] as String?,
        createdAt: DateTime.tryParse(json['createdAt'] as String? ?? '') ??
            DateTime.now(),
      );
}

/// GET /api/v1/admin/reports/{id} -> { report, auditTrail }.
class AdminReportDetail {
  const AdminReportDetail({required this.report, required this.auditTrail});

  final AdminReport report;
  final List<AuditEntry> auditTrail;

  factory AdminReportDetail.fromJson(Map<String, dynamic> json) {
    // The backend sends `null` (not []) when the trail is empty/unavailable.
    final trail = (json['auditTrail'] as List<dynamic>?) ?? const [];
    return AdminReportDetail(
      report: AdminReport.fromJson(json['report'] as Map<String, dynamic>),
      auditTrail: trail
          .map((e) => AuditEntry.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
