import 'package:sheshield/features/admin/domain/repositories/admin_repository.dart';

class HasAdminKeyUseCase {
  const HasAdminKeyUseCase(this._adminRepository);

  final AdminRepository _adminRepository;

  Future<bool> call() => _adminRepository.hasAdminKey();
}
