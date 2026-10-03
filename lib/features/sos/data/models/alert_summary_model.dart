import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sheshield/core/utils/json_converters.dart';
import 'package:sheshield/features/sos/domain/entities/alert_status.dart';
import 'package:sheshield/features/sos/domain/entities/alert_summary.dart';

part 'alert_summary_model.freezed.dart';
part 'alert_summary_model.g.dart';

/// Wire shape of one row of `GET /alerts`.
@freezed
class AlertSummaryModel with _$AlertSummaryModel {
  const AlertSummaryModel._();

  const factory AlertSummaryModel({
    required String id,
    required String status,
    @DateTimeConverter() required DateTime createdAt,
    @NullableDateTimeConverter() DateTime? resolvedAt,
    @Default(0) int sentCount,
    @Default(0) int failedCount,
    @Default(0) int totalCount,
  }) = _AlertSummaryModel;

  factory AlertSummaryModel.fromJson(Map<String, dynamic> json) =>
      _$AlertSummaryModelFromJson(json);

  AlertSummary toEntity() => AlertSummary(
        id: id,
        status: AlertStatus.fromWireValue(status),
        createdAt: createdAt,
        resolvedAt: resolvedAt,
        sentCount: sentCount,
        failedCount: failedCount,
        totalCount: totalCount,
      );
}
