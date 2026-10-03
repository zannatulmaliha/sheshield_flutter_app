import 'package:sheshield/features/admin/domain/entities/admin_report.dart';
import 'package:sheshield/features/admin/domain/repositories/admin_repository.dart';

class GetReportQueueUseCase {
  const GetReportQueueUseCase(this._adminRepository);

  final AdminRepository _adminRepository;

  Future<List<AdminReport>> call({bool forceRefresh = false}) =>
      _adminRepository.fetchReportQueue(forceRefresh: forceRefresh);
}
