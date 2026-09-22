import 'dart:typed_data';
import '../entities/verification_status.dart';
import '../repositories/i_verification_repository.dart';

class SubmitVerificationUseCase {
  const SubmitVerificationUseCase(this._repository);
  final IVerificationRepository _repository;

  Future<VerificationStatus> call({
    required Uint8List nidFront,
    required Uint8List nidBack,
    required Uint8List selfie,
  }) {
    return _repository.submit(nidFront: nidFront, nidBack: nidBack, selfie: selfie);
  }
}