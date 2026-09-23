import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sheshield/core/utils/json_converters.dart';

part 'alert_summary.freezed.dart';
part 'alert_summary.g.dart';

/// One row of the signed-in user's own SOS history (GET /api/v1/alerts,
/// internal/alert.Handler.listMine) -- what the notification-history screen
/// shows. Unlike [SosAlert] (the just-sent response, with a per-contact
/// [SosAlert.deliveries] list), the backend aggregates delivery outcomes
/// into counts here since a history list never needs the per-contact
/// breakdown, only "reached N of M".
@freezed
class AlertSummary with _$AlertSummary {
  const AlertSummary._();

  const factory AlertSummary({
    required String id,
    required String status,
    @DateTimeConverter() required DateTime createdAt,
    @NullableDateTimeConverter() DateTime? resolvedAt,
    @Default(0) int sentCount,
    @Default(0) int failedCount,
    @Default(0) int totalCount,
  }) = _AlertSummary;

  factory AlertSummary.fromJson(Map<String, dynamic> json) =>
      _$AlertSummaryFromJson(json);

  bool get isActive => status == 'active';
}
