// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'safety_status_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SafetyStatusModelImpl _$$SafetyStatusModelImplFromJson(
        Map<String, dynamic> json) =>
    _$SafetyStatusModelImpl(
      duressActive: json['duressActive'] as bool? ?? false,
      connectivityLost: json['connectivityLost'] as bool? ?? false,
    );

Map<String, dynamic> _$$SafetyStatusModelImplToJson(
        _$SafetyStatusModelImpl instance) =>
    <String, dynamic>{
      'duressActive': instance.duressActive,
      'connectivityLost': instance.connectivityLost,
    };
