import 'package:flutter/foundation.dart';

/// Where the Go backend lives. Override at run time with:
///   flutter run -t lib/main_auth.dart --dart-define=API_BASE_URL=http://192.168.1.20:8080
/// (use your computer's LAN IP when testing on a physical phone).
///
/// The default below only matters for local dev:
/// - Android emulator can't see the host's "localhost" -- it must use 10.0.2.2.
/// - iOS simulator, web, and desktop can use localhost directly.
/// Uses defaultTargetPlatform/kIsWeb rather than dart:io's Platform, because
/// Platform throws on web.
class ApiConstants {
  ApiConstants._();

  static const String _override = String.fromEnvironment('API_BASE_URL');

  static String get baseUrl {
    if (_override.isNotEmpty) return _override;
    if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
      return 'http://10.0.2.2:8080';
    }
    return 'http://localhost:8080';
  }

  static const String signUp = '/api/v1/auth/signup';
  static const String login = '/api/v1/auth/login';
  static const String me = '/api/v1/auth/me';
}
