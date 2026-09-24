import '../entities/safety_status.dart';
import '../repositories/i_helper_repository.dart';

class GetSafetyStatusUseCase {
  const GetSafetyStatusUseCase(this._repository);
  final IHelperRepository _repository;

  Future<SafetyStatus> call(String alertId) => _repository.fetchSafetyStatus(alertId);
}
