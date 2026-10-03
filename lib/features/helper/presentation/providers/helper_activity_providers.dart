import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sheshield/core/error/app_failure.dart';
import 'package:sheshield/features/helper/domain/entities/helper_history_item.dart';
import 'package:sheshield/features/helper/domain/entities/helper_stats.dart';
import 'package:sheshield/features/helper/domain/entities/my_response.dart';
import 'package:sheshield/features/helper/presentation/providers/helper_use_case_providers.dart';

part 'helper_activity_providers.g.dart';

/// Real dashboard numbers (responses / success / avg time). A failed read
/// shows zeros rather than an error card on the dashboard.
@riverpod
Future<HelperStats> helperStats(HelperStatsRef ref) async {
  final getHelperStats = ref.read(getHelperStatsUseCaseProvider);
  try {
    return await getHelperStats();
  } on AppFailure {
    return const HelperStats();
  }
}

/// Past responses for the History tab.
@riverpod
Future<List<HelperHistoryItem>> helperHistory(HelperHistoryRef ref) {
  final getHelperHistory = ref.read(getHelperHistoryUseCaseProvider);
  return getHelperHistory();
}

/// The alert this helper currently holds, if any ("My Response" tab).
/// Invalidate after accepting / backing out / resolving.
@riverpod
Future<MyResponse?> myResponse(MyResponseRef ref) {
  final getCurrentResponse = ref.read(getCurrentResponseUseCaseProvider);
  return getCurrentResponse();
}
