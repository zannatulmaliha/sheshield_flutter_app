import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sheshield/core/di/injection.dart';
import 'package:sheshield/features/user/domain/usecases/get_ai_mode_settings_usecase.dart';
import 'package:sheshield/features/user/domain/usecases/save_ai_mode_settings_usecase.dart';

/// The only bridge between get_it and the widget tree for this feature.
final getAiModeSettingsUseCaseProvider =
    Provider<GetAiModeSettingsUseCase>((_) => getIt<GetAiModeSettingsUseCase>());

final saveAiModeSettingsUseCaseProvider =
    Provider<SaveAiModeSettingsUseCase>((_) => getIt<SaveAiModeSettingsUseCase>());
