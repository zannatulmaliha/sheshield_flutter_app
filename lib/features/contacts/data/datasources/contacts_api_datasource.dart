import 'package:dio/dio.dart';
import 'package:sheshield/core/network/api_envelope.dart';
import 'package:sheshield/core/network/api_failure_mapper.dart';
import 'package:sheshield/core/network/dio_client.dart';
import 'package:sheshield/features/contacts/data/models/contact_invite_model.dart';
import 'package:sheshield/features/contacts/data/models/trusted_contact_model.dart';

/// The only file that talks to `/api/v1/contacts`.
class ContactsApiDataSource {
  const ContactsApiDataSource(this._dioClient);

  static const _basePath = '/contacts';

  final DioClient _dioClient;

  Dio get _dio => _dioClient.dio;

  Future<List<TrustedContactModel>> fetchContacts() => guardApiCall(() async {
        final response = await _dio.get<dynamic>(_basePath);
        return readDataList(response).map(TrustedContactModel.fromJson).toList();
      });

  /// The server enforces the 10-contact cap and rejects duplicates (409);
  /// both come back as the server's own message.
  Future<TrustedContactModel> addContact({
    required String name,
    required String relation,
    required String phone,
    required String countryCode,
  }) =>
      guardApiCall(() async {
        final response = await _dio.post<dynamic>(
          _basePath,
          data: {
            'name': name,
            'relation': relation,
            'phone': phone,
            'countryCode': countryCode,
          },
        );
        return TrustedContactModel.fromJson(readDataObject(response));
      });

  Future<void> removeContact(String contactId) =>
      guardApiCall(() => _dio.delete<dynamic>('$_basePath/$contactId'));

  Future<ContactInviteModel> createInvite(String contactId) =>
      guardApiCall(() async {
        final response = await _dio.post<dynamic>('$_basePath/$contactId/invite');
        return ContactInviteModel.fromJson(readDataObject(response));
      });

  Future<void> acceptInvite(String code) => guardApiCall(
        () => _dio.post<dynamic>('$_basePath/accept-invite', data: {'code': code}),
      );
}
