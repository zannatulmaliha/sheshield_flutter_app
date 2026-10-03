import 'package:sheshield/features/sos/domain/entities/duress_type.dart';
import 'package:sheshield/features/sos/domain/repositories/sos_repository.dart';

class TriggerDuressUseCase {
  const TriggerDuressUseCase(this._sosRepository);

  final SosRepository _sosRepository;

  Future<void> call(String alertId, DuressType type) =>
      _sosRepository.triggerDuress(alertId, type);
}
