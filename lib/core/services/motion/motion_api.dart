import 'package:dio/dio.dart';
import 'package:sheshield/core/network/dio_client.dart';

import 'motion_event.dart';

/// What the person did when asked "Are you OK?".
enum MotionUserResponse { none, ok, help, timeout }

/// POST /api/v1/motion/events -- stores only the derived event (type,
/// confidence, what the person answered, optional coarse position). Raw
/// sensor samples are never uploaded. Always best-effort: failing to log an
/// event must never get in the way of sending an SOS.
class MotionApi {
  MotionApi(this._client);
  final DioClient _client;

  Future<void> report(
    MotionEvent event, {
    required MotionUserResponse response,
    String? sosId,
    double? latitude,
    double? longitude,
    DateTime? occurredAt,
  }) async {
    try {
      await _client.dio.post('/motion/events', data: {
        'type': event.type.wire,
        'confidence': event.confidence,
        'userResponse': response.name,
        if (sosId != null) 'sosId': sosId,
        if (latitude != null && longitude != null) ...{'latitude': latitude, 'longitude': longitude},
        'occurredAt': (occurredAt ?? DateTime.now()).toUtc().toIso8601String(),
      },);
    } on DioException {
      // swallowed on purpose
    }
  }

  /// DELETE /api/v1/motion/events -- "erase my motion history".
  Future<bool> deleteAll() async {
    try {
      await _client.dio.delete('/motion/events');
      return true;
    } on DioException {
      return false;
    }
  }
}
