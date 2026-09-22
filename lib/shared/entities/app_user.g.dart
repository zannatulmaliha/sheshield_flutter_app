// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppUserImpl _$$AppUserImplFromJson(Map<String, dynamic> json) =>
    _$AppUserImpl(
      uid: json['uid'] as String,
      name: json['name'] as String,
      phone: json['phone'] as String,
      countryCode: json['countryCode'] as String,
      address: json['address'] as String?,
      email: json['email'] as String,
      gender: $enumDecode(_$GenderEnumMap, json['gender']),
      userType: $enumDecodeNullable(_$UserTypeEnumMap, json['userType']) ??
          UserType.user,
      isHelperVerified: json['isHelperVerified'] as bool? ?? false,
      fcmToken: json['fcmToken'] as String?,
      createdAt: const DateTimeConverter().fromJson(json['createdAt']),
    );

Map<String, dynamic> _$$AppUserImplToJson(_$AppUserImpl instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'name': instance.name,
      'phone': instance.phone,
      'countryCode': instance.countryCode,
      'address': instance.address,
      'email': instance.email,
      'gender': _$GenderEnumMap[instance.gender]!,
      'userType': _$UserTypeEnumMap[instance.userType]!,
      'isHelperVerified': instance.isHelperVerified,
      'fcmToken': instance.fcmToken,
      'createdAt': const DateTimeConverter().toJson(instance.createdAt),
    };

const _$GenderEnumMap = {
  Gender.female: 'female',
  Gender.male: 'male',
  Gender.other: 'other',
  Gender.preferNotToSay: 'preferNotToSay',
};

const _$UserTypeEnumMap = {
  UserType.user: 'user',
  UserType.helper: 'helper',
  UserType.userHelper: 'user_helper',
};
