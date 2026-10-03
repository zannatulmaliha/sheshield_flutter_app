import 'package:sheshield/features/helper/domain/entities/nearby_alert.dart';
import 'package:sheshield/features/helper/domain/repositories/helper_alert_repository.dart';

class GetNearbyAlertsUseCase {
  const GetNearbyAlertsUseCase(this._helperAlertRepository);

  final HelperAlertRepository _helperAlertRepository;

  Future<List<NearbyAlert>> call() => _helperAlertRepository.fetchNearbyAlerts();
}
