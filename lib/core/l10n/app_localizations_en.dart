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

  @override
  String get chooseLanguage => 'Choose language';

  @override
  String get language => 'Language';

  @override
  String get sendEmergencyAlert => 'Send Emergency Alert?';

  @override
  String get sendEmergencyAlertBody =>
      'Your trusted contacts will get your live location and a call for help immediately.';

  @override
  String get cancel => 'Cancel';

  @override
  String get sendSos => 'Send SOS';

  @override
  String get sosAlertSentTitle => 'Alert Sent';

  @override
  String get sosNotifiedFallback =>
      'Your emergency contacts have been notified.';

  @override
  String sosNotifiedAll(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'All $count contacts were notified',
      one: '1 contact was notified',
    );
    return '$_temp0';
  }

  @override
  String sosNotifiedPartial(int sent, int total, int failed) {
    return 'Notified $sent of $total contacts — $failed failed to reach.';
  }

  @override
  String get imSafe => 'I\'m Safe';

  @override
  String greetingHi(String name) {
    return 'Hi, $name 👋';
  }

  @override
  String homeTagline(String gender) {
    String _temp0 = intl.Intl.selectLogic(
      gender,
      {
        'female': 'Stay safe, stay confident',
        'male': 'Watching out for the people you love',
        'other': 'Stay strong, stay ready',
      },
    );
    return '$_temp0';
  }

  @override
  String get tapForEmergencyAlert => 'Tap for Emergency Alert';

  @override
  String get youAreProtected => 'You\'re Protected';

  @override
  String liveLocationSharingCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Live location sharing is ON for $count trusted contacts',
      one: 'Live location sharing is ON for 1 trusted contact',
    );
    return '$_temp0';
  }

  @override
  String get quickActions => 'Quick Actions';

  @override
  String get fakeCall => 'Fake Call';

  @override
  String get shareLocation => 'Share Location';

  @override
  String get recordEvidence => 'Record Evidence';

  @override
  String get safeRoute => 'Safe Route';

  @override
  String get trustedContacts => 'Trusted Contacts';

  @override
  String get seeAll => 'See all';

  @override
  String get addContactToEnableSos => 'Add a contact to enable SOS';

  @override
  String contactsWillBeAlerted(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count contacts will be alerted',
      one: '1 contact will be alerted',
    );
    return '$_temp0';
  }

  @override
  String get profileTitle => 'Profile';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get emergencyInfo => 'Emergency Info';

  @override
  String get phone => 'Phone';

  @override
  String get role => 'Role';

  @override
  String get userTypeUser => 'User';

  @override
  String get userTypeHelper => 'Helper';

  @override
  String get userTypeUserHelper => 'User & Helper';

  @override
  String get homeAddress => 'Home Address';

  @override
  String get tapToAdd => 'Tap to add';

  @override
  String get privacyPermissions => 'Privacy & Permissions';

  @override
  String get notificationSettings => 'Notification Settings';

  @override
  String get appTheme => 'App Theme';

  @override
  String get helpSupport => 'Help & Support';

  @override
  String get logOut => 'Log Out';
}
