import '../repositories/i_report_repository.dart';

class BlockUserUseCase {
  const BlockUserUseCase(this._repository);
  final IReportRepository _repository;

  Future<void> call(String userId) => _repository.block(userId);
}
