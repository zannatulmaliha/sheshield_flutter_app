import 'dart:typed_data';

import 'package:sheshield/features/verification/domain/entities/verification_status.dart';
import 'package:sheshield/features/verification/domain/repositories/verification_repository.dart';

class SubmitVerificationUseCase {
  const SubmitVerificationUseCase(this._verificationRepository);

  final VerificationRepository _verificationRepository;

  Future<VerificationStatus> call({
    required Uint8List nidFront,
    required Uint8List nidBack,
    required Uint8List selfie,
  }) =>
      _verificationRepository.submitVerification(
        nidFront: nidFront,
        nidBack: nidBack,
        selfie: selfie,
      );
}
