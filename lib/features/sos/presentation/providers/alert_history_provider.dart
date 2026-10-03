import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sheshield/features/sos/domain/entities/alert_summary.dart';
import 'package:sheshield/features/sos/domain/usecases/get_alert_history_usecase.dart';
import 'package:sheshield/features/sos/presentation/providers/sos_use_case_providers.dart';

part 'alert_history_provider.g.dart';

/// The signed-in user's own SOS history, for the notification-history
/// screen reached from the home bell icon.
@riverpod
class AlertHistoryController extends _$AlertHistoryController {
  late final GetAlertHistoryUseCase _getAlertHistory =
      ref.read(getAlertHistoryUseCaseProvider);

  @override
  Future<List<AlertSummary>> build() => _getAlertHistory();

  /// Used by pull-to-refresh.
  Future<void> refresh() async {
    state = const AsyncLoading<List<AlertSummary>>().copyWithPrevious(state);
    state = await AsyncValue.guard(_getAlertHistory.call);
  }
}
