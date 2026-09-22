import 'dart:async';
import 'package:sheshield/shared/entities/app_user.dart';
import 'package:sheshield/shared/entities/gender.dart';
import 'package:sheshield/shared/entities/user_type.dart';
import '../../domain/repositories/i_auth_repository.dart';
import '../datasources/auth_api_datasource.dart';

/// REST has no native "auth state stream", so this repository
/// simulates one: it restores the session once at startup (via the
/// stored JWT) and re-emits whenever sign in/out/update happens.
class AuthRepositoryImpl implements IAuthRepository {
  AuthRepositoryImpl(this._dataSource) {
    _restoreSession();
  }

  final AuthApiDataSource _dataSource;
  final StreamController<AppUser?> _controller =
      StreamController<AppUser?>.broadcast();

  Future<void> _restoreSession() async {
    final user = await _dataSource.me();
    _controller.add(user);
  }

  @override
  Stream<AppUser?> get authStateChanges => _controller.stream;

  @override
  Future<AppUser> signIn({required String email, required String password}) async {
    final user = await _dataSource.signIn(email, password);
    _controller.add(user);
    return user;
  }

  @override
  Future<AppUser> signUp({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String countryCode,
    required Gender gender,
    required UserType userType,
  }) async {
    final user = await _dataSource.signUp(
      name: name,
      email: email,
      password: password,
      phone: phone,
      countryCode: countryCode,
      gender: gender,
      userType: userType,
    );
    _controller.add(user);
    return user;
  }

  @override
  Future<void> signOut() async {
    await _dataSource.signOut();
    _controller.add(null);
  }

  @override
  Future<void> refreshSession() => _restoreSession();
  
  @override
  Future<AppUser> updateProfile({
    String? name,
    String? phone,
    String? countryCode,
    String? address,
  }) async {
    final user = await _dataSource.updateProfile(
      name: name,
      phone: phone,
      countryCode: countryCode,
      address: address,
    );
    _controller.add(user);
    return user;
  }
}