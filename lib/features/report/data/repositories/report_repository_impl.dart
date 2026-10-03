import 'package:sheshield/features/report/data/datasources/report_api_datasource.dart';
import 'package:sheshield/features/report/domain/entities/blocked_user.dart';
import 'package:sheshield/features/report/domain/entities/report_category.dart';
import 'package:sheshield/features/report/domain/repositories/report_repository.dart';

class ReportRepositoryImpl implements ReportRepository {
  const ReportRepositoryImpl(this._apiDataSource);

  final ReportApiDataSource _apiDataSource;

  @override
  Future<void> fileReport({
    required String reportedId,
    required ReportCategory category,
    required String reporterRole,
    String? sosId,
  }) =>
      _apiDataSource.fileReport(
        reportedId: reportedId,
        category: category,
        reporterRole: reporterRole,
        sosId: sosId,
      );

  @override
  Future<void> blockUser(String userId) => _apiDataSource.blockUser(userId);

  @override
  Future<void> unblockUser(String userId) => _apiDataSource.unblockUser(userId);

  @override
  Future<List<BlockedUser>> fetchBlockedUsers() async {
    final models = await _apiDataSource.fetchBlockedUsers();
    return models.map((model) => model.toEntity()).toList();
  }
}
