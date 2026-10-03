// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_report_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AdminReportDetailModelImpl _$$AdminReportDetailModelImplFromJson(
        Map<String, dynamic> json) =>
    _$AdminReportDetailModelImpl(
      report: AdminReportModel.fromJson(json['report'] as Map<String, dynamic>),
      auditTrail: (json['auditTrail'] as List<dynamic>?)
              ?.map((e) => AuditEntryModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <AuditEntryModel>[],
    );

Map<String, dynamic> _$$AdminReportDetailModelImplToJson(
        _$AdminReportDetailModelImpl instance) =>
    <String, dynamic>{
      'report': instance.report,
      'auditTrail': instance.auditTrail,
    };
