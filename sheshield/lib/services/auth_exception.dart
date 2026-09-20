/// Thrown by [AuthService]. Screens catch this and show [message] directly
/// — never a raw DioException.
class AuthException implements Exception {
  const AuthException(this.message);
  final String message;

  @override
  String toString() => message;
}
