import 'package:dio/dio.dart';
import 'package:sheshield/core/network/dio_client.dart';
import 'package:sheshield/shared/entities/app_user.dart';
import 'package:sheshield/shared/entities/gender.dart';
import 'package:sheshield/shared/entities/user_type.dart';
import '../../domain/repositories/i_auth_repository.dart';

/// The only file that talks to the Go backend's /auth endpoints.
class AuthApiDataSource {
  AuthApiDataSource(this._client);

  final DioClient _client;

  Future<AppUser> signIn(String email, String password) async {
    try {
      final res = await _client.dio.post(
        '/auth/login',
        data: {
          'email': email,
          'password': password,
        },
      );

      final data = res.data['data'] as Map<String, dynamic>;
      await _client.saveToken(data['token'] as String);

      return AppUser.fromJson(
        data['user'] as Map<String, dynamic>,
      );
    } on DioException catch (e) {
      throw AuthFailure(_mapError(e));
    }
  }

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
      final res = await _client.dio.post(
        '/auth/signup',
        data: {
          'name': name,
          'email': email,
          'password': password,
          'phone': phone,
          'countryCode': countryCode,
          'gender': gender.name,
          'userType': userType.apiValue,
        },
      );

      final data = res.data['data'] as Map<String, dynamic>;
      await _client.saveToken(data['token'] as String);

      return AppUser.fromJson(
        data['user'] as Map<String, dynamic>,
      );
    } on DioException catch (e) {
      throw AuthFailure(_mapError(e));
    }
  }

  Future<AppUser?> me() async {
    final token = await _client.readToken();

    if (token == null) return null;

    try {
      final res = await _client.dio.get('/auth/me');

      return AppUser.fromJson(
        res.data['data'] as Map<String, dynamic>,
      );
    } on DioException {
      return null;
    }
  }

  Future<void> signOut() => _client.clearToken();

  /// PATCH /auth/me -- only the fields the person actually changed are
  /// sent, matching the backend's UpdateProfileRequest (pointer
  /// fields: an omitted key leaves that field untouched server-side).
  Future<AppUser> updateProfile({
    String? name,
    String? phone,
    String? countryCode,
    String? address,
  }) async {
    try {
      final res = await _client.dio.patch('/auth/me', data: {
        if (name != null) 'name': name,
        if (phone != null) 'phone': phone,
        if (countryCode != null) 'countryCode': countryCode,
        if (address != null) 'address': address,
      });
      return AppUser.fromJson(res.data['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw AuthFailure(_mapError(e));
    }
  }

  String _mapError(DioException e) {
    final responseData = e.response?.data;

    if (responseData is Map && responseData['error'] is String) {
      return responseData['error'] as String;
    }

    if (e.type == DioExceptionType.connectionError ||
        e.type == DioExceptionType.connectionTimeout) {
      return 'No internet connection. Please try again.';
    }

    return 'Something went wrong. Please try again.';
  }
}