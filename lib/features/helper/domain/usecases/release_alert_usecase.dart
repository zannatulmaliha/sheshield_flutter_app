import 'package:sheshield/features/helper/domain/repositories/helper_alert_repository.dart';

class ReleaseAlertUseCase {
  const ReleaseAlertUseCase(this._helperAlertRepository);

  final HelperAlertRepository _helperAlertRepository;

  Future<void> call(String alertId) => _helperAlertRepository.releaseAlert(alertId);
}
