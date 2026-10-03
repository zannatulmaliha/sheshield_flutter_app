import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sheshield/core/di/injection.dart';
import 'package:sheshield/features/verification/domain/usecases/get_verification_status_usecase.dart';
import 'package:sheshield/features/verification/domain/usecases/submit_verification_usecase.dart';

/// The only bridge between get_it and the widget tree for this feature.
final getVerificationStatusUseCaseProvider = Provider<GetVerificationStatusUseCase>(
  (_) => getIt<GetVerificationStatusUseCase>(),
);

final submitVerificationUseCaseProvider =
    Provider<SubmitVerificationUseCase>((_) => getIt<SubmitVerificationUseCase>());
