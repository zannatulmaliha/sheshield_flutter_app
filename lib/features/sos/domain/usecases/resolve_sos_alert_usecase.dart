import 'package:sheshield/features/sos/domain/repositories/sos_repository.dart';

class ResolveSosAlertUseCase {
  const ResolveSosAlertUseCase(this._sosRepository);

  final SosRepository _sosRepository;

  Future<void> call(String alertId) => _sosRepository.resolveAlert(alertId);
}
