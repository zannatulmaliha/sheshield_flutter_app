// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'helper_history_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HelperHistoryItemModelImpl _$$HelperHistoryItemModelImplFromJson(
        Map<String, dynamic> json) =>
    _$HelperHistoryItemModelImpl(
      id: json['id'] as String,
      alertId: json['alertId'] as String,
      acceptedAt: const DateTimeConverter().fromJson(json['acceptedAt']),
      label: json['label'] as String? ?? 'SOS',
      outcome: json['outcome'] as String? ?? 'active',
      arrivedAt: const NullableDateTimeConverter().fromJson(json['arrivedAt']),
      endedAt: const NullableDateTimeConverter().fromJson(json['endedAt']),
      responseMinutes: (json['responseMinutes'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$HelperHistoryItemModelImplToJson(
        _$HelperHistoryItemModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'alertId': instance.alertId,
      'acceptedAt': const DateTimeConverter().toJson(instance.acceptedAt),
      'label': instance.label,
      'outcome': instance.outcome,
      'arrivedAt': const NullableDateTimeConverter().toJson(instance.arrivedAt),
      'endedAt': const NullableDateTimeConverter().toJson(instance.endedAt),
      'responseMinutes': instance.responseMinutes,
    };
