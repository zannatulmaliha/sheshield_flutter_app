import 'package:sheshield/features/sos/domain/entities/alert_summary.dart';
import 'package:sheshield/features/sos/domain/repositories/sos_repository.dart';

class GetAlertHistoryUseCase {
  const GetAlertHistoryUseCase(this._sosRepository);

  final SosRepository _sosRepository;

  Future<List<AlertSummary>> call() => _sosRepository.fetchAlertHistory();
}
