import 'package:sheshield/features/report/domain/repositories/report_repository.dart';

class BlockUserUseCase {
  const BlockUserUseCase(this._reportRepository);

  final ReportRepository _reportRepository;

  Future<void> call(String userId) => _reportRepository.blockUser(userId);
}
