import 'dart:typed_data';

import 'package:sheshield/features/verification/domain/entities/verification_status.dart';

/// Contract the presentation layer depends on. Failures surface as
/// `AppFailure`; no Dio type appears here.
abstract interface class VerificationRepository {
  Future<VerificationStatus> fetchVerificationStatus();

  /// The server decodes and validates each photo itself (real image, under
  /// 5 MB, sensible dimensions); this only uploads the raw bytes.
  Future<VerificationStatus> submitVerification({
    required Uint8List nidFront,
    required Uint8List nidBack,
    required Uint8List selfie,
  });
}
