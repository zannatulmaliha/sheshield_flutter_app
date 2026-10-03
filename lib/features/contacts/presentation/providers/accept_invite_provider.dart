import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sheshield/features/contacts/presentation/providers/contacts_use_case_providers.dart';

part 'accept_invite_provider.g.dart';

/// State of redeeming an invite code: `false` until it succeeds, then
/// `true`; loading and error come from the [AsyncValue] itself.
@riverpod
class AcceptInviteController extends _$AcceptInviteController {
  @override
  FutureOr<bool> build() => false;

  Future<void> acceptCode(String code) async {
    final acceptContactInvite = ref.read(acceptContactInviteUseCaseProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await acceptContactInvite(code);
      return true;
    });
  }
}
