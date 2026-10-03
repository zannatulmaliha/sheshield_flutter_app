// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppUserModelImpl _$$AppUserModelImplFromJson(Map<String, dynamic> json) =>
    _$AppUserModelImpl(
      uid: json['uid'] as String,
      name: json['name'] as String,
      phone: json['phone'] as String,
      countryCode: json['countryCode'] as String,
      email: json['email'] as String,
      createdAt: const DateTimeConverter().fromJson(json['createdAt']),
      gender: json['gender'] as String? ?? '',
      address: json['address'] as String?,
      userType: json['userType'] as String? ?? 'user',
      isHelperVerified: json['isHelperVerified'] as bool? ?? false,
      fcmToken: json['fcmToken'] as String?,
      discoverableViaMutualConnections:
          json['discoverableViaMutualConnections'] as bool? ?? false,
    );

Map<String, dynamic> _$$AppUserModelImplToJson(_$AppUserModelImpl instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'name': instance.name,
      'phone': instance.phone,
      'countryCode': instance.countryCode,
      'email': instance.email,
      'createdAt': const DateTimeConverter().toJson(instance.createdAt),
      'gender': instance.gender,
      'address': instance.address,
      'userType': instance.userType,
      'isHelperVerified': instance.isHelperVerified,
      'fcmToken': instance.fcmToken,
      'discoverableViaMutualConnections':
          instance.discoverableViaMutualConnections,
    };
