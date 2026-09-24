import '../entities/blocked_user.dart';
import '../repositories/i_report_repository.dart';

class ListBlocksUseCase {
  const ListBlocksUseCase(this._repository);
  final IReportRepository _repository;

  Future<List<BlockedUser>> call() => _repository.listBlocks();
}
