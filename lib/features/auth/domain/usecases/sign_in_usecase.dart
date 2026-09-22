import 'package:sheshield/shared/entities/app_user.dart';
import '../repositories/i_auth_repository.dart';

/// One job: sign an existing user in. Pure Dart — testable with a fake
/// [IAuthRepository], no Firebase or widget involved.
class SignInUseCase {
  const SignInUseCase(this._repository);
  final IAuthRepository _repository;

  Future<AppUser> call({required String email, required String password}) {
    return _repository.signIn(email: email, password: password);
  }
}
