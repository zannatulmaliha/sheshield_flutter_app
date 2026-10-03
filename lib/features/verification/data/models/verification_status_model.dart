import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sheshield/core/utils/json_converters.dart';
import 'package:sheshield/features/verification/domain/entities/verification_status.dart';

part 'verification_status_model.freezed.dart';
part 'verification_status_model.g.dart';

/// Wire shape of `GET/POST /api/v1/verification` -> `data`.
@freezed
class VerificationStatusModel with _$VerificationStatusModel {
  const VerificationStatusModel._();

  const factory VerificationStatusModel({
    @Default('none') String status,
    @Default('') String note,
    @NullableDateTimeConverter() DateTime? submittedAt,
  }) = _VerificationStatusModel;

  factory VerificationStatusModel.fromJson(Map<String, dynamic> json) =>
      _$VerificationStatusModelFromJson(json);

  VerificationStatus toEntity() => VerificationStatus(
        status: VerificationState.fromWireValue(status),
        note: note,
        submittedAt: submittedAt,
      );
}
