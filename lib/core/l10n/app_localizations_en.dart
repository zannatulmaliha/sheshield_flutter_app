// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'SheShield';

  @override
  String get welcomeBack => 'Welcome back';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get confirmPassword => 'Confirm password';

  @override
  String get logIn => 'Log In';

  @override
  String get createAccount => 'Create Account';

  @override
  String get dontHaveAccount => 'Don\'t have an account? Sign up';

  @override
  String get alreadyHaveAccount => 'Already have an account? Log in';

  @override
  String get fullName => 'Full name';

  @override
  String get phoneNumber => 'Phone number';

  @override
  String get countryCode => 'Code';

  @override
  String get gender => 'Gender';

  @override
  String get genderFemale => 'Female';

  @override
  String get genderMale => 'Male';

  @override
  String get genderOther => 'Other';

  @override
  String get genderPreferNotToSay => 'Prefer not to say';

  @override
  String get errorInvalidEmail => 'Enter a valid email';

  @override
  String get errorShortPassword => 'Minimum 6 characters';

  @override
  String get errorInvalidPhone => 'Enter a valid phone number';

  @override
  String get errorGeneric => 'Something went wrong. Please try again.';

  @override
  String get iWantTo => 'I want to';

  @override
  String get country => 'Country';

  @override
  String get selectCountry => 'Select country';

  @override
  String get roleAskForHelp => 'Ask for help';

  @override
  String get roleRespondToAlerts => 'Respond to alerts';

  @override
  String get roleBoth => 'Both';

  @override
  String onlyRoleAvailable(String role) {
    return '$role — the only role available for this account';
  }

  @override
  String get helperDashboard => 'Helper Dashboard';

  @override
  String nearbyAlertsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count alerts nearby',
      one: '1 alert nearby',
      zero: 'No active alerts nearby',
    );
    return '$_temp0';
  }
}
