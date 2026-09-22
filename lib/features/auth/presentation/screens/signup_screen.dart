import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sheshield/core/constants/country_dial_codes.dart';
import 'package:sheshield/core/l10n/app_localizations.dart';
import 'package:sheshield/core/theme/app_theme.dart';
import 'package:sheshield/shared/entities/gender.dart';
import 'package:sheshield/shared/entities/user_type.dart';
import '../providers/auth_provider.dart';
import '../widgets/gender_dropdown.dart';
import '../widgets/signup_account_fields.dart';
import '../widgets/user_type_selector.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _phone = TextEditingController();

  CountryDialCode _country = CountryDialCode.bangladesh;
  Gender _gender = Gender.female;
  UserType _userType = UserType.user;

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    _phone.dispose();
    super.dispose();
  }

  /// Only female accounts can choose User, Helper, or Both.
  /// All other genders can only register as a Helper.
  void _onGenderChanged(Gender? value) {
    setState(() {
      _gender = value ?? _gender;

      if (_gender != Gender.female) {
        _userType = UserType.helper;
      }
    });
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    // Defense in depth: only female accounts may use
    // User or User + Helper. All other genders must be Helper.
    final userType =
        _gender == Gender.female ? _userType : UserType.helper;

    ref.read(authControllerProvider.notifier).signUp(
          name: _name.text.trim(),
          email: _email.text.trim(),
          password: _password.text,
          phone: _phone.text.trim(),
          countryCode: _country.dialCode,
          gender: _gender,
          userType: userType,
        );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final authState = ref.watch(authControllerProvider);

    ref.listen(authControllerProvider, (previous, next) {
      next.whenOrNull(
        error: (error, _) => ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error.toString())),
        ),
      );
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.createAccount),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SignupAccountFields(
                  name: _name,
                  email: _email,
                  country: _country,
                  onCountryChanged: (c) => setState(() => _country = c),
                  phone: _phone,
                  password: _password,
                ),
                const SizedBox(height: 8),
                GenderDropdown(
                  value: _gender,
                  onChanged: _onGenderChanged,
                ),
                const SizedBox(height: 16),
                Text(
                  l10n.iWantTo,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 8),
                UserTypeSelector(
                  gender: _gender,
                  value: _userType,
                  onChanged: (v) => setState(() => _userType = v),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: authState.isLoading ? null : _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.accentEmerald,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: authState.isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : Text(l10n.createAccount),
                ),
                TextButton(
                  onPressed: () => context.pop(),
                  child: Text(l10n.alreadyHaveAccount),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
