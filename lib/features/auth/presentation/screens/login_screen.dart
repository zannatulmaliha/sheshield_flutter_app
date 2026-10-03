import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sheshield/core/l10n/app_localizations.dart';
import 'package:sheshield/core/router/app_router.dart';
import 'package:sheshield/core/theme/app_palette.dart';
import 'package:sheshield/features/auth/presentation/hooks/use_auth_error_listener.dart';
import 'package:sheshield/features/auth/presentation/providers/auth_provider.dart';
import 'package:sheshield/features/auth/presentation/widgets/auth_submit_button.dart';
import 'package:sheshield/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:sheshield/features/auth/presentation/widgets/login_brand_header.dart';

class LoginScreen extends HookConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final palette = resolvePalette(context, ref);
    final l10n = AppLocalizations.of(context);
    final formKey = useMemoized(GlobalKey<FormState>.new);
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final isSigningIn = ref.watch(authControllerProvider).isLoading;

    listenForAuthErrors(context, ref);

    void submit() {
      if (!formKey.currentState!.validate()) return;
      ref.read(authControllerProvider.notifier).signIn(
            email: emailController.text.trim(),
            password: passwordController.text,
          );
    }

    return Scaffold(
      backgroundColor: palette.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(28, 40, 28, 24),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  LoginBrandHeader(palette: palette, l10n: l10n),
                  const SizedBox(height: 32),
                  AuthTextField(
                    controller: emailController,
                    label: l10n.email,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) =>
                        (value == null || !value.contains('@')) ? l10n.errorInvalidEmail : null,
                  ),
                  AuthTextField(
                    controller: passwordController,
                    label: l10n.password,
                    obscureText: true,
                    validator: (value) =>
                        (value == null || value.length < 6) ? l10n.errorShortPassword : null,
                  ),
                  const SizedBox(height: 8),
                  AuthSubmitButton(
                    label: l10n.logIn,
                    isLoading: isSigningIn,
                    palette: palette,
                    onPressed: submit,
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: TextButton(
                      onPressed: () => const SignupRoute().push(context),
                      child: Text(
                        l10n.dontHaveAccount,
                        style: TextStyle(
                          color: palette.textSecondary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
