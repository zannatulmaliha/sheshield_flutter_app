import 'package:get_it/get_it.dart';
import 'package:sheshield/features/contacts/data/datasources/contacts_api_datasource.dart';
import 'package:sheshield/features/contacts/data/repositories/contacts_repository_impl.dart';
import 'package:sheshield/features/contacts/domain/repositories/contacts_repository.dart';
import 'package:sheshield/features/contacts/domain/usecases/accept_contact_invite_usecase.dart';
import 'package:sheshield/features/contacts/domain/usecases/add_contact_usecase.dart';
import 'package:sheshield/features/contacts/domain/usecases/get_trusted_contacts_usecase.dart';
import 'package:sheshield/features/contacts/domain/usecases/invite_contact_usecase.dart';
import 'package:sheshield/features/contacts/domain/usecases/remove_contact_usecase.dart';

void registerContactsDependencies(GetIt locator) {
  locator
    ..registerLazySingleton(() => ContactsApiDataSource(locator()))
    ..registerLazySingleton<ContactsRepository>(
      () => ContactsRepositoryImpl(locator(), locator()),
    )
    ..registerLazySingleton(() => GetTrustedContactsUseCase(locator()))
    ..registerLazySingleton(() => AddContactUseCase(locator()))
    ..registerLazySingleton(() => RemoveContactUseCase(locator()))
    ..registerLazySingleton(() => InviteContactUseCase(locator()))
    ..registerLazySingleton(() => AcceptContactInviteUseCase(locator()));
}
