/// Thrown by [AuthService]. Screens catch this and show [message] directly
/// — never a raw DioException.
class AuthException implements Exception {
  const AuthException(this.message, {this.unauthorized = false});
  final String message;

  /// The server rejected the login token (expired or invalid), as opposed to
  /// the request itself being wrong. The app should return to the login screen.
  final bool unauthorized;

  @override
  String toString() => message;
}
