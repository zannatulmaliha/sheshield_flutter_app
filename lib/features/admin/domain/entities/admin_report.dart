import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sheshield/features/admin/domain/entities/reporter_role.dart';
import 'package:sheshield/features/admin/domain/entities/review_status.dart';

part 'admin_report.freezed.dart';

/// One moderation report, as a reviewer sees it in the queue.
@freezed
class AdminReport with _$AdminReport {
  const AdminReport._();

  const factory AdminReport({
    required String id,
    required String reporterId,
    required String reportedId,
    required ReporterRole reporterRole,
    required String category,
    required ReviewStatus reviewStatus,
    required DateTime createdAt,
    String? sosId,
    String? reviewerId,
    String? resolution,
    DateTime? reviewedAt,
  }) = _AdminReport;

  bool get isSystemFlag => reporterRole == ReporterRole.system;

  bool get isAwaitingDecision => reviewStatus.isAwaitingDecision;
}
