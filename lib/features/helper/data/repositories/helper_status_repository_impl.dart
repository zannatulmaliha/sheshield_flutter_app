import 'package:sheshield/core/cache/cache_box_interface.dart';
import 'package:sheshield/features/helper/data/datasources/helper_status_api_datasource.dart';
import 'package:sheshield/features/helper/data/models/helper_status_model.dart';
import 'package:sheshield/features/helper/domain/entities/helper_status.dart';
import 'package:sheshield/features/helper/domain/repositories/helper_status_repository.dart';

/// A helper's active/inactive + radius rarely changes between app opens, so
/// reading it is cached briefly. Alerts are deliberately NOT cached (see
/// `HelperAlertRepositoryImpl`): someone may be waiting.
class HelperStatusRepositoryImpl implements HelperStatusRepository {
  const HelperStatusRepositoryImpl(this._apiDataSource, this._cache);

  static const _cacheKey = 'helper:status';
  static const _cacheTtl = Duration(minutes: 5);

  final HelperStatusApiDataSource _apiDataSource;
  final CacheBox _cache;

  @override
  Future<HelperStatus> fetchStatus() async {
    final cached = await _cache.read(_cacheKey, ttl: _cacheTtl);
    if (cached != null) return HelperStatusModel.fromJson(cached).toEntity();

    final model = await _apiDataSource.fetchStatus();
    await _cache.write(_cacheKey, model.toJson());
    return model.toEntity();
  }

  @override
  Future<HelperStatus> setStatus({
    required bool isActive,
    required double radiusKm,
    double? latitude,
    double? longitude,
    bool mutualConnectionOptIn = false,
  }) async {
    final model = await _apiDataSource.setStatus(
      isActive: isActive,
      radiusKm: radiusKm,
      mutualConnectionOptIn: mutualConnectionOptIn,
      latitude: latitude,
      longitude: longitude,
    );
    // The server now holds a different value than the cache; refresh it
    // now rather than waiting out the TTL, so a hot restart never briefly
    // shows the pre-toggle state.
    await _cache.write(_cacheKey, model.toJson());
    return model.toEntity();
  }
}
