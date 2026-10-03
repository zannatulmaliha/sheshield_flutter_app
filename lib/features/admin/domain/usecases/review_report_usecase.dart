import 'package:sheshield/features/admin/domain/entities/review_decision.dart';
import 'package:sheshield/features/admin/domain/repositories/admin_repository.dart';

class ReviewReportUseCase {
  const ReviewReportUseCase(this._adminRepository);

  final AdminRepository _adminRepository;

  Future<void> call({
    required String reportId,
    required ReviewDecision decision,
    required String resolution,
    bool markFalseSos = false,
    String? reviewerName,
  }) =>
      _adminRepository.reviewReport(
        reportId: reportId,
        decision: decision,
        resolution: resolution,
        markFalseSos: markFalseSos,
        reviewerName: reviewerName,
      );
}
