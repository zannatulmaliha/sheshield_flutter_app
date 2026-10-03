import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sheshield/core/utils/json_converters.dart';
import 'package:sheshield/features/helper/domain/entities/helper_history_item.dart';
import 'package:sheshield/features/helper/domain/entities/response_outcome.dart';

part 'helper_history_item_model.freezed.dart';
part 'helper_history_item_model.g.dart';

/// Wire shape of one row of `GET /helper/history`.
@freezed
class HelperHistoryItemModel with _$HelperHistoryItemModel {
  const HelperHistoryItemModel._();

  const factory HelperHistoryItemModel({
    required String id,
    required String alertId,
    @DateTimeConverter() required DateTime acceptedAt,
    @Default('SOS') String label,
    @Default('active') String outcome,
    @NullableDateTimeConverter() DateTime? arrivedAt,
    @NullableDateTimeConverter() DateTime? endedAt,
    double? responseMinutes,
  }) = _HelperHistoryItemModel;

  factory HelperHistoryItemModel.fromJson(Map<String, dynamic> json) =>
      _$HelperHistoryItemModelFromJson(json);

  HelperHistoryItem toEntity() => HelperHistoryItem(
        id: id,
        alertId: alertId,
        label: label,
        acceptedAt: acceptedAt,
        outcome: ResponseOutcome.fromWireValue(outcome),
        arrivedAt: arrivedAt,
        endedAt: endedAt,
        responseMinutes: responseMinutes,
      );
}
