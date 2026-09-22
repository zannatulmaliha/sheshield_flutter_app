import 'package:sheshield/shared/entities/app_user.dart';
import 'package:sheshield/shared/entities/gender.dart';
import 'package:sheshield/shared/entities/user_type.dart';
import '../repositories/i_auth_repository.dart';

class SignUpUseCase {
  const SignUpUseCase(this._repository);
  final IAuthRepository _repository;

  Future<AppUser> call({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String countryCode,
    required Gender gender,
    required UserType userType,
  }) {
    return _repository.signUp(
      name: name,
      email: email,
      password: password,
      phone: phone,
      countryCode: countryCode,
      gender: gender,
      userType: userType,
    );
  }
}
