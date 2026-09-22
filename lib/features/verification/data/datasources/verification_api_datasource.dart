import 'package:dio/dio.dart';
import 'package:sheshield/core/network/dio_client.dart';
import '../../domain/entities/verification_status.dart';
import '../../domain/repositories/i_verification_repository.dart';

/// The only file that talks to /api/v1/verification. Matches the Go
/// handler in internal/verification exactly: multipart fields nidFront,
/// nidBack, selfie; JSON status response.
class VerificationApiDataSource {
  VerificationApiDataSource(this._client);
  final DioClient _client;
  static const _path = '/verification';

  Future<VerificationStatus> fetchStatus() async {
    try {
      final res = await _client.dio.get(_path);
      return VerificationStatus.fromJson(res.data['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _fail(e);
    }
  }

  Future<VerificationStatus> submit({
    required List<int> nidFront,
    required List<int> nidBack,
    required List<int> selfie,
  }) async {
    try {
      final form = FormData.fromMap({
        'nidFront': MultipartFile.fromBytes(nidFront, filename: 'nid_front.jpg'),
        'nidBack': MultipartFile.fromBytes(nidBack, filename: 'nid_back.jpg'),
        'selfie': MultipartFile.fromBytes(selfie, filename: 'selfie.jpg'),
      });
      // The server decodes three images before answering; allow more time
      // than the default request timeout.
      final res = await _client.dio.post(
        _path,
        data: form,
        options: Options(receiveTimeout: const Duration(seconds: 60)),
      );
      return VerificationStatus.fromJson(res.data['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _fail(e);
    }
  }

  VerificationFailure _fail(DioException e) {
    final data = e.response?.data;
    final message = (data is Map && data['error'] is String)
        ? data['error'] as String
        : (e.type == DioExceptionType.connectionError || e.type == DioExceptionType.connectionTimeout
            ? 'No internet connection. Please try again.'
            : 'Something went wrong. Please try again.');
    return VerificationFailure(message, unauthorized: e.response?.statusCode == 401);
  }
}