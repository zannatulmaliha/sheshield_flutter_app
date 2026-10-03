import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sheshield/features/admin/domain/entities/admin_verification.dart';
import 'package:sheshield/features/admin/domain/usecases/get_verification_queue_usecase.dart';
import 'package:sheshield/features/admin/presentation/providers/admin_use_case_providers.dart';

part 'admin_verification_queue_provider.g.dart';

/// Helper identity-verification submissions, newest data on every open.
@riverpod
class AdminVerificationQueueController extends _$AdminVerificationQueueController {
  late final GetVerificationQueueUseCase _getVerificationQueue =
      ref.read(getVerificationQueueUseCaseProvider);

  @override
  Future<List<AdminVerification>> build() => _getVerificationQueue();

  Future<void> refresh() async {
    state = const AsyncLoading<List<AdminVerification>>().copyWithPrevious(state);
    state = await AsyncValue.guard(_getVerificationQueue.call);
  }
}
