import 'package:sheshield/features/helper/data/datasources/helper_activity_api_datasource.dart';
import 'package:sheshield/features/helper/domain/entities/helper_history_item.dart';
import 'package:sheshield/features/helper/domain/entities/helper_stats.dart';
import 'package:sheshield/features/helper/domain/repositories/helper_activity_repository.dart';

class HelperActivityRepositoryImpl implements HelperActivityRepository {
  const HelperActivityRepositoryImpl(this._apiDataSource);

  final HelperActivityApiDataSource _apiDataSource;

  @override
  Future<HelperStats> fetchStats() async =>
      (await _apiDataSource.fetchStats()).toEntity();

  @override
  Future<List<HelperHistoryItem>> fetchHistory() async {
    final models = await _apiDataSource.fetchHistory();
    return models.map((model) => model.toEntity()).toList();
  }
}
