import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Owns the persisted JWT. Nothing else touches the token key.
class AuthTokenStore {
  const AuthTokenStore(this._secureStorage);

  static const _tokenKey = 'sheshield_jwt';

  final FlutterSecureStorage _secureStorage;

  Future<String?> readAuthToken() => _secureStorage.read(key: _tokenKey);

  Future<void> saveAuthToken(String token) =>
      _secureStorage.write(key: _tokenKey, value: token);

  Future<void> clearAuthToken() => _secureStorage.delete(key: _tokenKey);
}
