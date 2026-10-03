import 'package:sheshield/features/helper/domain/entities/safety_status.dart';
import 'package:sheshield/features/helper/domain/repositories/helper_alert_repository.dart';

class GetSafetyStatusUseCase {
  const GetSafetyStatusUseCase(this._helperAlertRepository);

  final HelperAlertRepository _helperAlertRepository;

  Future<SafetyStatus> call(String alertId) =>
      _helperAlertRepository.fetchSafetyStatus(alertId);
}
