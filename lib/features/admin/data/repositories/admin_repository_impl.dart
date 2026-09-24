import 'package:sheshield/core/cache/cache_box_interface.dart';
import '../../domain/entities/admin_report.dart';
import '../../domain/entities/admin_report_detail.dart';
import '../../domain/entities/admin_verification.dart';
import '../../domain/repositories/i_admin_repository.dart';
import '../datasources/admin_api_datasource.dart';

/// The queue is cached briefly (a reviewer bouncing between the queue and a
/// detail screen shouldn't refetch every time); every write -- review,
/// suspend, key change -- invalidates it immediately so it never looks stale
/// right after an action. Pull-to-refresh passes forceRefresh.
class AdminRepositoryImpl implements IAdminRepository {
  AdminRepositoryImpl(this._api, this._cache);
  final AdminApiDataSource _api;
  final CacheBox _cache;

  static const _cacheKey = 'admin:queue';
  static const _ttl = Duration(seconds: 20);

  @override
  Future<bool> hasAdminKey() => _api.hasKey();

  @override
  Future<void> setAdminKey(String key) async {
    await _api.saveKey(key);
    await _cache.invalidate(_cacheKey);
  }

  @override
  Future<void> clearAdminKey() async {
    await _api.clearKey();
    // Don't leave moderation data on the device after sign-out.
    await _cache.invalidate(_cacheKey);
  }

  @override
  Future<List<AdminReport>> getQueue({bool forceRefresh = false}) async {
    if (!forceRefresh) {
      final cached = await _cache.read(_cacheKey, ttl: _ttl);
      if (cached != null) {
        final items = (cached['items'] as List).cast<Map<String, dynamic>>();
        return items.map(AdminReport.fromJson).toList();
      }
    }
    final reports = await _api.fetchQueue();
    await _cache
        .write(_cacheKey, {'items': reports.map((r) => r.toJson()).toList()});
    return reports;
  }

  @override
  Future<AdminReportDetail> getDetail(String reportId) =>
      _api.fetchDetail(reportId);

  @override
  Future<void> review({
    required String reportId,
    required ReviewDecision decision,
    required String resolution,
    bool markFalseSos = false,
    String? reviewerName,
  }) async {
    await _api.review(
      reportId: reportId,
      decision: decision,
      resolution: resolution,
      markFalseSos: markFalseSos,
      reviewerName: reviewerName,
    );
    await _cache.invalidate(_cacheKey);
  }

  @override
  Future<List<AdminVerification>> getVerificationQueue(
          {bool forceRefresh = false}) =>
      _api.fetchVerificationQueue();

  @override
  Future<AdminVerification> getVerificationDetail(String verificationId) =>
      _api.fetchVerificationDetail(verificationId);

  @override
  Future<List<int>> getVerificationImage(
          {required String verificationId, required String kind}) =>
      _api.fetchVerificationImage(verificationId: verificationId, kind: kind);

  @override
  Future<void> decideVerification(
      {required String verificationId,
      required bool approved,
      String note = '',
      String? reviewerName}) async {
    await _api.decideVerification(
      verificationId: verificationId,
      approved: approved,
      note: note,
      reviewerName: reviewerName,
    );
  }

  @override
  Future<String?> suspendHelper({
    required String uid,
    required String reason,
    String? reviewerName,
  }) async {
    final released = await _api.suspendHelper(
        uid: uid, reason: reason, reviewerName: reviewerName);
    await _cache.invalidate(_cacheKey);
    return released;
  }
}
