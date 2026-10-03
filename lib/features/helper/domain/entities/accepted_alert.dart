import 'package:freezed_annotation/freezed_annotation.dart';

part 'accepted_alert.freezed.dart';

/// The full alert detail, returned only to the one helper who won the
/// accept race. This is the only entity in the helper feature that ever
/// carries an exact location or phone number.
@freezed
class AcceptedAlert with _$AcceptedAlert {
  const AcceptedAlert._();

  const factory AcceptedAlert({
    required String id,
    required String userName,
    required String phone,
    required double latitude,
    required double longitude,
    required DateTime acceptedAt,
    @Default('') String countryCode,
    @Default('') String requesterUid,
  }) = _AcceptedAlert;

  String get fullPhone => countryCode.isEmpty ? phone : '$countryCode $phone';
}
