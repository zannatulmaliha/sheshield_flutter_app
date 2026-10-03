import 'package:get_it/get_it.dart';
import 'package:sheshield/features/ai/data/datasources/ai_api_datasource.dart';
import 'package:sheshield/features/ai/data/repositories/ai_repository_impl.dart';
import 'package:sheshield/features/ai/domain/repositories/ai_repository.dart';
import 'package:sheshield/features/ai/domain/usecases/send_chat_message_usecase.dart';

void registerAiDependencies(GetIt locator) {
  locator
    ..registerLazySingleton(() => AiApiDataSource(locator()))
    ..registerLazySingleton<AiRepository>(() => AiRepositoryImpl(locator()))
    ..registerLazySingleton(() => SendChatMessageUseCase(locator()));
}
