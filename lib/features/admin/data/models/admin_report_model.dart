import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sheshield/core/utils/json_converters.dart';
import 'package:sheshield/core/utils/string_extensions.dart';
import 'package:sheshield/features/admin/domain/entities/admin_report.dart';
import 'package:sheshield/features/admin/domain/entities/reporter_role.dart';
import 'package:sheshield/features/admin/domain/entities/review_status.dart';

part 'admin_report_model.freezed.dart';
part 'admin_report_model.g.dart';

/// Wire shape of the backend's `report.Report`
/// (`GET /admin/reports`, internal/report/model.go).
@freezed
class AdminReportModel with _$AdminReportModel {
  const AdminReportModel._();

  const factory AdminReportModel({
    required String id,
    @Default('') String reporterId,
    @Default('') String reportedId,
    @Default('') String reporterRole,
    @Default('') String category,
    @Default('pending') String reviewStatus,
    @DateTimeConverter() required DateTime createdAt,
    String? sosId,
    String? reviewerId,
    String? resolution,
    @NullableDateTimeConverter() DateTime? reviewedAt,
  }) = _AdminReportModel;

  factory AdminReportModel.fromJson(Map<String, dynamic> json) =>
      _$AdminReportModelFromJson(json);

  AdminReport toEntity() => AdminReport(
        id: id,
        reporterId: reporterId,
        reportedId: reportedId,
        reporterRole: ReporterRole.fromWireValue(reporterRole),
        category: category,
        reviewStatus: ReviewStatus.fromWireValue(reviewStatus),
        createdAt: createdAt,
        sosId: sosId.nullIfEmpty,
        reviewerId: reviewerId.nullIfEmpty,
        resolution: resolution.nullIfEmpty,
        reviewedAt: reviewedAt,
      );
}
