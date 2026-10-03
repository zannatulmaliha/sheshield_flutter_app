// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_report_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AdminReportModelImpl _$$AdminReportModelImplFromJson(
        Map<String, dynamic> json) =>
    _$AdminReportModelImpl(
      id: json['id'] as String,
      reporterId: json['reporterId'] as String? ?? '',
      reportedId: json['reportedId'] as String? ?? '',
      reporterRole: json['reporterRole'] as String? ?? '',
      category: json['category'] as String? ?? '',
      reviewStatus: json['reviewStatus'] as String? ?? 'pending',
      createdAt: const DateTimeConverter().fromJson(json['createdAt']),
      sosId: json['sosId'] as String?,
      reviewerId: json['reviewerId'] as String?,
      resolution: json['resolution'] as String?,
      reviewedAt:
          const NullableDateTimeConverter().fromJson(json['reviewedAt']),
    );

Map<String, dynamic> _$$AdminReportModelImplToJson(
        _$AdminReportModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'reporterId': instance.reporterId,
      'reportedId': instance.reportedId,
      'reporterRole': instance.reporterRole,
      'category': instance.category,
      'reviewStatus': instance.reviewStatus,
      'createdAt': const DateTimeConverter().toJson(instance.createdAt),
      'sosId': instance.sosId,
      'reviewerId': instance.reviewerId,
      'resolution': instance.resolution,
      'reviewedAt':
          const NullableDateTimeConverter().toJson(instance.reviewedAt),
    };
