import '../repositories/i_report_repository.dart';

class UnblockUserUseCase {
  const UnblockUserUseCase(this._repository);
  final IReportRepository _repository;

  Future<void> call(String userId) => _repository.unblock(userId);
}
