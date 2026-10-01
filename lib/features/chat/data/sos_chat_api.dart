import 'package:dio/dio.dart';
import 'package:sheshield/core/network/dio_client.dart';

class SosChatMessage {
  const SosChatMessage({required this.seq, required this.id, required this.from, required this.mine, required this.body, required this.createdAt});
  final int seq;
  final String id;

  /// "requester" | "helper" -- never a name or number.
  final String from;
  final bool mine;
  final String body;
  final DateTime createdAt;

  factory SosChatMessage.fromJson(Map<String, dynamic> j) => SosChatMessage(
        seq: (j['seq'] as num).toInt(),
        id: j['id'] as String,
        from: j['from'] as String,
        mine: j['mine'] as bool? ?? false,
        body: j['body'] as String,
        createdAt: DateTime.tryParse((j['createdAt'] as String?) ?? '') ?? DateTime.now(),
      );
}

class SosChatException implements Exception {
  const SosChatException(this.message, {this.closed = false});
  final String message;

  /// The conversation is over (alert resolved / helper released).
  final bool closed;
  @override
  String toString() => message;
}

/// In-app requester <-> helper messages for one SOS (backend internal/sosmsg).
/// Polling with a `seq` cursor keeps this dependency-free; swap for SSE or
/// websockets later without touching the UI.
class SosChatApi {
  SosChatApi(this._client);
  final DioClient _client;

  Future<List<SosChatMessage>> list(String sosId, {int after = 0}) async {
    try {
      final res = await _client.dio.get('/sos/$sosId/messages', queryParameters: {'after': after});
      final data = (res.data['data'] as List<dynamic>?) ?? const [];
      return data.map((j) => SosChatMessage.fromJson(j as Map<String, dynamic>)).toList();
    } on DioException catch (e) {
      throw _fail(e);
    }
  }

  Future<SosChatMessage> send(String sosId, String body) async {
    try {
      final res = await _client.dio.post('/sos/$sosId/messages', data: {'body': body});
      return SosChatMessage.fromJson(res.data['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _fail(e);
    }
  }

  SosChatException _fail(DioException e) {
    final code = e.response?.statusCode;
    final data = e.response?.data;
    final msg = (data is Map && data['error'] is String) ? data['error'] as String : 'Could not reach the server.';
    return SosChatException(msg, closed: code == 403 || code == 409);
  }
}
