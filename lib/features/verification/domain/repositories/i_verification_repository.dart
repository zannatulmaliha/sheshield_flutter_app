import 'dart:typed_data';
import '../entities/verification_status.dart';

/// Contract the presentation layer depends on. No Dio type appears here --
/// data/ translates transport errors into [VerificationFailure].
abstract class IVerificationRepository {
  Future<VerificationStatus> fetchStatus();

  /// The server decodes and validates each photo itself (real image, under
  /// 5 MB, sensible dimensions) -- this only uploads the raw bytes.
  Future<VerificationStatus> submit({
    required Uint8List nidFront,
    required Uint8List nidBack,
    required Uint8List selfie,
  });
}

class VerificationFailure implements Exception {
  const VerificationFailure(this.message, {this.unauthorized = false});
  final String message;
  final bool unauthorized;

  @override
  String toString() => message;
}