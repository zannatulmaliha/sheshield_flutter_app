import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sheshield/core/di/injection.dart';
import 'package:sheshield/features/chat/domain/usecases/get_responder_state_usecase.dart';
import 'package:sheshield/features/chat/domain/usecases/get_sos_chat_messages_usecase.dart';
import 'package:sheshield/features/chat/domain/usecases/send_sos_chat_message_usecase.dart';

/// The only bridge between get_it and the widget tree for this feature.
final getSosChatMessagesUseCaseProvider = Provider<GetSosChatMessagesUseCase>(
  (_) => getIt<GetSosChatMessagesUseCase>(),
);

final sendSosChatMessageUseCaseProvider = Provider<SendSosChatMessageUseCase>(
  (_) => getIt<SendSosChatMessageUseCase>(),
);

final getResponderStateUseCaseProvider =
    Provider<GetResponderStateUseCase>((_) => getIt<GetResponderStateUseCase>());
