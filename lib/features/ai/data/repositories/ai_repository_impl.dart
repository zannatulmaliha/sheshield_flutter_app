import 'package:sheshield/features/ai/data/datasources/ai_api_datasource.dart';
import 'package:sheshield/features/ai/data/models/chat_message_model.dart';
import 'package:sheshield/features/ai/domain/entities/chat_message.dart';
import 'package:sheshield/features/ai/domain/repositories/ai_repository.dart';

/// No caching: a chat reply is never something a second screen should reuse.
class AiRepositoryImpl implements AiRepository {
  const AiRepositoryImpl(this._apiDataSource);

  final AiApiDataSource _apiDataSource;

  @override
  Future<String> sendChatMessage(List<ChatMessage> history) async {
    final reply = await _apiDataSource.sendChatMessage(
      history.map(ChatMessageModel.fromEntity).toList(),
    );
    return reply.reply;
  }
}
