// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accepted_alert.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AcceptedAlertImpl _$$AcceptedAlertImplFromJson(Map<String, dynamic> json) =>
    _$AcceptedAlertImpl(
      id: json['id'] as String,
      userName: json['userName'] as String,
      phone: json['phone'] as String,
      countryCode: json['countryCode'] as String? ?? '',
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      acceptedAt: const DateTimeConverter().fromJson(json['acceptedAt']),
      requesterUid: json['requesterUid'] as String? ?? '',
    );

Map<String, dynamic> _$$AcceptedAlertImplToJson(_$AcceptedAlertImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userName': instance.userName,
      'phone': instance.phone,
      'countryCode': instance.countryCode,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'acceptedAt': const DateTimeConverter().toJson(instance.acceptedAt),
      'requesterUid': instance.requesterUid,
    };
