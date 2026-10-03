import 'package:sheshield/features/helper/domain/repositories/helper_alert_repository.dart';

class ResolveAlertUseCase {
  const ResolveAlertUseCase(this._helperAlertRepository);

  final HelperAlertRepository _helperAlertRepository;

  Future<void> call(String alertId) => _helperAlertRepository.resolveAlert(alertId);
}
