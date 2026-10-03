import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sheshield/core/di/injection.dart';
import 'package:sheshield/features/settings/domain/usecases/clear_saved_language_usecase.dart';
import 'package:sheshield/features/settings/domain/usecases/get_saved_language_usecase.dart';
import 'package:sheshield/features/settings/domain/usecases/get_saved_theme_mode_usecase.dart';
import 'package:sheshield/features/settings/domain/usecases/save_language_usecase.dart';
import 'package:sheshield/features/settings/domain/usecases/save_theme_mode_usecase.dart';

/// The only bridge between get_it and the widget tree for this feature.
final getSavedLanguageUseCaseProvider =
    Provider<GetSavedLanguageUseCase>((_) => getIt<GetSavedLanguageUseCase>());

final saveLanguageUseCaseProvider =
    Provider<SaveLanguageUseCase>((_) => getIt<SaveLanguageUseCase>());

final clearSavedLanguageUseCaseProvider =
    Provider<ClearSavedLanguageUseCase>((_) => getIt<ClearSavedLanguageUseCase>());

final getSavedThemeModeUseCaseProvider =
    Provider<GetSavedThemeModeUseCase>((_) => getIt<GetSavedThemeModeUseCase>());

final saveThemeModeUseCaseProvider =
    Provider<SaveThemeModeUseCase>((_) => getIt<SaveThemeModeUseCase>());
