import 'package:sheshield/core/cache/cache_box_interface.dart';
import '../../domain/entities/accepted_alert.dart';
import '../../domain/entities/helper_status.dart';
import '../../domain/entities/nearby_alert.dart';
import '../../domain/repositories/i_helper_repository.dart';
import '../datasources/helper_api_datasource.dart';

/// Thin adapter satisfying [IHelperRepository] by delegating to the
/// REST data source -- if the transport ever changes, this is the only
/// class that needs a new implementation.
///
/// [fetchStatus] is the cache's first real consumer: a helper's
/// active/inactive + radius rarely changes between app opens, so
/// there's no reason to round-trip the API every time the dashboard
/// mounts. `nearbyAlerts` is deliberately NOT cached -- alerts are
/// time-critical (someone may be waiting), so a stale disk read there
/// would be actively harmful rather than just an optimization.
class HelperRepositoryImpl implements IHelperRepository {
  HelperRepositoryImpl(this._dataSource, this._cache);
  final HelperApiDataSource _dataSource;
  final CacheBox _cache;

  static const _statusCacheKey = 'helper:status';
  static const _statusTtl = Duration(minutes: 5);

  @override
  Future<HelperStatus> fetchStatus() async {
    final cached = await _cache.read(_statusCacheKey, ttl: _statusTtl);
    if (cached != null) return HelperStatus.fromJson(cached);

    final status = await _dataSource.fetchStatus();
    await _cache.write(_statusCacheKey, status.toJson());
    return status;
  }

  @override
  Future<HelperStatus> setStatus({
    required bool isActive,
    required double radiusKm,
    double? latitude,
    double? longitude,
  }) async {
    final status = await _dataSource.setStatus(
      isActive: isActive,
      radiusKm: radiusKm,
      latitude: latitude,
      longitude: longitude,
    );
    // The server is now the source of truth for a different value than
    // whatever was cached -- refresh it immediately rather than waiting
    // out the TTL, so the next fetchStatus() (e.g. after a hot restart)
    // doesn't briefly show the pre-toggle state.
    await _cache.write(_statusCacheKey, status.toJson());
    return status;
  }

  @override
  Future<List<NearbyAlert>> fetchNearbyAlerts() => _dataSource.fetchNearbyAlerts();

  @override
  Future<AcceptedAlert?> accept(String alertId) => _dataSource.accept(alertId);
}
