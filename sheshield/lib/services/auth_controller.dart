import 'package:flutter/foundation.dart';
import '../models/app_user.dart';
import '../models/gender.dart';
import '../models/user_type.dart';
import 'auth_exception.dart';
import 'contact_cache.dart';
import 'auth_service.dart';

enum AuthStatus { checking, signedOut, signedIn }

/// The single source of truth for "who's logged in". main.dart owns one
/// instance and rebuilds around it — screens that need the user or a
/// logout action get them passed down as constructor params, the same way
/// RootScreen already passes onOpenContacts into HomeScreen.
class AuthController extends ChangeNotifier {
  final _service = AuthService();

  AuthStatus status = AuthStatus.checking;
  AppUser? currentUser;
  String? errorMessage;
  bool isSubmitting = false;

  Future<void> checkSession() async {
    AppUser? user;
    try {
      user = await _service.restoreSession();
    } catch (_) {
      // Anything unexpected (e.g. secure storage failing on some devices)
      // must land on the login screen, never leave the app stuck on splash.
      user = null;
    }
    currentUser = user;
    status = user != null ? AuthStatus.signedIn : AuthStatus.signedOut;
    notifyListeners();
  }

  Future<bool> login({required String email, required String password}) {
    return _run(() => _service.login(email: email, password: password));
  }

  Future<bool> signUp({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String countryCode,
    required Gender gender,
    required UserType userType,
  }) {
    return _run(() => _service.signUp(
          name: name,
          email: email,
          password: password,
          phone: phone,
          countryCode: countryCode,
          gender: gender,
          userType: userType,
        ));
  }

  Future<bool> _run(Future<AppUser> Function() action) async {
    isSubmitting = true;
    errorMessage = null;
    notifyListeners();
    try {
      currentUser = await action();
      status = AuthStatus.signedIn;
      return true;
    } on AuthException catch (e) {
      errorMessage = e.message;
      return false;
    } catch (_) {
      errorMessage = 'Something went wrong. Please try again.';
      return false;
    } finally {
      isSubmitting = false;
      notifyListeners();
    }
  }

  /// Returns null on success, or a message to show the user. If the login has
  /// expired this signs the user out (the app then shows the login screen).
  Future<String?> updateProfile({
    String? name,
    String? phone,
    String? countryCode,
    String? address,
  }) async {
    try {
      currentUser = await _service.updateProfile(
        name: name,
        phone: phone,
        countryCode: countryCode,
        address: address,
      );
      notifyListeners();
      return null;
    } on AuthException catch (e) {
      if (e.unauthorized) await logout();
      return e.message;
    } catch (_) {
      return 'Something went wrong. Please try again.';
    }
  }

  Future<void> logout() async {
    await _service.logout();
    // The contacts copy on this phone belongs to whoever just signed out.
    await ContactCache().clear();
    currentUser = null;
    status = AuthStatus.signedOut;
    notifyListeners();
  }
}
