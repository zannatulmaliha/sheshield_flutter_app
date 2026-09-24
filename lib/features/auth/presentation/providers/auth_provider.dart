import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sheshield/core/di/injection.dart';
import 'package:sheshield/core/services/push_service.dart';
import 'package:sheshield/features/auth/domain/repositories/i_auth_repository.dart';
import 'package:sheshield/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:sheshield/features/auth/domain/usecases/sign_out_usecase.dart';
import 'package:sheshield/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:sheshield/features/auth/domain/usecases/update_profile_usecase.dart';
import 'package:sheshield/features/auth/domain/usecases/set_discoverable_usecase.dart';
import 'package:sheshield/features/auth/domain/usecases/watch_auth_state_usecase.dart';
import 'package:sheshield/shared/entities/app_user.dart';
import 'package:sheshield/shared/entities/gender.dart';
import 'package:sheshield/shared/entities/user_type.dart';

part 'auth_provider.g.dart';

/// Reactive stream of the current signed-in user (null when signed
/// out). The router's redirect and every screen that needs "who's
/// logged in" watch this -- nothing outside data/ ever touches the
/// auth transport directly.
@riverpod
Stream<AppUser?> authState(Ref ref) {
  return getIt<WatchAuthStateUseCase>().call();
}

/// Drives the login/signup/profile forms: loading + error state for
/// whichever *action* is in flight, kept separate from [authState] so
/// a failed action doesn't affect the app's broader auth state.
/// `build` returns nothing meaningful -- this is a "command" notifier,
/// its value only ever represents the last action's loading/error status.
@riverpod
class AuthController extends _$AuthController {
  @override
  FutureOr<void> build() {}

  Future<void> signIn({required String email, required String password}) async {
    state = const AsyncLoading<void>().copyWithPrevious(state);
    state = await AsyncValue.guard(
      () => getIt<SignInUseCase>().call(email: email, password: password),
    );
    if (!state.hasError) getIt<PushService>().registerTokenNow();
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
      () => getIt<SignUpUseCase>().call(
        name: name,
        email: email,
        password: password,
        phone: phone,
        countryCode: countryCode,
        gender: gender,
        userType: userType,
      ),
    );
    if (!state.hasError) getIt<PushService>().registerTokenNow();
  }

  Future<void> signOut() async {
    state = const AsyncLoading<void>().copyWithPrevious(state);
    // Clearing the push token needs the still-valid auth header, so this
    // must happen before SignOutUseCase drops it -- best-effort either way,
    // since a stale token just means this device stops getting alarmed
    // once the account that had it linked also signs out and back in.
    try {
      await getIt<IAuthRepository>().updateFcmToken('');
    } catch (_) {}
    state = await AsyncValue.guard(() => getIt<SignOutUseCase>().call());
  }

  Future<void> updateProfile({
    String? name,
    String? phone,
    String? countryCode,
    String? address,
  }) async {
    state = const AsyncLoading<void>().copyWithPrevious(state);
    state = await AsyncValue.guard(
      () => getIt<UpdateProfileUseCase>().call(
        name: name,
        phone: phone,
        countryCode: countryCode,
        address: address,
      ),
    );
  }

  /// The requester-side half of the §10 mutual-connection double opt-in.
  /// Returns an error message on failure, or null on success -- same
  /// convention as [HelperStatusController]'s toggle methods, so the
  /// caller can show a snackbar without inspecting AsyncValue itself.
  Future<String?> setDiscoverable(bool discoverable) async {
    try {
      await getIt<SetDiscoverableUseCase>().call(discoverable);
      return null;
    } on AuthFailure catch (e) {
      return e.message;
    }
  }
}