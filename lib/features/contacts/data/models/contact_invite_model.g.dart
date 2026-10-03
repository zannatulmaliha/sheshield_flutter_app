// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_invite_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ContactInviteModelImpl _$$ContactInviteModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ContactInviteModelImpl(
      code: json['code'] as String,
      expiresAt: const DateTimeConverter().fromJson(json['expiresAt']),
    );

Map<String, dynamic> _$$ContactInviteModelImplToJson(
        _$ContactInviteModelImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'expiresAt': const DateTimeConverter().toJson(instance.expiresAt),
    };
