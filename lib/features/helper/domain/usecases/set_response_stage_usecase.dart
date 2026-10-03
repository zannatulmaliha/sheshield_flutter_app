import 'package:sheshield/features/helper/domain/entities/response_stage.dart';
import 'package:sheshield/features/helper/domain/repositories/helper_alert_repository.dart';

class SetResponseStageUseCase {
  const SetResponseStageUseCase(this._helperAlertRepository);

  final HelperAlertRepository _helperAlertRepository;

  Future<void> call(String alertId, ResponseStage stage) =>
      _helperAlertRepository.setResponseStage(alertId, stage);
}
