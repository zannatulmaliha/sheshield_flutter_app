import 'dart:typed_data';
import 'package:dio/dio.dart';
import '../core/network/api_client.dart';
import '../models/verification_info.dart';

/// Thrown by [VerificationService]. [message] is safe to show as-is.
/// [unauthorized] means the login token was rejected, so the app should
/// return to the login screen.
class VerificationException implements Exception {
  const VerificationException(this.message, {this.unauthorized = false});
  final String message;
  final bool unauthorized;

  @override
  String toString() => message;
}

class VerificationService {
  static const _path = '/api/v1/verification';

  final _dio = ApiClient.instance.dio;

  Future<VerificationInfo> status() async {
    try {
      final res = await _dio.get(_path);
      return VerificationInfo.fromJson(res.data['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _fail(e);
    }
  }

  /// Uploads the three photos. The server checks that they really are images
  /// (it doesn't trust the file names below) and records a *pending* request.
  Future<VerificationInfo> submit({
    required Uint8List nidFront,
    required Uint8List nidBack,
    required Uint8List selfie,
  }) async {
    final form = FormData.fromMap({
      'nidFront': MultipartFile.fromBytes(nidFront, filename: 'nid_front.jpg'),
      'nidBack': MultipartFile.fromBytes(nidBack, filename: 'nid_back.jpg'),
      'selfie': MultipartFile.fromBytes(selfie, filename: 'selfie.jpg'),
    });
    try {
      final res = await _dio.post(
        _path,
        data: form,
        // The server has to read and check three photos before it answers.
        options: Options(receiveTimeout: const Duration(seconds: 60)),
      );
      return VerificationInfo.fromJson(res.data['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _fail(e);
    }
  }

  VerificationException _fail(DioException e) => VerificationException(
        ApiClient.messageFromError(e),
        unauthorized: e.response?.statusCode == 401,
      );
}
