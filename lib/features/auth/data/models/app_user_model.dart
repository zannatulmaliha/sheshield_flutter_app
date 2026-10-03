import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sheshield/core/utils/json_converters.dart';
import 'package:sheshield/shared/entities/app_user.dart';
import 'package:sheshield/shared/entities/gender.dart';
import 'package:sheshield/shared/entities/user_type.dart';

part 'app_user_model.freezed.dart';
part 'app_user_model.g.dart';

/// Wire shape of the backend's user object (`/auth/me`, login, signup).
@freezed
class AppUserModel with _$AppUserModel {
  const AppUserModel._();

  const factory AppUserModel({
    required String uid,
    required String name,
    required String phone,
    required String countryCode,
    required String email,
    @DateTimeConverter() required DateTime createdAt,
    @Default('') String gender,
    String? address,
    @Default('user') String userType,
    @Default(false) bool isHelperVerified,
    String? fcmToken,
    @Default(false) bool discoverableViaMutualConnections,
  }) = _AppUserModel;

  factory AppUserModel.fromJson(Map<String, dynamic> json) =>
      _$AppUserModelFromJson(json);

  AppUser toEntity() => AppUser(
        uid: uid,
        name: name,
        phone: phone,
        countryCode: countryCode,
        email: email,
        gender: Gender.values.firstWhere(
          (candidate) => candidate.name == gender,
          orElse: () => Gender.preferNotToSay,
        ),
        createdAt: createdAt,
        address: address,
        userType: UserType.fromWireValue(userType),
        isHelperVerified: isHelperVerified,
        fcmToken: fcmToken,
        discoverableViaMutualConnections: discoverableViaMutualConnections,
      );
}
