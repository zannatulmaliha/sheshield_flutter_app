import 'package:dio/dio.dart';
import '../core/network/api_client.dart';
import '../models/saved_contact.dart';

/// Thrown by [ContactService]. [message] is safe to show to the user as-is.
/// [unauthorized] means the login token was rejected (expired/invalid), so
/// the app should send the user back to the login screen.
class ContactException implements Exception {
  const ContactException(this.message, {this.unauthorized = false});
  final String message;
  final bool unauthorized;

  @override
  String toString() => message;
}

class ContactService {
  static const _path = '/api/v1/contacts';

  final _dio = ApiClient.instance.dio;

  Future<List<SavedContact>> list() async {
    try {
      final res = await _dio.get(_path);
      final data = res.data['data'] as List<dynamic>;
      return data.map((e) => SavedContact.fromJson(e as Map<String, dynamic>)).toList();
    } on DioException catch (e) {
      throw _fail(e);
    }
  }

  Future<SavedContact> add({
    required String name,
    required String relation,
    required String phone,
    required String countryCode,
  }) async {
    try {
      final res = await _dio.post(_path, data: {
        'name': name,
        'relation': relation,
        'phone': phone,
        'countryCode': countryCode,
      });
      return SavedContact.fromJson(res.data['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _fail(e);
    }
  }

  Future<void> delete(String id) async {
    try {
      await _dio.delete('$_path/$id');
    } on DioException catch (e) {
      throw _fail(e);
    }
  }

  ContactException _fail(DioException e) => ContactException(
        ApiClient.messageFromError(e),
        unauthorized: e.response?.statusCode == 401,
      );
}
