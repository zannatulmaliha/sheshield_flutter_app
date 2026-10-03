import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sheshield/features/helper/domain/entities/response_outcome.dart';

part 'helper_history_item.freezed.dart';

/// One past response, for the History tab.
@freezed
class HelperHistoryItem with _$HelperHistoryItem {
  const factory HelperHistoryItem({
    required String id,
    required String alertId,
    required String label,
    required DateTime acceptedAt,
    required ResponseOutcome outcome,
    DateTime? arrivedAt,
    DateTime? endedAt,
    double? responseMinutes,
  }) = _HelperHistoryItem;
}
