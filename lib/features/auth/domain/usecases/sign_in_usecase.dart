import 'package:sheshield/features/auth/domain/repositories/auth_repository.dart';
import 'package:sheshield/shared/entities/app_user.dart';

/// One job: sign an existing user in. Pure Dart, testable with a fake
/// repository and no widget involved.
class SignInUseCase {
  const SignInUseCase(this._authRepository);

  final AuthRepository _authRepository;

  Future<AppUser> call({required String email, required String password}) =>
      _authRepository.signIn(email: email, password: password);
}
