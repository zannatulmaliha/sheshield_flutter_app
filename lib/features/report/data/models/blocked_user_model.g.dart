// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blocked_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BlockedUserModelImpl _$$BlockedUserModelImplFromJson(
        Map<String, dynamic> json) =>
    _$BlockedUserModelImpl(
      blockerId: json['blockerId'] as String,
      blockedId: json['blockedId'] as String,
      createdAt: const DateTimeConverter().fromJson(json['createdAt']),
    );

Map<String, dynamic> _$$BlockedUserModelImplToJson(
        _$BlockedUserModelImpl instance) =>
    <String, dynamic>{
      'blockerId': instance.blockerId,
      'blockedId': instance.blockedId,
      'createdAt': const DateTimeConverter().toJson(instance.createdAt),
    };
