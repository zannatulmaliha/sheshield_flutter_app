import 'package:flutter/material.dart';
import 'package:sheshield/core/constants/country_dial_codes.dart';
import 'package:sheshield/core/l10n/app_localizations.dart';
import 'auth_text_field.dart';
import 'country_code_picker.dart';

/// The name/email/phone/password block of the signup form, split out
/// so signup_screen.dart stays under the project's 150-line limit.
class SignupAccountFields extends StatelessWidget {
  const SignupAccountFields({
    super.key,
    required this.name,
    required this.email,
    required this.country,
    required this.onCountryChanged,
    required this.phone,
    required this.password,
  });

  final TextEditingController name;
  final TextEditingController email;
  final CountryDialCode country;
  final ValueChanged<CountryDialCode> onCountryChanged;
  final TextEditingController phone;
  final TextEditingController password;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AuthTextField(
          controller: name,
          label: l10n.fullName,
          validator: (v) => (v == null || v.trim().isEmpty) ? l10n.errorInvalidEmail : null,
        ),
        AuthTextField(
          controller: email,
          label: l10n.email,
          keyboardType: TextInputType.emailAddress,
          validator: (v) => (v == null || !v.contains('@')) ? l10n.errorInvalidEmail : null,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CountryCodePicker(value: country, onChanged: onCountryChanged),
              const SizedBox(width: 10),
              Expanded(
                child: TextFormField(
                  controller: phone,
                  keyboardType: TextInputType.phone,
                  style: const TextStyle(color: Colors.white),
                  // The dial code is picked separately, so this field
                  // only ever holds the national number -- its length
                  // is validated against the *selected* country, not
                  // one hardcoded rule for every market.
                  validator: (v) {
                    final digits = (v ?? '').replaceAll(RegExp(r'\D'), '');
                    return country.isValidLocalNumber(digits) ? null : l10n.errorInvalidPhone;
                  },
                  decoration: InputDecoration(
                    labelText: l10n.phoneNumber,
                    labelStyle: TextStyle(color: Colors.white.withValues(alpha: 0.6)),
                    filled: true,
                    fillColor: Colors.white.withValues(alpha: 0.06),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        AuthTextField(
          controller: password,
          label: l10n.password,
          obscureText: true,
          validator: (v) => (v == null || v.length < 6) ? l10n.errorShortPassword : null,
        ),
      ],
    );
  }
}
