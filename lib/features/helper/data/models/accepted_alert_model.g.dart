// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accepted_alert_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AcceptedAlertModelImpl _$$AcceptedAlertModelImplFromJson(
        Map<String, dynamic> json) =>
    _$AcceptedAlertModelImpl(
      id: json['id'] as String,
      userName: json['userName'] as String,
      phone: json['phone'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      acceptedAt: const DateTimeConverter().fromJson(json['acceptedAt']),
      countryCode: json['countryCode'] as String? ?? '',
      requesterUid: json['requesterUid'] as String? ?? '',
    );

Map<String, dynamic> _$$AcceptedAlertModelImplToJson(
        _$AcceptedAlertModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userName': instance.userName,
      'phone': instance.phone,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'acceptedAt': const DateTimeConverter().toJson(instance.acceptedAt),
      'countryCode': instance.countryCode,
      'requesterUid': instance.requesterUid,
    };
