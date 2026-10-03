import 'package:sheshield/features/report/domain/repositories/report_repository.dart';

class UnblockUserUseCase {
  const UnblockUserUseCase(this._reportRepository);

  final ReportRepository _reportRepository;

  Future<void> call(String userId) => _reportRepository.unblockUser(userId);
}
