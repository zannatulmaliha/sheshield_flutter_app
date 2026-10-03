import 'package:get_it/get_it.dart';
import 'package:sheshield/features/chat/data/datasources/sos_chat_api_datasource.dart';
import 'package:sheshield/features/chat/data/repositories/sos_chat_repository_impl.dart';
import 'package:sheshield/features/chat/domain/repositories/sos_chat_repository.dart';
import 'package:sheshield/features/chat/domain/usecases/get_responder_state_usecase.dart';
import 'package:sheshield/features/chat/domain/usecases/get_sos_chat_messages_usecase.dart';
import 'package:sheshield/features/chat/domain/usecases/send_sos_chat_message_usecase.dart';

void registerChatDependencies(GetIt locator) {
  locator
    ..registerLazySingleton(() => SosChatApiDataSource(locator()))
    ..registerLazySingleton<SosChatRepository>(() => SosChatRepositoryImpl(locator()))
    ..registerLazySingleton(() => GetSosChatMessagesUseCase(locator()))
    ..registerLazySingleton(() => SendSosChatMessageUseCase(locator()))
    ..registerLazySingleton(() => GetResponderStateUseCase(locator()));
}
