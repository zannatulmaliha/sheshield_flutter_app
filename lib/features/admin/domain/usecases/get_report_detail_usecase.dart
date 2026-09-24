import '../entities/admin_report_detail.dart';
import '../repositories/i_admin_repository.dart';

class GetReportDetailUseCase {
  const GetReportDetailUseCase(this._repository);
  final IAdminRepository _repository;

  Future<AdminReportDetail> call(String reportId) =>
      _repository.getDetail(reportId);
}
