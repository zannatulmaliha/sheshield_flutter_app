import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sheshield/core/di/injection.dart';
import 'package:sheshield/features/report/domain/usecases/block_user_usecase.dart';
import 'package:sheshield/features/report/domain/usecases/file_report_usecase.dart';
import 'package:sheshield/features/report/domain/usecases/list_blocked_users_usecase.dart';
import 'package:sheshield/features/report/domain/usecases/unblock_user_usecase.dart';

/// The only bridge between get_it and the widget tree for this feature.
/// Widgets and controllers read these providers, so tests can override a
/// use case without touching the service locator.
final fileReportUseCaseProvider =
    Provider<FileReportUseCase>((_) => getIt<FileReportUseCase>());

final blockUserUseCaseProvider =
    Provider<BlockUserUseCase>((_) => getIt<BlockUserUseCase>());

final unblockUserUseCaseProvider =
    Provider<UnblockUserUseCase>((_) => getIt<UnblockUserUseCase>());

final listBlockedUsersUseCaseProvider =
    Provider<ListBlockedUsersUseCase>((_) => getIt<ListBlockedUsersUseCase>());
