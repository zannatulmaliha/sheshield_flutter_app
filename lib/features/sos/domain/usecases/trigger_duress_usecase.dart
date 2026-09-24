import '../entities/duress_type.dart';
import '../repositories/i_sos_repository.dart';

class TriggerDuressUseCase {
  const TriggerDuressUseCase(this._repository);
  final ISosRepository _repository;

  Future<void> call(String alertId, DuressType type) =>
      _repository.triggerDuress(alertId, type.key);
}
