class ApiConstants {
  ApiConstants._();

  /// Points at the Go backend. Override at build/run time with:
  /// flutter run --dart-define=API_BASE_URL=https://your-server.com/api/v1
  ///
  /// Default assumes a local backend reached from the Android emulator —
  /// 10.0.2.2 is the emulator's alias for the host machine's localhost
  /// (plain "localhost" inside the emulator refers to the emulator itself).
  static const String baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://10.0.2.2:8080/api/v1',
  );
}
