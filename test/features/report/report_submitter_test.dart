import 'package:flutter_test/flutter_test.dart';
import 'package:sheshield/core/error/app_failure.dart';
import 'package:sheshield/features/report/domain/entities/report_category.dart';
import 'package:sheshield/features/report/domain/repositories/report_repository.dart';
import 'package:sheshield/features/report/domain/usecases/block_user_usecase.dart';
import 'package:sheshield/features/report/domain/usecases/file_report_usecase.dart';
import 'package:sheshield/features/report/domain/entities/blocked_user.dart';
import 'package:sheshield/features/report/presentation/providers/report_submitter.dart';

class _FakeReportRepository implements ReportRepository {
  _FakeReportRepository({this.failOnFile = false, this.failOnBlock = false});

  final bool failOnFile;
  final bool failOnBlock;
  final blockedIds = <String>[];

  @override
  Future<void> fileReport({
    required String reportedId,
    required ReportCategory category,
    required String reporterRole,
    String? sosId,
  }) async {
    if (failOnFile) throw const AppFailure(message: 'cannot file');
  }

  @override
  Future<void> blockUser(String userId) async {
    if (failOnBlock) throw const AppFailure(message: 'cannot block');
    blockedIds.add(userId);
  }

  @override
  Future<void> unblockUser(String userId) async {}

  @override
  Future<List<BlockedUser>> fetchBlockedUsers() async => const [];
}

ReportSubmitter _submitterFor(_FakeReportRepository repository) => ReportSubmitter(
      fileReport: FileReportUseCase(repository),
      blockUser: BlockUserUseCase(repository),
    );

Future<List<String>> _submit(_FakeReportRepository repository, {required bool alsoBlock}) =>
    _submitterFor(repository).submit(
      reportedId: 'b',
      category: ReportCategory.harassment,
      reporterRole: 'user',
      alsoBlock: alsoBlock,
    );

void main() {
  test('files the report and does not block unless asked', () async {
    final repository = _FakeReportRepository();
    final messages = await _submit(repository, alsoBlock: false);

    expect(messages, hasLength(1));
    expect(repository.blockedIds, isEmpty);
  });

  test('blocks after a successful report when asked', () async {
    final repository = _FakeReportRepository();
    final messages = await _submit(repository, alsoBlock: true);

    expect(messages, hasLength(2));
    expect(repository.blockedIds, ['b']);
  });

  test('a failed report stops before blocking and surfaces the reason', () async {
    final repository = _FakeReportRepository(failOnFile: true);
    final messages = await _submit(repository, alsoBlock: true);

    expect(messages, ['cannot file']);
    expect(repository.blockedIds, isEmpty);
  });

  test('a failed block is reported but the filed report still stands', () async {
    final repository = _FakeReportRepository(failOnBlock: true);
    final messages = await _submit(repository, alsoBlock: true);

    expect(messages.last, 'cannot block');
    expect(messages.first, startsWith('Report filed'));
  });
}
