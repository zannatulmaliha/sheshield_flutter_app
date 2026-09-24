import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sheshield/core/utils/json_converters.dart';
import 'gender.dart';
import 'user_type.dart';

part 'app_user.freezed.dart';
part 'app_user.g.dart';

/// The authenticated user. Shared across auth, contacts, and helper
/// features -- extend it here as a team decision, never duplicate it
/// per-feature.
@freezed
class AppUser with _$AppUser {
  const factory AppUser({
    required String uid,
    required String name,
    required String phone,
    required String countryCode,
    String? address,
    required String email,
    required Gender gender,
    @Default(UserType.user) UserType userType,
    @Default(false) bool isHelperVerified,
    String? fcmToken,
    @DateTimeConverter() required DateTime createdAt,
    @Default(false) bool discoverableViaMutualConnections,
  }) = _AppUser;

  factory AppUser.fromJson(Map<String, dynamic> json) =>
      _$AppUserFromJson(json);
}