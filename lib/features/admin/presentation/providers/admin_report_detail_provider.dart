import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sheshield/features/admin/domain/entities/admin_report_detail.dart';
import 'package:sheshield/features/admin/presentation/providers/admin_use_case_providers.dart';

part 'admin_report_detail_provider.g.dart';

/// One report with its audit trail. Always fetched fresh (never reused
/// from the queue): the same reviewer may act on a report from two
/// devices, so a possibly-stale copy is the wrong trade-off.
@riverpod
class AdminReportDetailController extends _$AdminReportDetailController {
  @override
  Future<AdminReportDetail> build(String reportId) {
    final getReportDetail = ref.read(getReportDetailUseCaseProvider);
    return getReportDetail(reportId);
  }
}
