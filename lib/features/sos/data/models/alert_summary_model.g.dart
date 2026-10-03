// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alert_summary_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AlertSummaryModelImpl _$$AlertSummaryModelImplFromJson(
        Map<String, dynamic> json) =>
    _$AlertSummaryModelImpl(
      id: json['id'] as String,
      status: json['status'] as String,
      createdAt: const DateTimeConverter().fromJson(json['createdAt']),
      resolvedAt:
          const NullableDateTimeConverter().fromJson(json['resolvedAt']),
      sentCount: (json['sentCount'] as num?)?.toInt() ?? 0,
      failedCount: (json['failedCount'] as num?)?.toInt() ?? 0,
      totalCount: (json['totalCount'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$AlertSummaryModelImplToJson(
        _$AlertSummaryModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'createdAt': const DateTimeConverter().toJson(instance.createdAt),
      'resolvedAt':
          const NullableDateTimeConverter().toJson(instance.resolvedAt),
      'sentCount': instance.sentCount,
      'failedCount': instance.failedCount,
      'totalCount': instance.totalCount,
    };
