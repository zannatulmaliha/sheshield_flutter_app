import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sheshield/features/sos/domain/entities/delivery_status.dart';
import 'package:sheshield/features/sos/domain/entities/sos_delivery.dart';

part 'sos_delivery_model.freezed.dart';
part 'sos_delivery_model.g.dart';

@freezed
class SosDeliveryModel with _$SosDeliveryModel {
  const SosDeliveryModel._();

  const factory SosDeliveryModel({
    required String contactId,
    required String name,
    required String channel,
    required String status,
    String? error,
  }) = _SosDeliveryModel;

  factory SosDeliveryModel.fromJson(Map<String, dynamic> json) =>
      _$SosDeliveryModelFromJson(json);

  SosDelivery toEntity() => SosDelivery(
        contactId: contactId,
        name: name,
        channel: channel,
        status: DeliveryStatus.fromWireValue(status),
        error: error,
      );
}
