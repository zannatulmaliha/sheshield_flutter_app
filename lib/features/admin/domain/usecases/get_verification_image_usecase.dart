import 'dart:typed_data';

import 'package:sheshield/features/admin/domain/entities/verification_image_kind.dart';
import 'package:sheshield/features/admin/domain/repositories/admin_repository.dart';

class GetVerificationImageUseCase {
  const GetVerificationImageUseCase(this._adminRepository);

  final AdminRepository _adminRepository;

  Future<Uint8List> call({
    required String verificationId,
    required VerificationImageKind kind,
  }) =>
      _adminRepository.fetchVerificationImage(
        verificationId: verificationId,
        kind: kind,
      );
}
