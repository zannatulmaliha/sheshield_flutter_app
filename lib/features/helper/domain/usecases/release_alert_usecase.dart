import '../repositories/i_helper_repository.dart';

class ReleaseAlertUseCase {
  const ReleaseAlertUseCase(this._repository);
  final IHelperRepository _repository;

  Future<void> call(String alertId) => _repository.release(alertId);
}
