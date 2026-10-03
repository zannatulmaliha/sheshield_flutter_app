// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sos_alert_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SosAlertModelImpl _$$SosAlertModelImplFromJson(Map<String, dynamic> json) =>
    _$SosAlertModelImpl(
      id: json['id'] as String,
      createdAt: const DateTimeConverter().fromJson(json['createdAt']),
      deliveries: (json['deliveries'] as List<dynamic>?)
              ?.map((e) => SosDeliveryModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <SosDeliveryModel>[],
      shareUrl: json['shareUrl'] as String?,
    );

Map<String, dynamic> _$$SosAlertModelImplToJson(_$SosAlertModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt': const DateTimeConverter().toJson(instance.createdAt),
      'deliveries': instance.deliveries,
      'shareUrl': instance.shareUrl,
    };
