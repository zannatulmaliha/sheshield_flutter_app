import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sheshield/core/di/injection.dart';
import 'package:sheshield/features/ai/domain/usecases/send_chat_message_usecase.dart';

/// The only bridge between get_it and the widget tree for this feature.
final sendChatMessageUseCaseProvider =
    Provider<SendChatMessageUseCase>((_) => getIt<SendChatMessageUseCase>());
