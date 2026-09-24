// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blocked_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BlockedUserImpl _$$BlockedUserImplFromJson(Map<String, dynamic> json) =>
    _$BlockedUserImpl(
      blockerId: json['blockerId'] as String,
      blockedId: json['blockedId'] as String,
      createdAt: const DateTimeConverter().fromJson(json['createdAt']),
    );

Map<String, dynamic> _$$BlockedUserImplToJson(_$BlockedUserImpl instance) =>
    <String, dynamic>{
      'blockerId': instance.blockerId,
      'blockedId': instance.blockedId,
      'createdAt': const DateTimeConverter().toJson(instance.createdAt),
    };
