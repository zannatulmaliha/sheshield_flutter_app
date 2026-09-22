import 'package:sheshield/shared/entities/app_user.dart';
import 'package:sheshield/shared/entities/gender.dart';
import 'package:sheshield/shared/entities/user_type.dart';

/// Contract the presentation layer depends on. No transport type
/// appears here -- data/ translates backend-specific errors into
/// [AuthFailure] below.
abstract class IAuthRepository {
  Stream<AppUser?> get authStateChanges;

  Future<AppUser> signIn({
    required String email,
    required String password,
  });

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

    /// Re-fetches the user from the server and re-emits it on
  /// [authStateChanges]. Used after something changes the account
  /// server-side without the app having triggered it directly (e.g. an
  /// admin approving a helper's verification).
  Future<void> refreshSession();

  Future<AppUser> updateProfile({
    String? name,
    String? phone,
    String? countryCode,
    String? address,
  });
}

class AuthFailure implements Exception {
  const AuthFailure(this.message);
  final String message;

  @override
  String toString() => message;
}