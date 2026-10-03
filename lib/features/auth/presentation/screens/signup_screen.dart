import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sheshield/core/constants/country_dial_codes.dart';
import 'package:sheshield/core/l10n/app_localizations.dart';
import 'package:sheshield/core/theme/app_palette.dart';
import 'package:sheshield/features/auth/presentation/hooks/use_auth_error_listener.dart';
import 'package:sheshield/features/auth/presentation/providers/auth_provider.dart';
import 'package:sheshield/features/auth/presentation/widgets/auth_submit_button.dart';
import 'package:sheshield/features/auth/presentation/widgets/gender_dropdown.dart';
import 'package:sheshield/features/auth/presentation/widgets/signup_account_fields.dart';
import 'package:sheshield/features/auth/presentation/widgets/user_type_selector.dart';
import 'package:sheshield/shared/entities/gender.dart';
import 'package:sheshield/shared/entities/user_type.dart';

class SignupScreen extends HookConsumerWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final palette = resolvePalette(context, ref);
    final l10n = AppLocalizations.of(context);
    final formKey = useMemoized(GlobalKey<FormState>.new);
    final nameController = useTextEditingController();
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final phoneController = useTextEditingController();
    final country = useState(CountryDialCode.bangladesh);
    final gender = useState(Gender.female);
    final userType = useState(UserType.user);
    final isSigningUp = ref.watch(authControllerProvider).isLoading;

    listenForAuthErrors(context, ref);

    // Only female accounts can choose User, Helper, or Both; every other
    // gender can only register as a Helper.
    void changeGender(Gender? selected) {
      gender.value = selected ?? gender.value;
      if (gender.value != Gender.female) userType.value = UserType.helper;
    }

    void submit() {
      if (!formKey.currentState!.validate()) return;
      // Defense in depth: re-apply the rule at submit time.
      final effectiveUserType =
          gender.value == Gender.female ? userType.value : UserType.helper;

      ref.read(authControllerProvider.notifier).signUp(
            name: nameController.text.trim(),
            email: emailController.text.trim(),
            password: passwordController.text,
            phone: phoneController.text.trim(),
            countryCode: country.value.dialCode,
            gender: gender.value,
            userType: effectiveUserType,
          );
    }

    return Scaffold(
      backgroundColor: palette.background,
      appBar: AppBar(
        title: Text(l10n.createAccount),
        backgroundColor: palette.background,
        foregroundColor: palette.textPrimary,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SignupAccountFields(
                  name: nameController,
                  email: emailController,
                  country: country.value,
                  onCountryChanged: (selected) => country.value = selected,
                  phone: phoneController,
                  password: passwordController,
                ),
                const SizedBox(height: 8),
                GenderDropdown(value: gender.value, onChanged: changeGender),
                const SizedBox(height: 16),
                Text(
                  l10n.iWantTo,
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 13,
                    color: palette.textPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                UserTypeSelector(
                  gender: gender.value,
                  value: userType.value,
                  onChanged: (selected) => userType.value = selected,
                ),
                const SizedBox(height: 20),
                AuthSubmitButton(
                  label: l10n.createAccount,
                  isLoading: isSigningUp,
                  palette: palette,
                  onPressed: submit,
                ),
                TextButton(
                  onPressed: () => context.pop(),
                  child: Text(
                    l10n.alreadyHaveAccount,
                    style: TextStyle(
                      color: palette.textSecondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
