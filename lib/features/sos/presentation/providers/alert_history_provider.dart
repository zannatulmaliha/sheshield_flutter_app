import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sheshield/core/di/injection.dart';
import 'package:sheshield/features/sos/domain/entities/alert_summary.dart';
import 'package:sheshield/features/sos/domain/usecases/get_alert_history_usecase.dart';

part 'alert_history_provider.g.dart';

/// The signed-in user's own SOS history, for the notification-history
/// screen reached from the home bell icon.
@riverpod
class AlertHistoryController extends _$AlertHistoryController {
  @override
  Future<List<AlertSummary>> build() => getIt<GetAlertHistoryUseCase>().call();

  /// Used by pull-to-refresh.
  Future<void> refresh() async {
    state = const AsyncLoading<List<AlertSummary>>().copyWithPrevious(state);
    state = await AsyncValue.guard(() => getIt<GetAlertHistoryUseCase>().call());
  }
}
