import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:sheshield/core/network/api_envelope.dart';
import 'package:sheshield/core/network/api_failure_mapper.dart';
import 'package:sheshield/core/network/dio_client.dart';
import 'package:sheshield/features/verification/data/models/verification_status_model.dart';

/// The only file that talks to `/api/v1/verification`. Multipart fields
/// `nidFront`, `nidBack`, `selfie`; JSON status response.
class VerificationApiDataSource {
  const VerificationApiDataSource(this._dioClient);

  static const _path = '/verification';

  /// The server decodes three images before answering, so it gets more time
  /// than the default request timeout.
  static const _uploadReceiveTimeout = Duration(seconds: 60);

  final DioClient _dioClient;

  Dio get _dio => _dioClient.dio;

  Future<VerificationStatusModel> fetchVerificationStatus() =>
      guardApiCall(() async {
        final response = await _dio.get<dynamic>(_path);
        return VerificationStatusModel.fromJson(readDataObject(response));
      });

  Future<VerificationStatusModel> submitVerification({
    required Uint8List nidFront,
    required Uint8List nidBack,
    required Uint8List selfie,
  }) =>
      guardApiCall(() async {
        final form = FormData.fromMap({
          'nidFront': MultipartFile.fromBytes(nidFront, filename: 'nid_front.jpg'),
          'nidBack': MultipartFile.fromBytes(nidBack, filename: 'nid_back.jpg'),
          'selfie': MultipartFile.fromBytes(selfie, filename: 'selfie.jpg'),
        });
        final response = await _dio.post<dynamic>(
          _path,
          data: form,
          options: Options(receiveTimeout: _uploadReceiveTimeout),
        );
        return VerificationStatusModel.fromJson(readDataObject(response));
      });
}
