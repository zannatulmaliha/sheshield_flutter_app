import 'dart:async';
import 'dart:typed_data';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sheshield/core/di/injection.dart';
import 'package:sheshield/features/auth/domain/usecases/refresh_session_usecase.dart';
import '../../domain/entities/verification_status.dart';
import '../../domain/repositories/i_verification_repository.dart';
import '../../domain/usecases/get_verification_status_usecase.dart';
import '../../domain/usecases/submit_verification_usecase.dart';

part 'verification_provider.g.dart';

/// Where a helper's ID review stands.
@riverpod
class VerificationController extends _$VerificationController {
  @override
  Future<VerificationStatus> build() => getIt<GetVerificationStatusUseCase>().call();

  Future<String?> submit({
    required Uint8List nidFront,
    required Uint8List nidBack,
    required Uint8List selfie,
  }) async {
    state = const AsyncLoading<VerificationStatus>().copyWithPrevious(state);
    try {
      final result = await getIt<SubmitVerificationUseCase>().call(
        nidFront: nidFront,
        nidBack: nidBack,
        selfie: selfie,
      );
      state = AsyncData(result);
      return null;
    } on VerificationFailure catch (e) {
      state = await AsyncValue.guard(() => getIt<GetVerificationStatusUseCase>().call());
      return e.message;
    }
  }

  /// Pull-to-refresh, and the check triggered by "Check now" while pending.
  Future<void> refresh() async {
    state = await AsyncValue.guard(() => getIt<GetVerificationStatusUseCase>().call());
    if (state.valueOrNull?.status == VerificationState.approved) {
      // Approval flips isHelperVerified server-side; pull it into the
      // session so the dashboard gate reacts without a manual app restart.
      await getIt<RefreshSessionUseCase>().call();
    }
  }
}