import 'package:latlong2/latlong.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sheshield/core/di/service_providers.dart';
import 'package:sheshield/core/error/app_failure.dart';
import 'package:sheshield/core/services/device_location_service.dart';
import 'package:sheshield/features/sos/domain/entities/danger_zone.dart';
import 'package:sheshield/features/sos/domain/usecases/get_danger_zones_usecase.dart';
import 'package:sheshield/features/sos/presentation/providers/sos_use_case_providers.dart';

part 'danger_zone_provider.g.dart';

typedef DangerZoneData = (LatLng center, List<DangerZone> zones);

/// The Danger Zone heat map around the signed-in person's current
/// position, for the home screen's "Danger Zone" quick action.
@riverpod
class DangerZoneController extends _$DangerZoneController {
  late final GetDangerZonesUseCase _getDangerZones =
      ref.read(getDangerZonesUseCaseProvider);
  late final DeviceLocationService _locationService =
      ref.read(deviceLocationServiceProvider);

  @override
  Future<DangerZoneData> build() => _load();

  /// Used by pull-to-refresh.
  Future<void> refresh() async {
    state = const AsyncLoading<DangerZoneData>().copyWithPrevious(state);
    state = await AsyncValue.guard(_load);
  }

  Future<DangerZoneData> _load() async {
    final position = await _locationService.getCurrentPosition();
    if (position == null) {
      throw const AppFailure(
        message: 'Location permission is needed to show danger zones nearby.',
      );
    }
    final center = LatLng(position.latitude, position.longitude);
    final zones = await _getDangerZones(
      latitude: position.latitude,
      longitude: position.longitude,
    );
    return (center, zones);
  }
}
