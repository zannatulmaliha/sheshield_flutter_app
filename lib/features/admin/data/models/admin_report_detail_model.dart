import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sheshield/features/admin/data/models/admin_report_model.dart';
import 'package:sheshield/features/admin/data/models/audit_entry_model.dart';
import 'package:sheshield/features/admin/domain/entities/admin_report_detail.dart';

part 'admin_report_detail_model.freezed.dart';
part 'admin_report_detail_model.g.dart';

/// Wire shape of `GET /admin/reports/{id}` -> `{ report, auditTrail }`.
/// The backend sends `null` (not `[]`) for an empty trail; the default
/// below covers that.
@freezed
class AdminReportDetailModel with _$AdminReportDetailModel {
  const AdminReportDetailModel._();

  const factory AdminReportDetailModel({
    required AdminReportModel report,
    @Default(<AuditEntryModel>[]) List<AuditEntryModel> auditTrail,
  }) = _AdminReportDetailModel;

  factory AdminReportDetailModel.fromJson(Map<String, dynamic> json) =>
      _$AdminReportDetailModelFromJson(json);

  AdminReportDetail toEntity() => AdminReportDetail(
        report: report.toEntity(),
        auditTrail: auditTrail.map((entry) => entry.toEntity()).toList(),
      );
}
