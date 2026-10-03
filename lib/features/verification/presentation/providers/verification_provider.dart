import 'dart:async';
import 'dart:typed_data';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sheshield/core/error/app_failure.dart';
import 'package:sheshield/features/auth/domain/usecases/refresh_session_usecase.dart';
import 'package:sheshield/features/auth/presentation/providers/auth_use_case_providers.dart';
import 'package:sheshield/features/verification/domain/entities/verification_status.dart';
import 'package:sheshield/features/verification/domain/usecases/get_verification_status_usecase.dart';
import 'package:sheshield/features/verification/domain/usecases/submit_verification_usecase.dart';
import 'package:sheshield/features/verification/presentation/providers/verification_use_case_providers.dart';

part 'verification_provider.g.dart';

/// Where the signed-in helper's ID review stands.
@riverpod
class VerificationController extends _$VerificationController {
  late final GetVerificationStatusUseCase _getVerificationStatus =
      ref.read(getVerificationStatusUseCaseProvider);
  late final SubmitVerificationUseCase _submitVerification =
      ref.read(submitVerificationUseCaseProvider);
  late final RefreshSessionUseCase _refreshSession =
      ref.read(refreshSessionUseCaseProvider);

  @override
  Future<VerificationStatus> build() => _getVerificationStatus();

  /// Throws [AppFailure] when the upload is rejected; the status is
  /// re-fetched first so the screen never shows a stale state.
  Future<void> submit({
    required Uint8List nidFront,
    required Uint8List nidBack,
    required Uint8List selfie,
  }) async {
    state = const AsyncLoading<VerificationStatus>().copyWithPrevious(state);
    try {
      final submittedStatus = await _submitVerification(
        nidFront: nidFront,
        nidBack: nidBack,
        selfie: selfie,
      );
      state = AsyncData(submittedStatus);
    } on AppFailure {
      state = await AsyncValue.guard(_getVerificationStatus.call);
      rethrow;
    }
  }

  /// Pull-to-refresh, and "Check now" while pending.
  Future<void> refresh() async {
    state = await AsyncValue.guard(_getVerificationStatus.call);
    if (state.valueOrNull?.status == VerificationState.approved) {
      // Approval flips isHelperVerified server-side; pull it into the
      // session so the dashboard gate reacts without an app restart.
      await _refreshSession();
    }
  }
}
