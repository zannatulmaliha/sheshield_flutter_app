import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sheshield/core/di/injection.dart';
import 'package:sheshield/features/helper/domain/usecases/accept_alert_usecase.dart';
import 'package:sheshield/features/helper/domain/usecases/get_current_response_usecase.dart';
import 'package:sheshield/features/helper/domain/usecases/get_helper_history_usecase.dart';
import 'package:sheshield/features/helper/domain/usecases/get_helper_stats_usecase.dart';
import 'package:sheshield/features/helper/domain/usecases/get_helper_status_usecase.dart';
import 'package:sheshield/features/helper/domain/usecases/get_live_state_usecase.dart';
import 'package:sheshield/features/helper/domain/usecases/get_nearby_alerts_usecase.dart';
import 'package:sheshield/features/helper/domain/usecases/release_alert_usecase.dart';
import 'package:sheshield/features/helper/domain/usecases/resolve_alert_usecase.dart';
import 'package:sheshield/features/helper/domain/usecases/set_helper_status_usecase.dart';
import 'package:sheshield/features/helper/domain/usecases/set_response_stage_usecase.dart';

/// The only bridge between get_it and the widget tree for this feature.
final getHelperStatusUseCaseProvider =
    Provider<GetHelperStatusUseCase>((_) => getIt<GetHelperStatusUseCase>());

final setHelperStatusUseCaseProvider =
    Provider<SetHelperStatusUseCase>((_) => getIt<SetHelperStatusUseCase>());

final getNearbyAlertsUseCaseProvider =
    Provider<GetNearbyAlertsUseCase>((_) => getIt<GetNearbyAlertsUseCase>());

final acceptAlertUseCaseProvider =
    Provider<AcceptAlertUseCase>((_) => getIt<AcceptAlertUseCase>());

final releaseAlertUseCaseProvider =
    Provider<ReleaseAlertUseCase>((_) => getIt<ReleaseAlertUseCase>());

final getCurrentResponseUseCaseProvider =
    Provider<GetCurrentResponseUseCase>((_) => getIt<GetCurrentResponseUseCase>());

final getLiveStateUseCaseProvider =
    Provider<GetLiveStateUseCase>((_) => getIt<GetLiveStateUseCase>());

final setResponseStageUseCaseProvider =
    Provider<SetResponseStageUseCase>((_) => getIt<SetResponseStageUseCase>());

final resolveAlertUseCaseProvider =
    Provider<ResolveAlertUseCase>((_) => getIt<ResolveAlertUseCase>());

final getHelperStatsUseCaseProvider =
    Provider<GetHelperStatsUseCase>((_) => getIt<GetHelperStatsUseCase>());

final getHelperHistoryUseCaseProvider =
    Provider<GetHelperHistoryUseCase>((_) => getIt<GetHelperHistoryUseCase>());
