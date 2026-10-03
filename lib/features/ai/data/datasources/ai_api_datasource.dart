import 'package:dio/dio.dart';
import 'package:sheshield/core/network/api_envelope.dart';
import 'package:sheshield/core/network/api_failure_mapper.dart';
import 'package:sheshield/core/network/dio_client.dart';
import 'package:sheshield/features/ai/data/models/chat_message_model.dart';
import 'package:sheshield/features/ai/data/models/chat_reply_model.dart';

/// The only file that talks to `/api/v1/ai/chat` (internal/ai/handler.go).
class AiApiDataSource {
  const AiApiDataSource(this._dioClient);

  static const _chatPath = '/ai/chat';

  final DioClient _dioClient;

  Dio get _dio => _dioClient.dio;

  /// body: `{ history: [{role, content}, ...] }` -> `{ data: { reply } }`
  Future<ChatReplyModel> sendChatMessage(List<ChatMessageModel> history) =>
      guardApiCall(() async {
        final response = await _dio.post<dynamic>(
          _chatPath,
          data: {'history': history.map((message) => message.toJson()).toList()},
        );
        return ChatReplyModel.fromJson(readDataObject(response));
      });
}
