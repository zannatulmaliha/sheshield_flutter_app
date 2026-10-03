import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sheshield/features/sos/domain/entities/alert_status.dart';

part 'alert_summary.freezed.dart';

/// One row of the signed-in user's own SOS history. Unlike `SosAlert` (the
/// just-sent response), delivery outcomes arrive aggregated into counts:
/// a history list only needs "reached N of M".
@freezed
class AlertSummary with _$AlertSummary {
  const AlertSummary._();

  const factory AlertSummary({
    required String id,
    required AlertStatus status,
    required DateTime createdAt,
    DateTime? resolvedAt,
    @Default(0) int sentCount,
    @Default(0) int failedCount,
    @Default(0) int totalCount,
  }) = _AlertSummary;

  bool get isActive => status == AlertStatus.active;
}
