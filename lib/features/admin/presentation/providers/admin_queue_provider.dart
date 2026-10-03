import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sheshield/features/admin/domain/entities/admin_report.dart';
import 'package:sheshield/features/admin/domain/entities/review_decision.dart';
import 'package:sheshield/features/admin/domain/usecases/get_report_queue_usecase.dart';
import 'package:sheshield/features/admin/domain/usecases/review_report_usecase.dart';
import 'package:sheshield/features/admin/domain/usecases/suspend_helper_usecase.dart';
import 'package:sheshield/features/admin/presentation/providers/admin_use_case_providers.dart';

part 'admin_queue_provider.g.dart';

/// The pending moderation queue -- one shared list whoever filed the
/// report (user, helper, or an automated rate-limit flag), per the spec's
/// symmetric-review principle. The repository's short-TTL cache keeps
/// `build()` cheap to re-run.
@riverpod
class AdminQueueController extends _$AdminQueueController {
  late final GetReportQueueUseCase _getReportQueue =
      ref.read(getReportQueueUseCaseProvider);
  late final ReviewReportUseCase _reviewReport = ref.read(reviewReportUseCaseProvider);
  late final SuspendHelperUseCase _suspendHelper =
      ref.read(suspendHelperUseCaseProvider);

  @override
  Future<List<AdminReport>> build() => _getReportQueue();

  Future<void> refresh() async {
    state = const AsyncLoading<List<AdminReport>>().copyWithPrevious(state);
    state = await AsyncValue.guard(() => _getReportQueue(forceRefresh: true));
  }

  /// Throws `AppFailure` on failure; the calling screen shows it. On
  /// success the queue refreshes so the reviewed report drops out.
  Future<void> reviewReport({
    required String reportId,
    required ReviewDecision decision,
    required String resolution,
    bool markFalseSos = false,
  }) async {
    await _reviewReport(
      reportId: reportId,
      decision: decision,
      resolution: resolution,
      markFalseSos: markFalseSos,
    );
    await refresh();
  }

  /// Spec §6 fast-track. Returns the released SOS id, if any.
  Future<String?> suspendHelper({
    required String uid,
    required String reason,
  }) async {
    final releasedSosId = await _suspendHelper(uid: uid, reason: reason);
    await refresh();
    return releasedSosId;
  }
}
