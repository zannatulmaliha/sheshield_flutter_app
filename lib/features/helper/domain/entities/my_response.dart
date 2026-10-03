import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sheshield/features/helper/domain/entities/accepted_alert.dart';
import 'package:sheshield/features/helper/domain/entities/response_stage.dart';
import 'package:sheshield/features/helper/domain/entities/risk_level.dart';

part 'my_response.freezed.dart';

/// The helper's in-progress response (`GET /helper/responses/current`).
@freezed
class MyResponse with _$MyResponse {
  const factory MyResponse({
    required AcceptedAlert alert,
    required ResponseStage stage,
    required String label,
    required RiskLevel riskLevel,
    required bool duressActive,
  }) = _MyResponse;
}
