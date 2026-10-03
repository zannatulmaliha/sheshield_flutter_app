import 'package:sheshield/features/helper/domain/entities/helper_stats.dart';
import 'package:sheshield/features/helper/domain/repositories/helper_activity_repository.dart';

class GetHelperStatsUseCase {
  const GetHelperStatsUseCase(this._helperActivityRepository);

  final HelperActivityRepository _helperActivityRepository;

  Future<HelperStats> call() => _helperActivityRepository.fetchStats();
}
