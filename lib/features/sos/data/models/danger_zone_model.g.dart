// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'danger_zone_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DangerZoneModelImpl _$$DangerZoneModelImplFromJson(
        Map<String, dynamic> json) =>
    _$DangerZoneModelImpl(
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      riskLevel: json['riskLevel'] as String,
      alertCount: (json['alertCount'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$DangerZoneModelImplToJson(
        _$DangerZoneModelImpl instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'riskLevel': instance.riskLevel,
      'alertCount': instance.alertCount,
    };
