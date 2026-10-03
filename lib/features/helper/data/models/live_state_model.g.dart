// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'live_state_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LiveStateModelImpl _$$LiveStateModelImplFromJson(Map<String, dynamic> json) =>
    _$LiveStateModelImpl(
      status: json['status'] as String? ?? 'accepted',
      progress: json['progress'] as String? ?? '',
      duressActive: json['duressActive'] as bool? ?? false,
      connectivityLost: json['connectivityLost'] as bool? ?? false,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      updatedAt: const NullableDateTimeConverter().fromJson(json['updatedAt']),
    );

Map<String, dynamic> _$$LiveStateModelImplToJson(
        _$LiveStateModelImpl instance) =>
    <String, dynamic>{
      'status': instance.status,
      'progress': instance.progress,
      'duressActive': instance.duressActive,
      'connectivityLost': instance.connectivityLost,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'updatedAt': const NullableDateTimeConverter().toJson(instance.updatedAt),
    };
