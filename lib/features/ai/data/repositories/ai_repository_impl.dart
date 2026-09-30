import '../../domain/entities/chat_message.dart';
import '../../domain/repositories/i_ai_repository.dart';
import '../datasources/ai_api_datasource.dart';

/// Thin adapter satisfying [IAiRepository] -- no caching, unlike contacts,
/// since a chat reply is never something a second screen should reuse.
class AiRepositoryImpl implements IAiRepository {
  AiRepositoryImpl(this._dataSource);
  final AiApiDataSource _dataSource;

  @override
  Future<String> sendMessage(List<ChatMessage> history) =>
      _dataSource.sendMessage(history);
}
