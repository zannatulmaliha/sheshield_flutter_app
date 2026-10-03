import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sheshield/shared/entities/gender.dart';
import 'package:sheshield/shared/entities/user_type.dart';

part 'app_user.freezed.dart';

/// The authenticated user. Shared across auth, contacts, and helper
/// features: extend it here as a team decision, never duplicate it
/// per-feature. Its wire form is `AppUserModel` in the auth feature.
@freezed
class AppUser with _$AppUser {
  const factory AppUser({
    required String uid,
    required String name,
    required String phone,
    required String countryCode,
    required String email,
    required Gender gender,
    required DateTime createdAt,
    String? address,
    @Default(UserType.user) UserType userType,
    @Default(false) bool isHelperVerified,
    String? fcmToken,
    @Default(false) bool discoverableViaMutualConnections,
  }) = _AppUser;
}
