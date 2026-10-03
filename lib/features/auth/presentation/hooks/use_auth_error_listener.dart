import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sheshield/core/error/error_message.dart';
import 'package:sheshield/core/utils/context_extensions.dart';
import 'package:sheshield/features/auth/presentation/providers/auth_provider.dart';

/// Shows a snackbar whenever an auth action (sign-in, sign-up, ...) fails.
/// Call once from `build`.
void listenForAuthErrors(BuildContext context, WidgetRef ref) {
  ref.listen(authControllerProvider, (_, next) {
    next.whenOrNull(
      error: (error, _) => context.showMessage(describeErrorForUser(error)),
    );
  });
}
