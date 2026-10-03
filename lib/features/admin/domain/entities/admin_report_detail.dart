import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sheshield/features/admin/domain/entities/admin_report.dart';
import 'package:sheshield/features/admin/domain/entities/audit_entry.dart';

part 'admin_report_detail.freezed.dart';

/// A report plus the reported account's full audit trail.
@freezed
class AdminReportDetail with _$AdminReportDetail {
  const factory AdminReportDetail({
    required AdminReport report,
    required List<AuditEntry> auditTrail,
  }) = _AdminReportDetail;
}
