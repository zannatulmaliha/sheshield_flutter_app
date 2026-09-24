import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sheshield/core/di/injection.dart';
import 'package:sheshield/features/admin/domain/entities/admin_report.dart';
import 'package:sheshield/features/admin/domain/repositories/i_admin_repository.dart';
import 'package:sheshield/features/admin/domain/usecases/get_report_queue_usecase.dart';
import 'package:sheshield/features/admin/domain/usecases/review_report_usecase.dart';
import 'package:sheshield/features/admin/domain/usecases/suspend_helper_usecase.dart';

part 'admin_queue_provider.g.dart';

/// The pending moderation queue -- one shared list regardless of
/// reporter_role (user report, helper report, or an automated rate-limit
/// flag), per the spec's symmetric-review principle. Backed by
/// AdminRepositoryImpl's short-TTL cache, so build() is cheap to re-invoke.
@riverpod
class AdminQueueController extends _$AdminQueueController {
  @override
  Future<List<AdminReport>> build() => getIt<GetReportQueueUseCase>().call();

  Future<void> refresh() async {
    state = const AsyncLoading<List<AdminReport>>().copyWithPrevious(state);
    state = await AsyncValue.guard(
        () => getIt<GetReportQueueUseCase>().call(forceRefresh: true));
  }

  /// Throws [AdminFailure] on failure -- the calling screen shows it,
  /// nothing is swallowed here. On success, refreshes the queue so the
  /// reviewed report drops out of view immediately.
  Future<void> review({
    required String reportId,
    required ReviewDecision decision,
    required String resolution,
    bool markFalseSos = false,
    String? reviewerName,
  }) async {
    await getIt<ReviewReportUseCase>().call(
      reportId: reportId,
      decision: decision,
      resolution: resolution,
      markFalseSos: markFalseSos,
      reviewerName: reviewerName,
    );
    await refresh();
  }

  /// The spec's §6 fast-track. Returns the released SOS id, if any.
  /// Throws [AdminFailure] on failure.
  Future<String?> suspendHelper({
    required String uid,
    required String reason,
    String? reviewerName,
  }) async {
    final released = await getIt<SuspendHelperUseCase>().call(
      uid: uid,
      reason: reason,
      reviewerName: reviewerName,
    );
    await refresh();
    return released;
  }
}
