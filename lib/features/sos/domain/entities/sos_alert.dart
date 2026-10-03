import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sheshield/features/sos/domain/entities/delivery_status.dart';
import 'package:sheshield/features/sos/domain/entities/sos_delivery.dart';

part 'sos_alert.freezed.dart';

/// The just-sent alert (backend `alert.Alert`). There is deliberately no
/// alert-level status: success is reported per contact via [deliveries],
/// never as one blanket flag. Never cached: a live write must not be served
/// stale.
@freezed
class SosAlert with _$SosAlert {
  const SosAlert._();

  const factory SosAlert({
    required String id,
    required DateTime createdAt,
    required List<SosDelivery> deliveries,

    /// Public live-tracking link contacts get in their SMS. Null until the
    /// server starts sending it.
    String? shareUrl,
  }) = _SosAlert;

  int get sentCount =>
      deliveries.where((delivery) => delivery.status == DeliveryStatus.sent).length;

  int get failedCount =>
      deliveries.where((delivery) => delivery.status == DeliveryStatus.failed).length;
}
