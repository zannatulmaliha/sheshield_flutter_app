import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sheshield/core/utils/json_converters.dart';

part 'accepted_alert.freezed.dart';
part 'accepted_alert.g.dart';

/// The full alert detail, returned only to the one helper who won the
/// accept race. This is the only entity in the helper feature that
/// ever carries an exact location or phone number.
@freezed
class AcceptedAlert with _$AcceptedAlert {
  const AcceptedAlert._();

  const factory AcceptedAlert({
    required String id,
    required String userName,
    required String phone,
    @Default('') String countryCode,
    required double latitude,
    required double longitude,
    @DateTimeConverter() required DateTime acceptedAt,
  }) = _AcceptedAlert;

  factory AcceptedAlert.fromJson(Map<String, dynamic> json) =>
      _$AcceptedAlertFromJson(json);

  String get fullPhone => countryCode.isEmpty ? phone : '$countryCode $phone';
}
