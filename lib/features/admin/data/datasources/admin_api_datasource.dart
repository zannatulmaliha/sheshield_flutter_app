import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sheshield/core/network/dio_client.dart';
import '../../domain/entities/admin_report.dart';
import '../../domain/entities/admin_report_detail.dart';
import '../../domain/entities/admin_verification.dart';
import '../../domain/repositories/i_admin_repository.dart';

/// The only file that talks to /api/v1/admin/* (internal/adminapi).
///
/// Authenticated by a static operator key sent as `X-Admin-Key` -- a
/// different credential from the app's user JWT. It deliberately uses its
/// OWN Dio instance (same base URL, no interceptors) instead of
/// DioClient.dio: the shared client attaches the user's Bearer token and
/// DELETES it on any 401, so a mistyped admin key would otherwise log the
/// user out of the main app.
class AdminApiDataSource {
  AdminApiDataSource(DioClient client, this._storage)
      : _dio = Dio(BaseOptions(
          baseUrl: client.dio.options.baseUrl,
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
        ));

  final Dio _dio;
  final FlutterSecureStorage _storage;
  static const _keyName = 'sheshield_admin_key';

  Future<bool> hasKey() async =>
      (await _storage.read(key: _keyName))?.isNotEmpty ?? false;
  Future<void> saveKey(String key) => _storage.write(key: _keyName, value: key);
  Future<void> clearKey() => _storage.delete(key: _keyName);

  Future<Options> _options() async {
    final key = await _storage.read(key: _keyName);
    return Options(headers: {'X-Admin-Key': key ?? ''});
  }

  /// GET /admin/reports -> { data: [Report] | null }
  Future<List<AdminReport>> fetchQueue() async {
    try {
      final res = await _dio.get('/admin/reports', options: await _options());
      final list = (res.data['data'] as List<dynamic>?) ?? const [];
      return list
          .map((j) => AdminReport.fromJson(j as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw _fail(e);
    }
  }

  /// GET /admin/reports/{id} -> { data: { report, auditTrail } }
  Future<AdminReportDetail> fetchDetail(String reportId) async {
    try {
      final res =
          await _dio.get('/admin/reports/$reportId', options: await _options());
      return AdminReportDetail.fromJson(
          res.data['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _fail(e);
    }
  }

  /// POST /admin/reports/{id}/review -> 204
  Future<void> review({
    required String reportId,
    required ReviewDecision decision,
    required String resolution,
    required bool markFalseSos,
    String? reviewerName,
  }) async {
    try {
      await _dio.post(
        '/admin/reports/$reportId/review',
        options: await _options(),
        data: {
          'status': decision.key,
          'resolution': resolution,
          'markFalseSos': markFalseSos,
          if (reviewerName != null && reviewerName.isNotEmpty)
            'reviewerName': reviewerName,
        },
      );
    } on DioException catch (e) {
      throw _fail(e);
    }
  }

  /// GET /admin/verifications -> helper verification records.
  Future<List<AdminVerification>> fetchVerificationQueue() async {
    try {
      final res =
          await _dio.get('/admin/verifications', options: await _options());
      final list = (res.data['data'] as List<dynamic>?) ?? const [];
      return list
          .map((j) => AdminVerification.fromJson(j as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw _fail(e);
    }
  }

  Future<AdminVerification> fetchVerificationDetail(
      String verificationId) async {
    try {
      final res = await _dio.get('/admin/verifications/$verificationId',
          options: await _options());
      return AdminVerification.fromJson(
          res.data['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _fail(e);
    }
  }

  Future<List<int>> fetchVerificationImage(
      {required String verificationId, required String kind}) async {
    try {
      final res = await _dio.get<List<int>>(
        '/admin/verifications/$verificationId/images/$kind',
        options: (await _options()).copyWith(responseType: ResponseType.bytes),
      );
      return res.data ?? const [];
    } on DioException catch (e) {
      throw _fail(e);
    }
  }

  Future<void> decideVerification(
      {required String verificationId,
      required bool approved,
      String note = '',
      String? reviewerName}) async {
    try {
      await _dio.post(
        '/admin/verifications/$verificationId/decision',
        options: await _options(),
        data: {
          'approved': approved,
          'note': note,
          if (reviewerName != null && reviewerName.isNotEmpty)
            'reviewerName': reviewerName,
        },
      );
    } on DioException catch (e) {
      throw _fail(e);
    }
  }

  /// POST /admin/helpers/{uid}/suspend -> { data: { releasedSosId } }
  Future<String?> suspendHelper({
    required String uid,
    required String reason,
    String? reviewerName,
  }) async {
    try {
      final res = await _dio.post(
        '/admin/helpers/$uid/suspend',
        options: await _options(),
        data: {
          'reason': reason,
          if (reviewerName != null && reviewerName.isNotEmpty)
            'reviewerName': reviewerName,
        },
      );
      final released =
          (res.data['data'] as Map<String, dynamic>?)?['releasedSosId'];
      return (released is String && released.isNotEmpty) ? released : null;
    } on DioException catch (e) {
      throw _fail(e);
    }
  }

  AdminFailure _fail(DioException e) {
    final status = e.response?.statusCode;
    final data = e.response?.data;
    if (status == 401) {
      return const AdminFailure('Invalid admin key.', unauthorized: true);
    }
    if (status == 404 && data is! Map) {
      return const AdminFailure('Admin access is not enabled on this server.');
    }
    final message = (data is Map && data['error'] is String)
        ? data['error'] as String
        : (e.type == DioExceptionType.connectionError ||
                e.type == DioExceptionType.connectionTimeout
            ? 'No internet connection. Please try again.'
            : 'Something went wrong. Please try again.');
    return AdminFailure(message);
  }
}
