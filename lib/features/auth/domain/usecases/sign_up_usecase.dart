import 'package:sheshield/features/auth/domain/repositories/auth_repository.dart';
import 'package:sheshield/shared/entities/app_user.dart';
import 'package:sheshield/shared/entities/gender.dart';
import 'package:sheshield/shared/entities/user_type.dart';

class SignUpUseCase {
  const SignUpUseCase(this._authRepository);

  final AuthRepository _authRepository;

  Future<AppUser> call({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String countryCode,
    required Gender gender,
    required UserType userType,
  }) =>
      _authRepository.signUp(
        name: name,
        email: email,
        password: password,
        phone: phone,
        countryCode: countryCode,
        gender: gender,
        userType: userType,
      );
}
