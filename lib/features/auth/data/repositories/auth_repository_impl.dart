import 'dart:async';

import 'package:sheshield/features/auth/data/datasources/auth_api_datasource.dart';
import 'package:sheshield/features/auth/domain/repositories/auth_repository.dart';
import 'package:sheshield/shared/entities/app_user.dart';
import 'package:sheshield/shared/entities/gender.dart';
import 'package:sheshield/shared/entities/user_type.dart';

/// REST has no native "auth state stream", so this repository simulates one:
/// it restores the session once at startup (from the stored JWT) and
/// re-emits whenever sign-in, sign-out or an update happens.
class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._apiDataSource) {
    refreshSession();
  }

  final AuthApiDataSource _apiDataSource;
  final StreamController<AppUser?> _authStateController =
      StreamController<AppUser?>.broadcast();

  @override
  Stream<AppUser?> get authStateChanges => _authStateController.stream;

  @override
  Future<void> refreshSession() async {
    final model = await _apiDataSource.fetchCurrentUser();
    _authStateController.add(model?.toEntity());
  }

  @override
  Future<AppUser> signIn({required String email, required String password}) async =>
      _emit((await _apiDataSource.signIn(email, password)).toEntity());

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
    final model = await _apiDataSource.signUp(
      name: name,
      email: email,
      password: password,
      phone: phone,
      countryCode: countryCode,
      gender: gender,
      userType: userType,
    );
    return _emit(model.toEntity());
  }

  @override
  Future<void> signOut() async {
    await _apiDataSource.signOut();
    _authStateController.add(null);
  }

  @override
  Future<AppUser> updateProfile({
    String? name,
    String? phone,
    String? countryCode,
    String? address,
  }) async {
    final model = await _apiDataSource.updateProfile(
      name: name,
      phone: phone,
      countryCode: countryCode,
      address: address,
    );
    return _emit(model.toEntity());
  }

  @override
  Future<void> updateFcmToken(String token) => _apiDataSource.updateFcmToken(token);

  @override
  Future<void> setDiscoverable(bool discoverable) async {
    await _apiDataSource.setDiscoverable(discoverable);
    await refreshSession();
  }

  AppUser _emit(AppUser user) {
    _authStateController.add(user);
    return user;
  }
}
