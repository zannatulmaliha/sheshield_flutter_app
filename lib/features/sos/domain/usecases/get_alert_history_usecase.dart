import '../entities/alert_summary.dart';
import '../repositories/i_sos_repository.dart';

class GetAlertHistoryUseCase {
  const GetAlertHistoryUseCase(this._repository);
  final ISosRepository _repository;

  Future<List<AlertSummary>> call() => _repository.fetchHistory();
}
