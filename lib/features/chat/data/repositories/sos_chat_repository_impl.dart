import 'package:sheshield/features/chat/data/datasources/sos_chat_api_datasource.dart';
import 'package:sheshield/features/chat/domain/entities/responder_state.dart';
import 'package:sheshield/features/chat/domain/entities/sos_chat_message.dart';
import 'package:sheshield/features/chat/domain/repositories/sos_chat_repository.dart';

class SosChatRepositoryImpl implements SosChatRepository {
  const SosChatRepositoryImpl(this._apiDataSource);

  final SosChatApiDataSource _apiDataSource;

  @override
  Future<List<SosChatMessage>> fetchMessages(
    String sosId, {
    int afterSequence = 0,
  }) async {
    final models = await _apiDataSource.fetchMessages(
      sosId,
      afterSequence: afterSequence,
    );
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<SosChatMessage> sendMessage(String sosId, String body) async =>
      (await _apiDataSource.sendMessage(sosId, body)).toEntity();

  @override
  Future<ResponderState> fetchResponderState(String sosId) async =>
      (await _apiDataSource.fetchResponderState(sosId)).toEntity();
}
