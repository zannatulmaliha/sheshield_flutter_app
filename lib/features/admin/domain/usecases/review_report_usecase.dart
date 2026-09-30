import '../repositories/i_admin_repository.dart';

class ReviewReportUseCase {
  const ReviewReportUseCase(this._repository);
  final IAdminRepository _repository;

  Future<void> call({
    required String reportId,
    required ReviewDecision decision,
    required String resolution,
    bool markFalseSos = false,
    String? reviewerName,
  }) =>
      _repository.review(
        reportId: reportId,
        decision: decision,
        resolution: resolution,
        markFalseSos: markFalseSos,
        reviewerName: reviewerName,
      );
}
