import '../entities/admin_report.dart';
import '../repositories/i_admin_repository.dart';

class GetReportQueueUseCase {
  const GetReportQueueUseCase(this._repository);
  final IAdminRepository _repository;

  Future<List<AdminReport>> call({bool forceRefresh = false}) =>
      _repository.getQueue(forceRefresh: forceRefresh);
}
