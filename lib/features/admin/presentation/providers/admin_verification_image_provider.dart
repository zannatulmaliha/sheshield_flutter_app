import 'dart:typed_data';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sheshield/features/admin/domain/entities/verification_image_kind.dart';
import 'package:sheshield/features/admin/presentation/providers/admin_use_case_providers.dart';

part 'admin_verification_image_provider.g.dart';

/// Bytes of one uploaded verification photo (empty when unavailable).
@riverpod
class AdminVerificationImageController
    extends _$AdminVerificationImageController {
  @override
  Future<Uint8List> build(String verificationId, VerificationImageKind kind) {
    final getVerificationImage = ref.read(getVerificationImageUseCaseProvider);
    return getVerificationImage(verificationId: verificationId, kind: kind);
  }
}
