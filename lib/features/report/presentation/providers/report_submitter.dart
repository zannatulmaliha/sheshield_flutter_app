import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sheshield/core/error/app_failure.dart';
import 'package:sheshield/features/report/domain/entities/report_category.dart';
import 'package:sheshield/features/report/domain/usecases/block_user_usecase.dart';
import 'package:sheshield/features/report/domain/usecases/file_report_usecase.dart';
import 'package:sheshield/features/report/presentation/providers/report_use_case_providers.dart';

/// Files a report and, only if the person asked, blocks the same user.
/// Returns the messages to show, in order, so the UI never owns the flow.
class ReportSubmitter {
  const ReportSubmitter({
    required FileReportUseCase fileReport,
    required BlockUserUseCase blockUser,
  })  : _fileReport = fileReport,
        _blockUser = blockUser;

  final FileReportUseCase _fileReport;
  final BlockUserUseCase _blockUser;

  Future<List<String>> submit({
    required String reportedId,
    required ReportCategory category,
    required String reporterRole,
    required bool alsoBlock,
    String? sosId,
  }) async {
    try {
      await _fileReport(
        reportedId: reportedId,
        category: category,
        reporterRole: reporterRole,
        sosId: sosId,
      );
    } on AppFailure catch (failure) {
      return [failure.message];
    }

    final messages = ['Report filed. A reviewer will look into this.'];
    if (alsoBlock) messages.add(await _blockAndDescribe(reportedId));
    return messages;
  }

  Future<String> _blockAndDescribe(String reportedId) async {
    try {
      await _blockUser(reportedId);
      return 'Blocked. You can unblock them anytime from Settings.';
    } on AppFailure catch (failure) {
      return failure.message;
    }
  }
}

final reportSubmitterProvider = Provider<ReportSubmitter>(
  (ref) => ReportSubmitter(
    fileReport: ref.watch(fileReportUseCaseProvider),
    blockUser: ref.watch(blockUserUseCaseProvider),
  ),
);
