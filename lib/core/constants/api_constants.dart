import 'package:flutter/foundation.dart' show kIsWeb;

class ApiConstants {
  ApiConstants._();

  /// Points at the Go backend. Override at build/run time with:
  /// flutter run --dart-define=API_BASE_URL=https://your-server.com/api/v1
  ///
  /// Default assumes a local backend. On web/desktop, "localhost" reaches
  /// the host machine directly. On the Android emulator, "localhost" refers
  /// to the emulator itself, so 10.0.2.2 is used instead — it's the
  /// emulator's alias for the host machine's localhost.
  static const String _defaultBaseUrl = kIsWeb
      ? 'http://localhost:8080/api/v1'
      : 'http://10.0.2.2:8080/api/v1';

  static const String baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: _defaultBaseUrl,
  );
}
