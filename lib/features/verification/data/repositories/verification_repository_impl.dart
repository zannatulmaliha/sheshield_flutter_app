import 'dart:typed_data';
import '../../domain/entities/verification_status.dart';
import '../../domain/repositories/i_verification_repository.dart';
import '../datasources/verification_api_datasource.dart';

class VerificationRepositoryImpl implements IVerificationRepository {
  VerificationRepositoryImpl(this._api);
  final VerificationApiDataSource _api;

  @override
  Future<VerificationStatus> fetchStatus() => _api.fetchStatus();

  @override
  Future<VerificationStatus> submit({
    required Uint8List nidFront,
    required Uint8List nidBack,
    required Uint8List selfie,
  }) {
    return _api.submit(nidFront: nidFront, nidBack: nidBack, selfie: selfie);
  }
}