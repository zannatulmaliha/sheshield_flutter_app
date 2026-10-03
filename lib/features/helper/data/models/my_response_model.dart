import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sheshield/core/utils/json_converters.dart';
import 'package:sheshield/features/helper/domain/entities/accepted_alert.dart';
import 'package:sheshield/features/helper/domain/entities/my_response.dart';
import 'package:sheshield/features/helper/domain/entities/response_stage.dart';
import 'package:sheshield/features/helper/domain/entities/risk_level.dart';

part 'my_response_model.freezed.dart';
part 'my_response_model.g.dart';

/// Wire shape of `GET /helper/responses/current`: the accepted-alert
/// fields and the response progress arrive flattened in one object.
@freezed
class MyResponseModel with _$MyResponseModel {
  const MyResponseModel._();

  const factory MyResponseModel({
    required String id,
    required String userName,
    required String phone,
    required double latitude,
    required double longitude,
    @DateTimeConverter() required DateTime acceptedAt,
    @Default('') String countryCode,
    @Default('') String requesterUid,
    @Default('') String progress,
    @Default('SOS') String label,
    @Default('high') String riskLevel,
    @Default(false) bool duressActive,
  }) = _MyResponseModel;

  factory MyResponseModel.fromJson(Map<String, dynamic> json) =>
      _$MyResponseModelFromJson(json);

  MyResponse toEntity() => MyResponse(
        alert: AcceptedAlert(
          id: id,
          userName: userName,
          phone: phone,
          latitude: latitude,
          longitude: longitude,
          acceptedAt: acceptedAt,
          countryCode: countryCode,
          requesterUid: requesterUid,
        ),
        stage: ResponseStage.fromWireValue(progress),
        label: label,
        riskLevel: RiskLevel.fromWireValue(riskLevel),
        duressActive: duressActive,
      );
}
