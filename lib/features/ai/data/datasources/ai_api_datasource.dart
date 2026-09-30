import 'package:dio/dio.dart';
import 'package:sheshield/core/network/dio_client.dart';
import '../../domain/entities/chat_message.dart';
import '../../domain/repositories/i_ai_repository.dart';

/// The only file that talks to the Go backend's /api/v1/ai/chat endpoint
/// (internal/ai/handler.go).
class AiApiDataSource {
  AiApiDataSource(this._client);
  final DioClient _client;
  static const _basePath = '/ai/chat';

  /// POST /api/v1/ai/chat
  /// body: { history: [{role, content}, ...] } -> { "data": { "reply": "..." } }
  Future<String> sendMessage(List<ChatMessage> history) async {
    try {
      final res = await _client.dio.post(_basePath, data: {
        'history': history.map((m) => m.toJson()).toList(),
      });
      final data = res.data['data'] as Map<String, dynamic>;
      return data['reply'] as String;
    } on DioException catch (e) {
      throw _fail(e);
    }
  }

  AiFailure _fail(DioException e) {
    final data = e.response?.data;
    final message = (data is Map && data['error'] is String)
        ? data['error'] as String
        : (e.type == DioExceptionType.connectionError ||
                e.type == DioExceptionType.connectionTimeout
            ? 'No internet connection. Please try again.'
            : 'Something went wrong. Please try again.');
    return AiFailure(message, unauthorized: e.response?.statusCode == 401);
  }
}
