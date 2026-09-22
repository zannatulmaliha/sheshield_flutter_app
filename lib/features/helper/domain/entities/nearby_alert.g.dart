// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nearby_alert.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NearbyAlertImpl _$$NearbyAlertImplFromJson(Map<String, dynamic> json) =>
    _$NearbyAlertImpl(
      id: json['id'] as String,
      roughArea: json['roughArea'] as String? ?? 'Nearby',
      distanceMeters: (json['distanceMeters'] as num).toDouble(),
      createdAt: const DateTimeConverter().fromJson(json['createdAt']),
    );

Map<String, dynamic> _$$NearbyAlertImplToJson(_$NearbyAlertImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'roughArea': instance.roughArea,
      'distanceMeters': instance.distanceMeters,
      'createdAt': const DateTimeConverter().toJson(instance.createdAt),
    };
