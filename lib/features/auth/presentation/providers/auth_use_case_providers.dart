import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sheshield/core/di/injection.dart';
import 'package:sheshield/features/auth/domain/usecases/refresh_session_usecase.dart';
import 'package:sheshield/features/auth/domain/usecases/set_discoverable_usecase.dart';
import 'package:sheshield/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:sheshield/features/auth/domain/usecases/sign_out_usecase.dart';
import 'package:sheshield/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:sheshield/features/auth/domain/usecases/update_fcm_token_usecase.dart';
import 'package:sheshield/features/auth/domain/usecases/update_profile_usecase.dart';
import 'package:sheshield/features/auth/domain/usecases/watch_auth_state_usecase.dart';

/// The only bridge between get_it and the widget tree for this feature.
final signInUseCaseProvider = Provider<SignInUseCase>((_) => getIt<SignInUseCase>());

final signUpUseCaseProvider = Provider<SignUpUseCase>((_) => getIt<SignUpUseCase>());

final signOutUseCaseProvider = Provider<SignOutUseCase>((_) => getIt<SignOutUseCase>());

final watchAuthStateUseCaseProvider =
    Provider<WatchAuthStateUseCase>((_) => getIt<WatchAuthStateUseCase>());

final updateProfileUseCaseProvider =
    Provider<UpdateProfileUseCase>((_) => getIt<UpdateProfileUseCase>());

final refreshSessionUseCaseProvider =
    Provider<RefreshSessionUseCase>((_) => getIt<RefreshSessionUseCase>());

final updateFcmTokenUseCaseProvider =
    Provider<UpdateFcmTokenUseCase>((_) => getIt<UpdateFcmTokenUseCase>());

final setDiscoverableUseCaseProvider =
    Provider<SetDiscoverableUseCase>((_) => getIt<SetDiscoverableUseCase>());
