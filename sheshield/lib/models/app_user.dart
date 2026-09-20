import 'gender.dart';
import 'user_type.dart';

/// Deliberately plain (no freezed/json_serializable) — this scope is just
/// auth wired to Go, not the full codegen stack from the earlier draft.
/// Add those later if/when more models justify the build_runner step.
class AppUser {
  const AppUser({
    required this.uid,
    required this.name,
    required this.phone,
    required this.countryCode,
    required this.email,
    required this.gender,
    required this.userType,
    required this.isHelperVerified,
    this.fcmToken,
    required this.createdAt,
  });

  final String uid;
  final String name;
  final String phone;
  final String countryCode;
  final String email;
  final Gender gender;
  final UserType userType;
  final bool isHelperVerified;
  final String? fcmToken;
  final DateTime createdAt;

  factory AppUser.fromJson(Map<String, dynamic> json) => AppUser(
        uid: json['uid'] as String,
        name: json['name'] as String,
        phone: json['phone'] as String,
        countryCode: json['countryCode'] as String,
        email: json['email'] as String,
        gender: GenderJson.fromApi(json['gender'] as String),
        userType: UserTypeJson.fromApi(json['userType'] as String),
        isHelperVerified: json['isHelperVerified'] as bool? ?? false,
        fcmToken: json['fcmToken'] as String?,
        createdAt: DateTime.parse(json['createdAt'] as String),
      );
}
