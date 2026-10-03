import 'package:dio/dio.dart';
import 'package:sheshield/core/network/api_envelope.dart';
import 'package:sheshield/core/network/api_failure_mapper.dart';
import 'package:sheshield/core/network/dio_client.dart';
import 'package:sheshield/features/helper/data/models/helper_status_model.dart';

/// `/helper/status` (internal/helper/handler.go). The shared client's base
/// URL already ends in `/api/v1`, so paths here start at `/helper`.
class HelperStatusApiDataSource {
  const HelperStatusApiDataSource(this._dioClient);

  static const _statusPath = '/helper/status';

  final DioClient _dioClient;

  Dio get _dio => _dioClient.dio;

  Future<HelperStatusModel> fetchStatus() => guardApiCall(() async {
        final response = await _dio.get<dynamic>(_statusPath);
        return HelperStatusModel.fromJson(readDataObject(response));
      });

  /// body: `{ isActive, radiusKm, latitude?, longitude?, mutualConnectionOptIn }`
  Future<HelperStatusModel> setStatus({
    required bool isActive,
    required double radiusKm,
    required bool mutualConnectionOptIn,
    double? latitude,
    double? longitude,
  }) =>
      guardApiCall(() async {
        final response = await _dio.put<dynamic>(
          _statusPath,
          data: {
            'isActive': isActive,
            'radiusKm': radiusKm,
            if (latitude != null) 'latitude': latitude,
            if (longitude != null) 'longitude': longitude,
            'mutualConnectionOptIn': mutualConnectionOptIn,
          },
        );
        return HelperStatusModel.fromJson(readDataObject(response));
      });
}
