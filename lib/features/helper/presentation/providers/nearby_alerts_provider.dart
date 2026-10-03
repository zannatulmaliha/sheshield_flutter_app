import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sheshield/features/helper/domain/entities/accepted_alert.dart';
import 'package:sheshield/features/helper/domain/entities/nearby_alert.dart';
import 'package:sheshield/features/helper/domain/usecases/accept_alert_usecase.dart';
import 'package:sheshield/features/helper/domain/usecases/get_nearby_alerts_usecase.dart';
import 'package:sheshield/features/helper/presentation/providers/helper_status_provider.dart';
import 'package:sheshield/features/helper/presentation/providers/helper_use_case_providers.dart';

part 'nearby_alerts_provider.g.dart';

/// The nearby-alerts list. Watching `helperStatusControllerProvider.future`
/// inside [build] re-fetches whenever active status flips on and returns an
/// empty list the moment it flips off, with no manual wiring.
@riverpod
class NearbyAlertsController extends _$NearbyAlertsController {
  late final GetNearbyAlertsUseCase _getNearbyAlerts =
      ref.read(getNearbyAlertsUseCaseProvider);
  late final AcceptAlertUseCase _acceptAlert = ref.read(acceptAlertUseCaseProvider);

  @override
  Future<List<NearbyAlert>> build() async {
    final status = await ref.watch(helperStatusControllerProvider.future);
    if (!status.isActive) return const [];
    await ref.read(helperStatusControllerProvider.notifier).refreshLocation();
    return _getNearbyAlerts();
  }

  /// Pull-to-refresh and the screens' periodic poll. A no-op while
  /// inactive, so a stray timer tick can't re-enable fetching.
  Future<void> refresh() async {
    final status = ref.read(helperStatusControllerProvider).valueOrNull;
    if (status == null || !status.isActive) return;
    state = const AsyncLoading<List<NearbyAlert>>().copyWithPrevious(state);
    // Keep the server-side helper location fresh before every poll.
    await ref.read(helperStatusControllerProvider.notifier).refreshLocation();
    state = await AsyncValue.guard(_getNearbyAlerts.call);
  }

  /// Returns the accepted alert, or null if someone else won the race.
  /// Either way the alert leaves the local list: it is no longer available
  /// to accept regardless of who won. Throws `AppFailure` on other errors.
  Future<AcceptedAlert?> accept(String alertId) async {
    final acceptedAlert = await _acceptAlert(alertId);
    final currentAlerts = state.valueOrNull ?? const <NearbyAlert>[];
    state = AsyncData(
      currentAlerts.where((alert) => alert.id != alertId).toList(),
    );
    return acceptedAlert;
  }
}
