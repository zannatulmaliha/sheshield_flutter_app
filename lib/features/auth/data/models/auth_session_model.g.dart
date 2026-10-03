// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_session_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AuthSessionModelImpl _$$AuthSessionModelImplFromJson(
        Map<String, dynamic> json) =>
    _$AuthSessionModelImpl(
      token: json['token'] as String,
      user: AppUserModel.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$AuthSessionModelImplToJson(
        _$AuthSessionModelImpl instance) =>
    <String, dynamic>{
      'token': instance.token,
      'user': instance.user,
    };
