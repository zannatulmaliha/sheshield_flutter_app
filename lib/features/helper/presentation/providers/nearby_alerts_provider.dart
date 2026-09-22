import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sheshield/core/di/injection.dart';
import 'package:sheshield/features/helper/domain/entities/accepted_alert.dart';
import 'package:sheshield/features/helper/domain/entities/nearby_alert.dart';
import 'package:sheshield/features/helper/domain/usecases/accept_alert_usecase.dart';
import 'package:sheshield/features/helper/domain/usecases/get_nearby_alerts_usecase.dart';
import 'helper_status_provider.dart';

part 'nearby_alerts_provider.g.dart';

/// The nearby-alerts list. Declaring `ref.watch(helperStatusControllerProvider.future)`
/// inside [build] means this provider automatically re-fetches whenever
/// active status flips on, and returns an empty list the moment it
/// flips off -- no manual wiring between the two controllers.
@riverpod
class NearbyAlertsController extends _$NearbyAlertsController {
  @override
  Future<List<NearbyAlert>> build() async {
    final status = await ref.watch(helperStatusControllerProvider.future);
    if (!status.isActive) return [];
    return getIt<GetNearbyAlertsUseCase>().call();
  }

  /// Used by pull-to-refresh and the screen's periodic poll while
  /// active. A no-op while inactive, so a stray timer tick can't
  /// accidentally re-enable fetching.
  Future<void> refresh() async {
    final status = ref.read(helperStatusControllerProvider).valueOrNull;
    if (status == null || !status.isActive) return;
    state = const AsyncLoading<List<NearbyAlert>>().copyWithPrevious(state);
    state = await AsyncValue.guard(() => getIt<GetNearbyAlertsUseCase>().call());
  }

  /// Returns the accepted alert, or null if someone else won the race
  /// first. Either way the alert is removed locally, since it is no
  /// longer available to accept regardless of who won.
  Future<AcceptedAlert?> accept(String alertId) async {
    final accepted = await getIt<AcceptAlertUseCase>().call(alertId);
    final current = state.valueOrNull ?? const <NearbyAlert>[];
    state = AsyncData(current.where((a) => a.id != alertId).toList());
    return accepted;
  }
}
