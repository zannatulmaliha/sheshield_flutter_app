import '../../domain/entities/blocked_user.dart';
import '../../domain/entities/report_category.dart';
import '../../domain/repositories/i_report_repository.dart';
import '../datasources/report_api_datasource.dart';

class ReportRepositoryImpl implements IReportRepository {
  ReportRepositoryImpl(this._dataSource);
  final ReportApiDataSource _dataSource;

  @override
  Future<void> file({
    required String reportedId,
    required ReportCategory category,
    required String reporterRole,
    String? sosId,
  }) =>
      _dataSource.file(
        reportedId: reportedId,
        category: category,
        reporterRole: reporterRole,
        sosId: sosId,
      );

  @override
  Future<void> block(String userId) => _dataSource.block(userId);

  @override
  Future<void> unblock(String userId) => _dataSource.unblock(userId);

  @override
  Future<List<BlockedUser>> listBlocks() => _dataSource.listBlocks();
}
