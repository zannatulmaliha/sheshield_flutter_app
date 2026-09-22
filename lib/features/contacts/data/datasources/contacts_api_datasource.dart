import 'package:dio/dio.dart';
import 'package:sheshield/core/network/dio_client.dart';
import '../../domain/entities/trusted_contact.dart';
import '../../domain/repositories/i_contacts_repository.dart';

/// The only file that talks to the Go backend's /api/v1/contacts
/// endpoints (internal/contact/handler.go).
class ContactsApiDataSource {
  ContactsApiDataSource(this._client);
  final DioClient _client;
  static const _basePath = '/contacts';

  /// GET /api/v1/contacts -> { "data": [ {id,name,relation,phone,
  /// countryCode,createdAt}, ... ] }
  Future<List<TrustedContact>> list() async {
    try {
      final res = await _client.dio.get(_basePath);
      final items = res.data['data'] as List<dynamic>;
      return items
          .map((j) => TrustedContact.fromJson(j as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw _fail(e);
    }
  }

  /// POST /api/v1/contacts
  /// body: { name, relation, phone, countryCode }
  /// The server enforces the 10-contact cap and rejects duplicates
  /// (409) -- both surfaced here as the server's own message.
  Future<TrustedContact> add({
    required String name,
    required String relation,
    required String phone,
    required String countryCode,
  }) async {
    try {
      final res = await _client.dio.post(_basePath, data: {
        'name': name,
        'relation': relation,
        'phone': phone,
        'countryCode': countryCode,
      });
      return TrustedContact.fromJson(res.data['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _fail(e);
    }
  }

  /// DELETE /api/v1/contacts/{id}
  Future<void> remove(String contactId) async {
    try {
      await _client.dio.delete('$_basePath/$contactId');
    } on DioException catch (e) {
      throw _fail(e);
    }
  }

  ContactsFailure _fail(DioException e) {
    final data = e.response?.data;
    final message = (data is Map && data['error'] is String)
        ? data['error'] as String
        : (e.type == DioExceptionType.connectionError ||
                e.type == DioExceptionType.connectionTimeout
            ? 'No internet connection. Please try again.'
            : 'Something went wrong. Please try again.');
    return ContactsFailure(message, unauthorized: e.response?.statusCode == 401);
  }
}