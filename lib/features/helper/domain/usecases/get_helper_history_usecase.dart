import 'package:sheshield/features/helper/domain/entities/helper_history_item.dart';
import 'package:sheshield/features/helper/domain/repositories/helper_activity_repository.dart';

class GetHelperHistoryUseCase {
  const GetHelperHistoryUseCase(this._helperActivityRepository);

  final HelperActivityRepository _helperActivityRepository;

  Future<List<HelperHistoryItem>> call() => _helperActivityRepository.fetchHistory();
}
