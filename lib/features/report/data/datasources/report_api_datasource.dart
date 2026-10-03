import 'package:dio/dio.dart';
import 'package:sheshield/core/network/api_envelope.dart';
import 'package:sheshield/core/network/api_failure_mapper.dart';
import 'package:sheshield/core/network/dio_client.dart';
import 'package:sheshield/features/report/data/models/blocked_user_model.dart';
import 'package:sheshield/features/report/domain/entities/report_category.dart';

/// The only file that talks to `/api/v1/reports` and `/api/v1/blocks`.
class ReportApiDataSource {
  const ReportApiDataSource(this._dioClient);

  final DioClient _dioClient;

  Dio get _dio => _dioClient.dio;

  /// POST /reports?role={reporterRole}
  Future<void> fileReport({
    required String reportedId,
    required ReportCategory category,
    required String reporterRole,
    String? sosId,
  }) =>
      guardApiCall(
        () => _dio.post<dynamic>(
          '/reports',
          queryParameters: {'role': reporterRole},
          data: {
            'reportedId': reportedId,
            'category': category.key,
            if (sosId != null) 'sosId': sosId,
          },
        ),
      );

  /// POST /blocks  body: { userId }
  Future<void> blockUser(String userId) => guardApiCall(
        () => _dio.post<dynamic>('/blocks', data: {'userId': userId}),
      );

  /// DELETE /blocks/{userId}
  Future<void> unblockUser(String userId) =>
      guardApiCall(() => _dio.delete<dynamic>('/blocks/$userId'));

  /// GET /blocks -> { "data": [ { blockerId, blockedId, createdAt } ] }
  Future<List<BlockedUserModel>> fetchBlockedUsers() => guardApiCall(() async {
        final response = await _dio.get<dynamic>('/blocks');
        return readDataList(response).map(BlockedUserModel.fromJson).toList();
      });
}
