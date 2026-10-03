import 'package:dio/dio.dart';
import 'package:sheshield/core/error/app_failure.dart';
import 'package:sheshield/core/network/api_envelope.dart';
import 'package:sheshield/core/network/api_failure_mapper.dart';
import 'package:sheshield/core/network/dio_client.dart';
import 'package:sheshield/features/helper/data/models/accepted_alert_model.dart';
import 'package:sheshield/features/helper/data/models/live_state_model.dart';
import 'package:sheshield/features/helper/data/models/my_response_model.dart';
import 'package:sheshield/features/helper/data/models/nearby_alert_model.dart';
import 'package:sheshield/features/helper/data/models/safety_status_model.dart';
import 'package:sheshield/features/helper/domain/entities/response_stage.dart';

/// Finding, accepting and working an alert (`/helper/alerts/*`,
/// `/helper/responses/current`).
class HelperAlertApiDataSource {
  const HelperAlertApiDataSource(this._dioClient);

  static const _alertsPath = '/helper/alerts';

  final DioClient _dioClient;

  Dio get _dio => _dioClient.dio;

  Future<List<NearbyAlertModel>> fetchNearbyAlerts() => guardApiCall(() async {
        final response = await _dio.get<dynamic>('$_alertsPath/nearby');
        return readDataList(response).map(NearbyAlertModel.fromJson).toList();
      });

  /// 200 -> the full alert (this helper won). 409 -> another helper won:
  /// returns null, not an error. The server makes this one atomic
  /// operation so exactly one helper can ever win under concurrency.
  Future<AcceptedAlertModel?> acceptAlert(String alertId) async {
    try {
      return await guardApiCall(() async {
        final response = await _dio.post<dynamic>('$_alertsPath/$alertId/accept');
        return AcceptedAlertModel.fromJson(readDataObject(response));
      });
    } on AppFailure catch (failure) {
      if (failure.statusCode == 409) return null;
      rethrow;
    }
  }

  Future<void> releaseAlert(String alertId) =>
      guardApiCall(() => _dio.post<dynamic>('$_alertsPath/$alertId/release'));

  Future<SafetyStatusModel> fetchSafetyStatus(String alertId) =>
      guardApiCall(() async {
        final response = await _dio.get<dynamic>('$_alertsPath/$alertId/safety-status');
        return SafetyStatusModel.fromJson(readDataObject(response));
      });

  Future<MyResponseModel?> fetchCurrentResponse() => guardApiCall(() async {
        final response = await _dio.get<dynamic>('/helper/responses/current');
        final data = readDataObjectOrNull(response);
        return data == null ? null : MyResponseModel.fromJson(data);
      });

  Future<LiveStateModel> fetchLiveState(String alertId) => guardApiCall(() async {
        final response = await _dio.get<dynamic>('$_alertsPath/$alertId/live');
        return LiveStateModel.fromJson(readDataObject(response));
      });

  Future<void> setResponseStage(String alertId, ResponseStage stage) => guardApiCall(
        () => _dio.post<dynamic>(
          '$_alertsPath/$alertId/progress',
          data: {'status': stage.wireValue},
        ),
      );

  Future<void> resolveAlert(String alertId) =>
      guardApiCall(() => _dio.post<dynamic>('$_alertsPath/$alertId/resolve'));
}
