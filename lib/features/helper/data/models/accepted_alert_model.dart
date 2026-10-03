import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sheshield/core/utils/json_converters.dart';
import 'package:sheshield/features/helper/domain/entities/accepted_alert.dart';

part 'accepted_alert_model.freezed.dart';
part 'accepted_alert_model.g.dart';

/// Wire shape of the full alert returned by `POST /helper/alerts/{id}/accept`.
@freezed
class AcceptedAlertModel with _$AcceptedAlertModel {
  const AcceptedAlertModel._();

  const factory AcceptedAlertModel({
    required String id,
    required String userName,
    required String phone,
    required double latitude,
    required double longitude,
    @DateTimeConverter() required DateTime acceptedAt,
    @Default('') String countryCode,
    @Default('') String requesterUid,
  }) = _AcceptedAlertModel;

  factory AcceptedAlertModel.fromJson(Map<String, dynamic> json) =>
      _$AcceptedAlertModelFromJson(json);

  AcceptedAlert toEntity() => AcceptedAlert(
        id: id,
        userName: userName,
        phone: phone,
        latitude: latitude,
        longitude: longitude,
        acceptedAt: acceptedAt,
        countryCode: countryCode,
        requesterUid: requesterUid,
      );
}
