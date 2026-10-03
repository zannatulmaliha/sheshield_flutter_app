import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Persists the operator key. Separate from the user JWT on purpose.
class AdminKeyStore {
  const AdminKeyStore(this._secureStorage);

  static const _keyName = 'sheshield_admin_key';

  final FlutterSecureStorage _secureStorage;

  Future<String?> readAdminKey() => _secureStorage.read(key: _keyName);

  Future<bool> hasKey() async => (await readAdminKey())?.isNotEmpty ?? false;

  Future<void> saveAdminKey(String key) =>
      _secureStorage.write(key: _keyName, value: key);

  Future<void> clearAdminKey() => _secureStorage.delete(key: _keyName);
}
