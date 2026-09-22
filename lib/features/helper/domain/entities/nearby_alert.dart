import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sheshield/core/utils/json_converters.dart';

part 'nearby_alert.freezed.dart';
part 'nearby_alert.g.dart';

/// A nearby SOS alert as seen by a helper before responding. Only a
/// rough area and distance are exposed here -- the exact address and
/// the person's phone number are revealed only after AcceptAlertUseCase
/// succeeds (see [AcceptedAlert]). The server enforces this; this
/// entity structurally cannot carry precise coordinates, so there is
/// nothing sensitive to leak even if this screen were shown to the
/// wrong person.
@freezed
class NearbyAlert with _$NearbyAlert {
  const NearbyAlert._();

  const factory NearbyAlert({
    required String id,
    @Default('Nearby') String roughArea,
    required double distanceMeters,
    @DateTimeConverter() required DateTime createdAt,
  }) = _NearbyAlert;

  factory NearbyAlert.fromJson(Map<String, dynamic> json) =>
      _$NearbyAlertFromJson(json);

  String get distanceLabel => distanceMeters < 1000
      ? '${distanceMeters.round()} m away'
      : '${(distanceMeters / 1000).toStringAsFixed(1)} km away';
}
