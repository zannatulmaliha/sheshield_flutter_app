import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sheshield/core/di/injection.dart';
import 'package:sheshield/features/contacts/domain/usecases/accept_contact_invite_usecase.dart';
import 'package:sheshield/features/contacts/domain/usecases/add_contact_usecase.dart';
import 'package:sheshield/features/contacts/domain/usecases/get_trusted_contacts_usecase.dart';
import 'package:sheshield/features/contacts/domain/usecases/invite_contact_usecase.dart';
import 'package:sheshield/features/contacts/domain/usecases/remove_contact_usecase.dart';

/// The only bridge between get_it and the widget tree for this feature.
final getTrustedContactsUseCaseProvider =
    Provider<GetTrustedContactsUseCase>((_) => getIt<GetTrustedContactsUseCase>());

final addContactUseCaseProvider =
    Provider<AddContactUseCase>((_) => getIt<AddContactUseCase>());

final removeContactUseCaseProvider =
    Provider<RemoveContactUseCase>((_) => getIt<RemoveContactUseCase>());

final inviteContactUseCaseProvider =
    Provider<InviteContactUseCase>((_) => getIt<InviteContactUseCase>());

final acceptContactInviteUseCaseProvider = Provider<AcceptContactInviteUseCase>(
  (_) => getIt<AcceptContactInviteUseCase>(),
);
