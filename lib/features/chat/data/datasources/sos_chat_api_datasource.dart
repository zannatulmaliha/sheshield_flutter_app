import 'package:dio/dio.dart';
import 'package:sheshield/core/network/api_envelope.dart';
import 'package:sheshield/core/network/api_failure_mapper.dart';
import 'package:sheshield/core/network/dio_client.dart';
import 'package:sheshield/features/chat/data/models/responder_state_model.dart';
import 'package:sheshield/features/chat/data/models/sos_chat_message_model.dart';

/// The only file that talks to the SOS message and responder endpoints.
class SosChatApiDataSource {
  const SosChatApiDataSource(this._dioClient);

  final DioClient _dioClient;

  Dio get _dio => _dioClient.dio;

  Future<List<SosChatMessageModel>> fetchMessages(
    String sosId, {
    required int afterSequence,
  }) =>
      guardApiCall(() async {
        final response = await _dio.get<dynamic>(
          '/sos/$sosId/messages',
          queryParameters: {'after': afterSequence},
        );
        return readDataList(response).map(SosChatMessageModel.fromJson).toList();
      });

  Future<SosChatMessageModel> sendMessage(String sosId, String body) =>
      guardApiCall(() async {
        final response = await _dio.post<dynamic>(
          '/sos/$sosId/messages',
          data: {'body': body},
        );
        return SosChatMessageModel.fromJson(readDataObject(response));
      });

  Future<ResponderStateModel> fetchResponderState(String sosId) =>
      guardApiCall(() async {
        final response = await _dio.get<dynamic>('/alerts/$sosId/responder');
        return ResponderStateModel.fromJson(readDataObject(response));
      });
}
