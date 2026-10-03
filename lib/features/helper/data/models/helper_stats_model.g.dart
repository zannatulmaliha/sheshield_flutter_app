// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'helper_stats_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HelperStatsModelImpl _$$HelperStatsModelImplFromJson(
        Map<String, dynamic> json) =>
    _$HelperStatsModelImpl(
      responses: (json['responses'] as num?)?.toInt() ?? 0,
      completed: (json['completed'] as num?)?.toInt() ?? 0,
      resolved: (json['resolved'] as num?)?.toInt() ?? 0,
      successRate: (json['successRate'] as num?)?.toInt() ?? 0,
      avgResponseMinutes: (json['avgResponseMinutes'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$HelperStatsModelImplToJson(
        _$HelperStatsModelImpl instance) =>
    <String, dynamic>{
      'responses': instance.responses,
      'completed': instance.completed,
      'resolved': instance.resolved,
      'successRate': instance.successRate,
      'avgResponseMinutes': instance.avgResponseMinutes,
    };
