import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sheshield/features/admin/domain/entities/admin_verification.dart';
import 'package:sheshield/features/admin/domain/usecases/decide_verification_usecase.dart';
import 'package:sheshield/features/admin/domain/usecases/get_verification_detail_usecase.dart';
import 'package:sheshield/features/admin/presentation/providers/admin_use_case_providers.dart';
import 'package:sheshield/features/admin/presentation/providers/admin_verification_queue_provider.dart';

part 'admin_verification_detail_provider.g.dart';

/// One verification submission, plus the approve / reject decision.
@riverpod
class AdminVerificationDetailController
    extends _$AdminVerificationDetailController {
  late final GetVerificationDetailUseCase _getVerificationDetail =
      ref.read(getVerificationDetailUseCaseProvider);
  late final DecideVerificationUseCase _decideVerification =
      ref.read(decideVerificationUseCaseProvider);

  @override
  Future<AdminVerification> build(String verificationId) =>
      _getVerificationDetail(verificationId);

  /// Throws `AppFailure` on failure. On success the queue is invalidated so
  /// the list shows the new status when the reviewer goes back.
  Future<void> decide({required bool approved, String note = ''}) async {
    await _decideVerification(
      verificationId: verificationId,
      approved: approved,
      note: note,
    );
    ref.invalidate(adminVerificationQueueControllerProvider);
  }
}
