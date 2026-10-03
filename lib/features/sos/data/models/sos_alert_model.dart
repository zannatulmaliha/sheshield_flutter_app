import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sheshield/core/utils/json_converters.dart';
import 'package:sheshield/features/sos/data/models/sos_delivery_model.dart';
import 'package:sheshield/features/sos/domain/entities/sos_alert.dart';

part 'sos_alert_model.freezed.dart';
part 'sos_alert_model.g.dart';

/// Wire shape of `POST /alerts` -> `data`.
@freezed
class SosAlertModel with _$SosAlertModel {
  const SosAlertModel._();

  const factory SosAlertModel({
    required String id,
    @DateTimeConverter() required DateTime createdAt,
    @Default(<SosDeliveryModel>[]) List<SosDeliveryModel> deliveries,
    String? shareUrl,
  }) = _SosAlertModel;

  factory SosAlertModel.fromJson(Map<String, dynamic> json) =>
      _$SosAlertModelFromJson(json);

  SosAlert toEntity() => SosAlert(
        id: id,
        createdAt: createdAt,
        deliveries: deliveries.map((delivery) => delivery.toEntity()).toList(),
        shareUrl: shareUrl,
      );
}
