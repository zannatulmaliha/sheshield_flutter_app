import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sheshield/features/sos/domain/entities/delivery_status.dart';

part 'sos_delivery.freezed.dart';

/// One contact's delivery outcome. [channel] is "device" (texted from this
/// phone's SIM) or "server".
@freezed
class SosDelivery with _$SosDelivery {
  const factory SosDelivery({
    required String contactId,
    required String name,
    required String channel,
    required DeliveryStatus status,
    String? error,
  }) = _SosDelivery;
}
