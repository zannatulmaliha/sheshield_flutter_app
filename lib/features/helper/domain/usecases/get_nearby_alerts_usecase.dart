import '../entities/nearby_alert.dart';
import '../repositories/i_helper_repository.dart';

class GetNearbyAlertsUseCase {
  const GetNearbyAlertsUseCase(this._repository);
  final IHelperRepository _repository;

  Future<List<NearbyAlert>> call() => _repository.fetchNearbyAlerts();
}
