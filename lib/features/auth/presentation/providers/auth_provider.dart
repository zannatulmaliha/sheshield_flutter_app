import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sheshield/core/di/service_providers.dart';
import 'package:sheshield/core/error/app_failure.dart';
import 'package:sheshield/core/services/push_service.dart';
import 'package:sheshield/features/auth/domain/usecases/set_discoverable_usecase.dart';
import 'package:sheshield/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:sheshield/features/auth/domain/usecases/sign_out_usecase.dart';
import 'package:sheshield/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:sheshield/features/auth/domain/usecases/update_fcm_token_usecase.dart';
import 'package:sheshield/features/auth/domain/usecases/update_profile_usecase.dart';
import 'package:sheshield/features/auth/presentation/providers/auth_use_case_providers.dart';
import 'package:sheshield/shared/entities/app_user.dart';
import 'package:sheshield/shared/entities/gender.dart';
import 'package:sheshield/shared/entities/user_type.dart';

part 'auth_provider.g.dart';

/// Reactive stream of the current signed-in user (null when signed out).
/// The router's redirect and every screen that needs "who's signed in"
/// watch this; nothing outside data/ touches the auth transport.
@riverpod
Stream<AppUser?> authState(AuthStateRef ref) {
  final watchAuthState = ref.watch(watchAuthStateUseCaseProvider);
  return watchAuthState();
}

/// Drives the login / signup / profile forms: loading + error state for
/// whichever *action* is in flight, kept separate from [authState] so a
/// failed action doesn't affect the app's broader auth state. `build`
/// returns nothing meaningful: the value only ever represents the last
/// action's loading/error status.
@riverpod
class AuthController extends _$AuthController {
  late final SignInUseCase _signIn = ref.read(signInUseCaseProvider);
  late final SignUpUseCase _signUp = ref.read(signUpUseCaseProvider);
  late final SignOutUseCase _signOut = ref.read(signOutUseCaseProvider);
  late final UpdateProfileUseCase _updateProfile =
      ref.read(updateProfileUseCaseProvider);
  late final UpdateFcmTokenUseCase _updateFcmToken =
      ref.read(updateFcmTokenUseCaseProvider);
  late final SetDiscoverableUseCase _setDiscoverable =
      ref.read(setDiscoverableUseCaseProvider);
  late final PushService _pushService = ref.read(pushServiceProvider);

  @override
  FutureOr<void> build() {}

  Future<void> signIn({required String email, required String password}) async {
    state = const AsyncLoading<void>().copyWithPrevious(state);
    state = await AsyncValue.guard(() => _signIn(email: email, password: password));
    if (!state.hasError) _pushService.registerTokenNow();
  }

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String countryCode,
    required Gender gender,
    required UserType userType,
  }) async {
    state = const AsyncLoading<void>().copyWithPrevious(state);
    state = await AsyncValue.guard(
      () => _signUp(
        name: name,
        email: email,
        password: password,
        phone: phone,
        countryCode: countryCode,
        gender: gender,
        userType: userType,
      ),
    );
    if (!state.hasError) _pushService.registerTokenNow();
  }

  Future<void> signOut() async {
    state = const AsyncLoading<void>().copyWithPrevious(state);
    // Clearing the push token needs the still-valid auth header, so it must
    // happen before the sign-out drops it. Best-effort either way.
    try {
      await _updateFcmToken('');
    } on AppFailure {
      // a stale token only means this phone may still be alarmed for a while
    }
    state = await AsyncValue.guard(_signOut.call);
  }

  Future<void> updateProfile({
    String? name,
    String? phone,
    String? countryCode,
    String? address,
  }) async {
    state = const AsyncLoading<void>().copyWithPrevious(state);
    state = await AsyncValue.guard(
      () => _updateProfile(
        name: name,
        phone: phone,
        countryCode: countryCode,
        address: address,
      ),
    );
  }

  /// Requester side of the §10 mutual-connection double opt-in. Returns an
  /// error message on failure, or null on success, so the caller can show a
  /// snackbar without inspecting [AsyncValue].
  Future<String?> setDiscoverable(bool discoverable) async {
    try {
      await _setDiscoverable(discoverable);
      return null;
    } on AppFailure catch (failure) {
      return failure.message;
    }
  }
}
