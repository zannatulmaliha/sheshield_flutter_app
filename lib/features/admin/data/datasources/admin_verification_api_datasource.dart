import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:sheshield/core/network/api_envelope.dart';
import 'package:sheshield/features/admin/data/datasources/admin_api_client.dart';
import 'package:sheshield/features/admin/data/models/admin_verification_model.dart';
import 'package:sheshield/features/admin/domain/entities/verification_image_kind.dart';

/// Helper identity-verification endpoints.
class AdminVerificationApiDataSource {
  const AdminVerificationApiDataSource(this._apiClient);

  final AdminApiClient _apiClient;

  Future<List<AdminVerificationModel>> fetchVerificationQueue() =>
      _apiClient.guard(() async {
        final response = await _apiClient.dio.get<dynamic>(
          '/admin/verifications',
          options: await _apiClient.authorizedOptions(),
        );
        return readDataList(response).map(AdminVerificationModel.fromJson).toList();
      });

  Future<AdminVerificationModel> fetchVerificationDetail(String verificationId) =>
      _apiClient.guard(() async {
        final response = await _apiClient.dio.get<dynamic>(
          '/admin/verifications/$verificationId',
          options: await _apiClient.authorizedOptions(),
        );
        return AdminVerificationModel.fromJson(readDataObject(response));
      });

  Future<Uint8List> fetchVerificationImage({
    required String verificationId,
    required VerificationImageKind kind,
  }) =>
      _apiClient.guard(() async {
        final response = await _apiClient.dio.get<List<int>>(
          '/admin/verifications/$verificationId/images/${kind.pathSegment}',
          options: await _apiClient.authorizedOptions(
            Options(responseType: ResponseType.bytes),
          ),
        );
        return Uint8List.fromList(response.data ?? const <int>[]);
      });

  Future<void> decideVerification({
    required String verificationId,
    required bool approved,
    required String note,
    String? reviewerName,
  }) =>
      _apiClient.guard(
        () async => _apiClient.dio.post<dynamic>(
          '/admin/verifications/$verificationId/decision',
          options: await _apiClient.authorizedOptions(),
          data: {
            'approved': approved,
            'note': note,
            if (reviewerName != null && reviewerName.isNotEmpty)
              'reviewerName': reviewerName,
          },
        ),
      );
}
