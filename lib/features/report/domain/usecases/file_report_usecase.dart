import '../entities/report_category.dart';
import '../repositories/i_report_repository.dart';

class FileReportUseCase {
  const FileReportUseCase(this._repository);
  final IReportRepository _repository;

  Future<void> call({
    required String reportedId,
    required ReportCategory category,
    required String reporterRole,
    String? sosId,
  }) =>
      _repository.file(
        reportedId: reportedId,
        category: category,
        reporterRole: reporterRole,
        sosId: sosId,
      );
}
