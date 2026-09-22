import '../repositories/i_sos_repository.dart';

class ResolveSosAlertUseCase {
  const ResolveSosAlertUseCase(this._repository);
  final ISosRepository _repository;

  Future<void> call(String alertId) => _repository.resolve(alertId);
}
