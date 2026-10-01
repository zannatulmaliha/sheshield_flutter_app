import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sheshield/core/di/injection.dart';
import 'package:sheshield/features/helper/domain/entities/helper_models.dart';
import 'package:sheshield/features/helper/domain/repositories/i_helper_repository.dart';

/// Real dashboard numbers (responses / success / avg time).
final helperStatsProvider = FutureProvider.autoDispose<HelperStats>((ref) async {
  try {
    return await getIt<IHelperRepository>().fetchStats();
  } on HelperFailure {
    return const HelperStats();
  }
});

/// Past responses for the History tab.
final helperHistoryProvider = FutureProvider.autoDispose<List<HelperHistoryItem>>(
  (ref) => getIt<IHelperRepository>().fetchHistory(),
);

/// The alert this helper currently holds, if any ("My Response" tab).
/// Invalidate after accepting / backing out / resolving.
final myResponseProvider = FutureProvider.autoDispose<MyResponse?>(
  (ref) => getIt<IHelperRepository>().fetchCurrentResponse(),
);
