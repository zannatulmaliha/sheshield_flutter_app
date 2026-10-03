// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nearby_alert_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NearbyAlertModelImpl _$$NearbyAlertModelImplFromJson(
        Map<String, dynamic> json) =>
    _$NearbyAlertModelImpl(
      id: json['id'] as String,
      distanceMeters: (json['distanceMeters'] as num).toDouble(),
      createdAt: const DateTimeConverter().fromJson(json['createdAt']),
      roughArea: json['roughArea'] as String? ?? 'Nearby',
      mutualConnection: json['mutualConnection'] as bool? ?? false,
      trigger: json['trigger'] as String? ?? 'manual',
      label: json['label'] as String? ?? 'SOS button pressed',
      riskLevel: json['riskLevel'] as String? ?? 'high',
      duressActive: json['duressActive'] as bool? ?? false,
    );

Map<String, dynamic> _$$NearbyAlertModelImplToJson(
        _$NearbyAlertModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'distanceMeters': instance.distanceMeters,
      'createdAt': const DateTimeConverter().toJson(instance.createdAt),
      'roughArea': instance.roughArea,
      'mutualConnection': instance.mutualConnection,
      'trigger': instance.trigger,
      'label': instance.label,
      'riskLevel': instance.riskLevel,
      'duressActive': instance.duressActive,
    };
