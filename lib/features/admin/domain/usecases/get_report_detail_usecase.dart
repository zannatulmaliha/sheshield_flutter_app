import 'package:sheshield/features/admin/domain/entities/admin_report_detail.dart';
import 'package:sheshield/features/admin/domain/repositories/admin_repository.dart';

class GetReportDetailUseCase {
  const GetReportDetailUseCase(this._adminRepository);

  final AdminRepository _adminRepository;

  Future<AdminReportDetail> call(String reportId) =>
      _adminRepository.fetchReportDetail(reportId);
}
