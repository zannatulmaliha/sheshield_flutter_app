import 'package:dio/dio.dart';
import 'package:sheshield/core/network/dio_client.dart';
import '../../domain/entities/blocked_user.dart';
import '../../domain/entities/report_category.dart';
import '../../domain/repositories/i_report_repository.dart';

/// The only file that talks to the Go backend's /api/v1/reports and
/// /api/v1/blocks endpoints (internal/report/handler.go).
class ReportApiDataSource {
  ReportApiDataSource(this._client);
  final DioClient _client;

  /// POST /api/v1/reports?role={reporterRole}
  /// body: { reportedId, category, sosId } -> { "data": { id, ... } }
  Future<void> file({
    required String reportedId,
    required ReportCategory category,
    required String reporterRole,
    String? sosId,
  }) async {
    try {
      await _client.dio.post(
        '/reports',
        queryParameters: {'role': reporterRole},
        data: {
          'reportedId': reportedId,
          'category': category.key,
          if (sosId != null) 'sosId': sosId,
        },
      );
    } on DioException catch (e) {
      throw _fail(e);
    }
  }

  /// POST /api/v1/blocks  body: { userId }
  Future<void> block(String userId) async {
    try {
      await _client.dio.post('/blocks', data: {'userId': userId});
    } on DioException catch (e) {
      throw _fail(e);
    }
  }

  /// DELETE /api/v1/blocks/{userId}
  Future<void> unblock(String userId) async {
    try {
      await _client.dio.delete('/blocks/$userId');
    } on DioException catch (e) {
      throw _fail(e);
    }
  }

  /// GET /api/v1/blocks -> { "data": [ { blockerId, blockedId, createdAt }, ... ] }
  Future<List<BlockedUser>> listBlocks() async {
    try {
      final res = await _client.dio.get('/blocks');
      final list = res.data['data'] as List<dynamic>;
      return list.map((j) => BlockedUser.fromJson(j as Map<String, dynamic>)).toList();
    } on DioException catch (e) {
      throw _fail(e);
    }
  }

  ReportFailure _fail(DioException e) {
    final data = e.response?.data;
    final message = (data is Map && data['error'] is String)
        ? data['error'] as String
        : (e.type == DioExceptionType.connectionError ||
                e.type == DioExceptionType.connectionTimeout
            ? 'No internet connection. Please try again.'
            : 'Something went wrong. Please try again.');
    return ReportFailure(message, unauthorized: e.response?.statusCode == 401);
  }
}
