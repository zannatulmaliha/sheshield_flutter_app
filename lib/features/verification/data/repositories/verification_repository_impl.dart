import 'dart:typed_data';

import 'package:sheshield/features/verification/data/datasources/verification_api_datasource.dart';
import 'package:sheshield/features/verification/domain/entities/verification_status.dart';
import 'package:sheshield/features/verification/domain/repositories/verification_repository.dart';

class VerificationRepositoryImpl implements VerificationRepository {
  const VerificationRepositoryImpl(this._apiDataSource);

  final VerificationApiDataSource _apiDataSource;

  @override
  Future<VerificationStatus> fetchVerificationStatus() async =>
      (await _apiDataSource.fetchVerificationStatus()).toEntity();

  @override
  Future<VerificationStatus> submitVerification({
    required Uint8List nidFront,
    required Uint8List nidBack,
    required Uint8List selfie,
  }) async {
    final model = await _apiDataSource.submitVerification(
      nidFront: nidFront,
      nidBack: nidBack,
      selfie: selfie,
    );
    return model.toEntity();
  }
}
