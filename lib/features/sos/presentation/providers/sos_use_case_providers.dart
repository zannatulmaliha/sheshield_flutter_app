import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sheshield/core/di/injection.dart';
import 'package:sheshield/features/sos/domain/usecases/get_alert_history_usecase.dart';
import 'package:sheshield/features/sos/domain/usecases/get_danger_zones_usecase.dart';
import 'package:sheshield/features/sos/domain/usecases/resolve_sos_alert_usecase.dart';
import 'package:sheshield/features/sos/domain/usecases/send_sos_usecase.dart';
import 'package:sheshield/features/sos/domain/usecases/trigger_duress_usecase.dart';
import 'package:sheshield/features/sos/domain/usecases/update_sos_location_usecase.dart';

/// The only bridge between get_it and the widget tree for this feature.
final sendSosUseCaseProvider =
    Provider<SendSosUseCase>((_) => getIt<SendSosUseCase>());

final updateSosLocationUseCaseProvider =
    Provider<UpdateSosLocationUseCase>((_) => getIt<UpdateSosLocationUseCase>());

final resolveSosAlertUseCaseProvider =
    Provider<ResolveSosAlertUseCase>((_) => getIt<ResolveSosAlertUseCase>());

final getAlertHistoryUseCaseProvider =
    Provider<GetAlertHistoryUseCase>((_) => getIt<GetAlertHistoryUseCase>());

final getDangerZonesUseCaseProvider =
    Provider<GetDangerZonesUseCase>((_) => getIt<GetDangerZonesUseCase>());

final triggerDuressUseCaseProvider =
    Provider<TriggerDuressUseCase>((_) => getIt<TriggerDuressUseCase>());
