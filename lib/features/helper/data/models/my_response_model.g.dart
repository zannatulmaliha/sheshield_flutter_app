// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MyResponseModelImpl _$$MyResponseModelImplFromJson(
        Map<String, dynamic> json) =>
    _$MyResponseModelImpl(
      id: json['id'] as String,
      userName: json['userName'] as String,
      phone: json['phone'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      acceptedAt: const DateTimeConverter().fromJson(json['acceptedAt']),
      countryCode: json['countryCode'] as String? ?? '',
      requesterUid: json['requesterUid'] as String? ?? '',
      progress: json['progress'] as String? ?? '',
      label: json['label'] as String? ?? 'SOS',
      riskLevel: json['riskLevel'] as String? ?? 'high',
      duressActive: json['duressActive'] as bool? ?? false,
    );

Map<String, dynamic> _$$MyResponseModelImplToJson(
        _$MyResponseModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userName': instance.userName,
      'phone': instance.phone,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'acceptedAt': const DateTimeConverter().toJson(instance.acceptedAt),
      'countryCode': instance.countryCode,
      'requesterUid': instance.requesterUid,
      'progress': instance.progress,
      'label': instance.label,
      'riskLevel': instance.riskLevel,
      'duressActive': instance.duressActive,
    };
