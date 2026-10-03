import 'package:sheshield/features/helper/domain/entities/helper_history_item.dart';
import 'package:sheshield/features/helper/domain/entities/helper_stats.dart';

/// The helper's track record. Never cached: it changes the moment a
/// response ends, and a stale read would show the wrong thing.
abstract interface class HelperActivityRepository {
  Future<HelperStats> fetchStats();

  Future<List<HelperHistoryItem>> fetchHistory();
}
