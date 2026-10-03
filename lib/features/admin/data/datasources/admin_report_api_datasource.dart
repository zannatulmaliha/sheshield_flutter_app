import 'package:sheshield/core/network/api_envelope.dart';
import 'package:sheshield/features/admin/data/datasources/admin_api_client.dart';
import 'package:sheshield/features/admin/data/models/admin_report_detail_model.dart';
import 'package:sheshield/features/admin/data/models/admin_report_model.dart';
import 'package:sheshield/features/admin/domain/entities/review_decision.dart';

/// Moderation-queue and helper-suspension endpoints.
class AdminReportApiDataSource {
  const AdminReportApiDataSource(this._apiClient);

  final AdminApiClient _apiClient;

  Future<List<AdminReportModel>> fetchReportQueue() => _apiClient.guard(() async {
        final response = await _apiClient.dio.get<dynamic>(
          '/admin/reports',
          options: await _apiClient.authorizedOptions(),
        );
        return readDataList(response).map(AdminReportModel.fromJson).toList();
      });

  Future<AdminReportDetailModel> fetchReportDetail(String reportId) =>
      _apiClient.guard(() async {
        final response = await _apiClient.dio.get<dynamic>(
          '/admin/reports/$reportId',
          options: await _apiClient.authorizedOptions(),
        );
        return AdminReportDetailModel.fromJson(readDataObject(response));
      });

  Future<void> reviewReport({
    required String reportId,
    required ReviewDecision decision,
    required String resolution,
    required bool markFalseSos,
    String? reviewerName,
  }) =>
      _apiClient.guard(
        () async => _apiClient.dio.post<dynamic>(
          '/admin/reports/$reportId/review',
          options: await _apiClient.authorizedOptions(),
          data: {
            'status': decision.wireValue,
            'resolution': resolution,
            'markFalseSos': markFalseSos,
            if (reviewerName != null && reviewerName.isNotEmpty)
              'reviewerName': reviewerName,
          },
        ),
      );

  /// POST /admin/helpers/{uid}/suspend -> { data: { releasedSosId } }
  Future<String?> suspendHelper({
    required String uid,
    required String reason,
    String? reviewerName,
  }) =>
      _apiClient.guard(() async {
        final response = await _apiClient.dio.post<dynamic>(
          '/admin/helpers/$uid/suspend',
          options: await _apiClient.authorizedOptions(),
          data: {
            'reason': reason,
            if (reviewerName != null && reviewerName.isNotEmpty)
              'reviewerName': reviewerName,
          },
        );
        final data = readDataObjectOrNull(response);
        final releasedSosId = data?['releasedSosId'];
        return releasedSosId is String && releasedSosId.isNotEmpty
            ? releasedSosId
            : null;
      });
}
