import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sheshield/core/utils/json_converters.dart';

part 'sos_alert.freezed.dart';
part 'sos_alert.g.dart';

/// Mirrors the Go backend's `alert.Alert` exactly (internal/alert/model.go).
/// Note there is no alert-level `status` -- the backend reports success
/// per contact via [deliveries] instead of one blanket flag, which is
/// the whole point of the fix described in the project's defect list
/// ("blanket success message even when some alert channels had
/// failed"). Deliberately never cached to disk (see
/// [SosRepositoryImpl]) -- this is a live write, not something to
/// serve stale.
@freezed
class SosAlert with _$SosAlert {
  const SosAlert._();

  const factory SosAlert({
    required String id,
    @DateTimeConverter() required DateTime createdAt,
    required List<SosDelivery> deliveries,
  }) = _SosAlert;

  factory SosAlert.fromJson(Map<String, dynamic> json) =>
      _$SosAlertFromJson(json);

  int get sentCount => deliveries.where((d) => d.status == 'sent').length;
  int get failedCount => deliveries.where((d) => d.status == 'failed').length;
}

/// One contact's delivery outcome. `channel` is "device" or "server";
/// `status` is "sent", "simulated" (server SMS is log-only in dev --
/// nothing really went out), or "failed".
@freezed
class SosDelivery with _$SosDelivery {
  const factory SosDelivery({
    required String contactId,
    required String name,
    required String channel,
    required String status,
    String? error,
  }) = _SosDelivery;

  factory SosDelivery.fromJson(Map<String, dynamic> json) =>
      _$SosDeliveryFromJson(json);
}