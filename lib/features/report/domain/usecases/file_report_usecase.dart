import 'package:sheshield/features/report/domain/entities/report_category.dart';
import 'package:sheshield/features/report/domain/repositories/report_repository.dart';

class FileReportUseCase {
  const FileReportUseCase(this._reportRepository);

  final ReportRepository _reportRepository;

  Future<void> call({
    required String reportedId,
    required ReportCategory category,
    required String reporterRole,
    String? sosId,
  }) =>
      _reportRepository.fileReport(
        reportedId: reportedId,
        category: category,
        reporterRole: reporterRole,
        sosId: sosId,
      );
}
