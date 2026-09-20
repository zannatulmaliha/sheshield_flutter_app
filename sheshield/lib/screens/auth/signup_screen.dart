import 'package:flutter/material.dart';
import '../../models/gender.dart';
import '../../models/user_type.dart';
import '../../services/auth_controller.dart';
import '../../theme/app_theme.dart';
import '../../widgets/auth/auth_text_field.dart';
import '../../widgets/auth/gender_dropdown.dart';
import '../../widgets/auth/role_selector.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key, required this.controller});

  final AuthController controller;

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _phone = TextEditingController();
  final _countryCode = TextEditingController(text: '+880');

  Gender _gender = Gender.female;
  UserType _userType = UserType.user;

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    _phone.dispose();
    _countryCode.dispose();
    super.dispose();
  }

  void _onGenderChanged(Gender? g) {
    if (g == null) return;
    setState(() {
      _gender = g;
      // Keep _userType valid whenever gender changes — e.g. switching away
      // from female must fall back to the only allowed option, Helper.
      final allowed = allowedUserTypesFor(g);
      if (!allowed.contains(_userType)) {
        _userType = allowed.first;
      }
    });
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    final ok = await widget.controller.signUp(
      name: _name.text.trim(),
      email: _email.text.trim(),
      password: _password.text,
      phone: _phone.text.trim(),
      countryCode: _countryCode.text.trim(),
      gender: _gender,
      userType: _userType,
    );
    if (!mounted) return;
    if (ok) {
      // AuthController just flipped to signedIn, so the app's `home` is now
      // the main app -- but this screen was pushed ON TOP of the login
      // screen and stays on the stack until we remove it.
      Navigator.of(context).popUntil((route) => route.isFirst);
    } else if (widget.controller.errorMessage != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(widget.controller.errorMessage!)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Create Account'),
      ),
      body: SafeArea(
        child: AnimatedBuilder(
          animation: widget.controller,
          builder: (context, _) {
            return SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 4, 24, 24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    AuthTextField(
                      controller: _name,
                      label: 'Full name',
                      validator: (v) =>
                          (v == null || v.trim().isEmpty) ? 'Enter your name' : null,
                    ),
                    AuthTextField(
                      controller: _email,
                      label: 'Email',
                      keyboardType: TextInputType.emailAddress,
                      validator: (v) =>
                          (v == null || !v.contains('@')) ? 'Enter a valid email' : null,
                    ),
                    AuthTextField(
                      controller: _password,
                      label: 'Password',
                      obscureText: true,
                      validator: (v) => (v == null || v.length < 6)
                          ? 'At least 6 characters'
                          : null,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 90,
                          child: AuthTextField(controller: _countryCode, label: 'Code'),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: AuthTextField(
                            controller: _phone,
                            label: 'Phone number',
                            keyboardType: TextInputType.phone,
                            validator: (v) =>
                                (v == null || v.trim().isEmpty) ? 'Enter your phone' : null,
                          ),
                        ),
                      ],
                    ),
                    GenderDropdown(value: _gender, onChanged: _onGenderChanged),
                    const Text(
                      'Sign up as',
                      style: TextStyle(fontWeight: FontWeight.w800, fontSize: 13, color: AppColors.textPrimary),
                    ),
                    const SizedBox(height: 10),
                    RoleSelector(
                      gender: _gender,
                      value: _userType,
                      onChanged: (t) => setState(() => _userType = t),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      onPressed: widget.controller.isSubmitting ? null : _submit,
                      child: widget.controller.isSubmitting
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(strokeWidth: 2.4, color: Colors.white),
                            )
                          : const Text('Create Account', style: TextStyle(fontWeight: FontWeight.w800)),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
