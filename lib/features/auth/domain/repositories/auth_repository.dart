import 'package:sheshield/shared/entities/app_user.dart';
import 'package:sheshield/shared/entities/gender.dart';
import 'package:sheshield/shared/entities/user_type.dart';

/// Contract the presentation layer depends on. Failures surface as
/// `AppFailure`; no transport type appears here.
abstract interface class AuthRepository {
  Stream<AppUser?> get authStateChanges;

  Future<AppUser> signIn({required String email, required String password});

  Future<AppUser> signUp({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String countryCode,
    required Gender gender,
    required UserType userType,
  });

  Future<void> signOut();

  /// Re-fetches the user and re-emits it on [authStateChanges]. Used after
  /// the account changes server-side without the app triggering it (e.g. an
  /// admin approving a helper's verification).
  Future<void> refreshSession();

  Future<AppUser> updateProfile({
    String? name,
    String? phone,
    String? countryCode,
    String? address,
  });

  /// Registers this device's push token so an SOS from whoever linked it as
  /// a trusted contact can alarm this phone.
  Future<void> updateFcmToken(String token);

  /// Requester side of the mutual-connection double opt-in (spec §10).
  /// Re-emits the user so the toggle reflects the confirmed server state.
  Future<void> setDiscoverable(bool discoverable);
}
