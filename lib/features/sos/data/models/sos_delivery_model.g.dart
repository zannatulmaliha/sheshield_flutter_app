// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sos_delivery_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SosDeliveryModelImpl _$$SosDeliveryModelImplFromJson(
        Map<String, dynamic> json) =>
    _$SosDeliveryModelImpl(
      contactId: json['contactId'] as String,
      name: json['name'] as String,
      channel: json['channel'] as String,
      status: json['status'] as String,
      error: json['error'] as String?,
    );

Map<String, dynamic> _$$SosDeliveryModelImplToJson(
        _$SosDeliveryModelImpl instance) =>
    <String, dynamic>{
      'contactId': instance.contactId,
      'name': instance.name,
      'channel': instance.channel,
      'status': instance.status,
      'error': instance.error,
    };
