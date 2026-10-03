import 'package:sheshield/features/report/domain/entities/blocked_user.dart';
import 'package:sheshield/features/report/domain/repositories/report_repository.dart';

class ListBlockedUsersUseCase {
  const ListBlockedUsersUseCase(this._reportRepository);

  final ReportRepository _reportRepository;

  Future<List<BlockedUser>> call() => _reportRepository.fetchBlockedUsers();
}
