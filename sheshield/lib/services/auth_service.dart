import 'package:dio/dio.dart';
import '../core/constants/api_constants.dart';
import '../core/network/api_client.dart';
import '../core/storage/token_storage.dart';
import '../models/app_user.dart';
import '../models/gender.dart';
import '../models/user_type.dart';
import 'auth_exception.dart';

class AuthService {
  final Dio _dio = ApiClient.instance.dio;

  Future<AppUser> signUp({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String countryCode,
    required Gender gender,
    required UserType userType,
  }) async {
    try {
      final res = await _dio.post(ApiConstants.signUp, data: {
        'name': name,
        'email': email,
        'password': password,
        'phone': phone,
        'countryCode': countryCode,
        'gender': gender.apiValue,
        'userType': userType.apiValue,
      });
      final data = res.data['data'] as Map<String, dynamic>;
      await TokenStorage.instance.save(data['token'] as String);
      return AppUser.fromJson(data['user'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw AuthException(ApiClient.messageFromError(e));
    }
  }

  Future<AppUser> login({required String email, required String password}) async {
    try {
      final res = await _dio.post(ApiConstants.login, data: {
        'email': email,
        'password': password,
      });
      final data = res.data['data'] as Map<String, dynamic>;
      await TokenStorage.instance.save(data['token'] as String);
      return AppUser.fromJson(data['user'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw AuthException(ApiClient.messageFromError(e));
    }
  }

  /// Called on app launch to silently restore a session from a stored
  /// token. Returns null (never throws) if there's no token, it's
  /// expired/invalid, or the server can't be reached -- callers treat that
  /// as "signed out". Only an explicit 401 deletes the stored token.
  Future<AppUser?> restoreSession() async {
    final token = await TokenStorage.instance.read();
    if (token == null) return null;
    try {
      final res = await _dio.get(ApiConstants.me);
      final data = res.data['data'] as Map<String, dynamic>;
      return AppUser.fromJson(data);
    } on DioException catch (e) {
      // Only discard the token if the server actually rejected it. If the
      // server is unreachable (no signal, backend down) keep it, so the
      // next launch can restore the session instead of forcing a re-login.
      if (e.response?.statusCode == 401) {
        await TokenStorage.instance.clear();
      }
      return null;
    }
  }

  Future<void> logout() => TokenStorage.instance.clear();
}
