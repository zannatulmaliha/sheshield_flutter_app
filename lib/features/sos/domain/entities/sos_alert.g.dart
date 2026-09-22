// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sos_alert.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SosAlertImpl _$$SosAlertImplFromJson(Map<String, dynamic> json) =>
    _$SosAlertImpl(
      id: json['id'] as String,
      createdAt: const DateTimeConverter().fromJson(json['createdAt']),
      deliveries: (json['deliveries'] as List<dynamic>)
          .map((e) => SosDelivery.fromJson(e as Map<String, dynamic>))
          .toList(),
      shareUrl: json['shareUrl'] as String?,
    );

Map<String, dynamic> _$$SosAlertImplToJson(_$SosAlertImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt': const DateTimeConverter().toJson(instance.createdAt),
      'deliveries': instance.deliveries,
      'shareUrl': instance.shareUrl,
    };

_$SosDeliveryImpl _$$SosDeliveryImplFromJson(Map<String, dynamic> json) =>
    _$SosDeliveryImpl(
      contactId: json['contactId'] as String,
      name: json['name'] as String,
      channel: json['channel'] as String,
      status: json['status'] as String,
      error: json['error'] as String?,
    );

Map<String, dynamic> _$$SosDeliveryImplToJson(_$SosDeliveryImpl instance) =>
    <String, dynamic>{
      'contactId': instance.contactId,
      'name': instance.name,
      'channel': instance.channel,
      'status': instance.status,
      'error': instance.error,
    };
