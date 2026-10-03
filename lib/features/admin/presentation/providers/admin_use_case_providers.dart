import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sheshield/core/di/injection.dart';
import 'package:sheshield/features/admin/domain/usecases/clear_admin_key_usecase.dart';
import 'package:sheshield/features/admin/domain/usecases/decide_verification_usecase.dart';
import 'package:sheshield/features/admin/domain/usecases/get_report_detail_usecase.dart';
import 'package:sheshield/features/admin/domain/usecases/get_report_queue_usecase.dart';
import 'package:sheshield/features/admin/domain/usecases/get_verification_detail_usecase.dart';
import 'package:sheshield/features/admin/domain/usecases/get_verification_image_usecase.dart';
import 'package:sheshield/features/admin/domain/usecases/get_verification_queue_usecase.dart';
import 'package:sheshield/features/admin/domain/usecases/has_admin_key_usecase.dart';
import 'package:sheshield/features/admin/domain/usecases/review_report_usecase.dart';
import 'package:sheshield/features/admin/domain/usecases/save_admin_key_usecase.dart';
import 'package:sheshield/features/admin/domain/usecases/suspend_helper_usecase.dart';

/// The only bridge between get_it and the widget tree for this feature.
final hasAdminKeyUseCaseProvider =
    Provider<HasAdminKeyUseCase>((_) => getIt<HasAdminKeyUseCase>());

final saveAdminKeyUseCaseProvider =
    Provider<SaveAdminKeyUseCase>((_) => getIt<SaveAdminKeyUseCase>());

final clearAdminKeyUseCaseProvider =
    Provider<ClearAdminKeyUseCase>((_) => getIt<ClearAdminKeyUseCase>());

final getReportQueueUseCaseProvider =
    Provider<GetReportQueueUseCase>((_) => getIt<GetReportQueueUseCase>());

final getReportDetailUseCaseProvider =
    Provider<GetReportDetailUseCase>((_) => getIt<GetReportDetailUseCase>());

final reviewReportUseCaseProvider =
    Provider<ReviewReportUseCase>((_) => getIt<ReviewReportUseCase>());

final suspendHelperUseCaseProvider =
    Provider<SuspendHelperUseCase>((_) => getIt<SuspendHelperUseCase>());

final getVerificationQueueUseCaseProvider = Provider<GetVerificationQueueUseCase>(
  (_) => getIt<GetVerificationQueueUseCase>(),
);

final getVerificationDetailUseCaseProvider = Provider<GetVerificationDetailUseCase>(
  (_) => getIt<GetVerificationDetailUseCase>(),
);

final getVerificationImageUseCaseProvider = Provider<GetVerificationImageUseCase>(
  (_) => getIt<GetVerificationImageUseCase>(),
);

final decideVerificationUseCaseProvider = Provider<DecideVerificationUseCase>(
  (_) => getIt<DecideVerificationUseCase>(),
);
