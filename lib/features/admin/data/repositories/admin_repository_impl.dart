import 'dart:typed_data';

import 'package:sheshield/core/cache/cache_box_interface.dart';
import 'package:sheshield/features/admin/data/datasources/admin_key_store.dart';
import 'package:sheshield/features/admin/data/datasources/admin_report_api_datasource.dart';
import 'package:sheshield/features/admin/data/datasources/admin_verification_api_datasource.dart';
import 'package:sheshield/features/admin/data/models/admin_report_model.dart';
import 'package:sheshield/features/admin/domain/entities/admin_report.dart';
import 'package:sheshield/features/admin/domain/entities/admin_report_detail.dart';
import 'package:sheshield/features/admin/domain/entities/admin_verification.dart';
import 'package:sheshield/features/admin/domain/entities/review_decision.dart';
import 'package:sheshield/features/admin/domain/entities/verification_image_kind.dart';
import 'package:sheshield/features/admin/domain/repositories/admin_repository.dart';

/// The report queue is cached briefly so bouncing between the queue and a
/// detail screen doesn't refetch every time. Every write -- review,
/// suspension, key change -- invalidates it, so it never looks stale right
/// after an action. Pull-to-refresh passes `forceRefresh`.
class AdminRepositoryImpl implements AdminRepository {
  const AdminRepositoryImpl({
    required AdminKeyStore keyStore,
    required AdminReportApiDataSource reportDataSource,
    required AdminVerificationApiDataSource verificationDataSource,
    required CacheBox cache,
  })  : _keyStore = keyStore,
        _reportDataSource = reportDataSource,
        _verificationDataSource = verificationDataSource,
        _cache = cache;

  static const _queueCacheKey = 'admin:queue';
  static const _queueCacheTtl = Duration(seconds: 20);

  final AdminKeyStore _keyStore;
  final AdminReportApiDataSource _reportDataSource;
  final AdminVerificationApiDataSource _verificationDataSource;
  final CacheBox _cache;

  @override
  Future<bool> hasAdminKey() => _keyStore.hasKey();

  @override
  Future<void> saveAdminKey(String key) async {
    await _keyStore.saveAdminKey(key);
    await _cache.invalidate(_queueCacheKey);
  }

  @override
  Future<void> clearAdminKey() async {
    await _keyStore.clearAdminKey();
    // Don't leave moderation data on the device after sign-out.
    await _cache.invalidate(_queueCacheKey);
  }

  @override
  Future<List<AdminReport>> fetchReportQueue({bool forceRefresh = false}) async {
    if (!forceRefresh) {
      final cachedModels = await _readCachedQueue();
      if (cachedModels != null) return _toEntities(cachedModels);
    }
    final models = await _reportDataSource.fetchReportQueue();
    await _cache.write(_queueCacheKey, {
      'items': models.map((model) => model.toJson()).toList(),
    });
    return _toEntities(models);
  }

  @override
  Future<AdminReportDetail> fetchReportDetail(String reportId) async =>
      (await _reportDataSource.fetchReportDetail(reportId)).toEntity();

  @override
  Future<void> reviewReport({
    required String reportId,
    required ReviewDecision decision,
    required String resolution,
    bool markFalseSos = false,
    String? reviewerName,
  }) async {
    await _reportDataSource.reviewReport(
      reportId: reportId,
      decision: decision,
      resolution: resolution,
      markFalseSos: markFalseSos,
      reviewerName: reviewerName,
    );
    await _cache.invalidate(_queueCacheKey);
  }

  @override
  Future<String?> suspendHelper({
    required String uid,
    required String reason,
    String? reviewerName,
  }) async {
    final releasedSosId = await _reportDataSource.suspendHelper(
      uid: uid,
      reason: reason,
      reviewerName: reviewerName,
    );
    await _cache.invalidate(_queueCacheKey);
    return releasedSosId;
  }

  @override
  Future<List<AdminVerification>> fetchVerificationQueue() async {
    final models = await _verificationDataSource.fetchVerificationQueue();
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<AdminVerification> fetchVerificationDetail(String verificationId) async =>
      (await _verificationDataSource.fetchVerificationDetail(verificationId))
          .toEntity();

  @override
  Future<Uint8List> fetchVerificationImage({
    required String verificationId,
    required VerificationImageKind kind,
  }) =>
      _verificationDataSource.fetchVerificationImage(
        verificationId: verificationId,
        kind: kind,
      );

  @override
  Future<void> decideVerification({
    required String verificationId,
    required bool approved,
    String note = '',
    String? reviewerName,
  }) =>
      _verificationDataSource.decideVerification(
        verificationId: verificationId,
        approved: approved,
        note: note,
        reviewerName: reviewerName,
      );

  Future<List<AdminReportModel>?> _readCachedQueue() async {
    final cached = await _cache.read(_queueCacheKey, ttl: _queueCacheTtl);
    if (cached == null) return null;
    final items = (cached['items'] as List).cast<Map<String, dynamic>>();
    return items.map(AdminReportModel.fromJson).toList();
  }

  List<AdminReport> _toEntities(List<AdminReportModel> models) =>
      models.map((model) => model.toEntity()).toList();
}
