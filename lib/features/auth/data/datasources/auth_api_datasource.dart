import 'package:dio/dio.dart';
import 'package:sheshield/core/network/api_envelope.dart';
import 'package:sheshield/core/network/api_failure_mapper.dart';
import 'package:sheshield/core/network/dio_client.dart';
import 'package:sheshield/features/auth/data/models/app_user_model.dart';
import 'package:sheshield/features/auth/data/models/auth_session_model.dart';
import 'package:sheshield/shared/entities/gender.dart';
import 'package:sheshield/shared/entities/user_type.dart';

/// The only file that talks to the backend's `/auth` endpoints. Login and
/// signup also persist the returned JWT.
class AuthApiDataSource {
  const AuthApiDataSource(this._dioClient);

  final DioClient _dioClient;

  Dio get _dio => _dioClient.dio;

  Future<AppUserModel> signIn(String email, String password) =>
      guardApiCall(() async {
        final response = await _dio.post<dynamic>(
          '/auth/login',
          data: {'email': email, 'password': password},
        );
        return _storeSession(response);
      });

  Future<AppUserModel> signUp({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String countryCode,
    required Gender gender,
    required UserType userType,
  }) =>
      guardApiCall(() async {
        final response = await _dio.post<dynamic>(
          '/auth/signup',
          data: {
            'name': name,
            'email': email,
            'password': password,
            'phone': phone,
            'countryCode': countryCode,
            'gender': gender.name,
            'userType': userType.wireValue,
          },
        );
        return _storeSession(response);
      });

  /// Null when signed out, or when the stored token is no longer valid.
  Future<AppUserModel?> fetchCurrentUser() async {
    if (await _dioClient.readToken() == null) return null;
    try {
      final response = await _dio.get<dynamic>('/auth/me');
      return AppUserModel.fromJson(readDataObject(response));
    } on DioException {
      return null;
    }
  }

  Future<void> signOut() => _dioClient.clearToken();

  /// PATCH /auth/me: only the fields the person changed are sent; an omitted
  /// key leaves that field untouched server-side.
  Future<AppUserModel> updateProfile({
    String? name,
    String? phone,
    String? countryCode,
    String? address,
  }) =>
      guardApiCall(() async {
        final response = await _dio.patch<dynamic>(
          '/auth/me',
          data: {
            if (name != null) 'name': name,
            if (phone != null) 'phone': phone,
            if (countryCode != null) 'countryCode': countryCode,
            if (address != null) 'address': address,
          },
        );
        return AppUserModel.fromJson(readDataObject(response));
      });

  /// PATCH /auth/fcm-token: registers (or, with "", clears) this device's
  /// push token. Best-effort for callers: a missed update just means this
  /// device is alarmed after its next successful refresh.
  Future<void> updateFcmToken(String token) => guardApiCall(
        () => _dio.patch<dynamic>('/auth/fcm-token', data: {'token': token}),
      );

  /// PATCH /auth/discoverable (spec §10).
  Future<void> setDiscoverable(bool discoverable) => guardApiCall(
        () => _dio.patch<dynamic>(
          '/auth/discoverable',
          data: {'discoverable': discoverable},
        ),
      );

  Future<AppUserModel> _storeSession(Response<dynamic> response) async {
    final session = AuthSessionModel.fromJson(readDataObject(response));
    await _dioClient.saveToken(session.token);
    return session.user;
  }
}
