// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Bengali Bangla (`bn`).
class AppLocalizationsBn extends AppLocalizations {
  AppLocalizationsBn([String locale = 'bn']) : super(locale);

  @override
  String get appName => 'শী শিল্ড';

  @override
  String get welcomeBack => 'আবার স্বাগতম';

  @override
  String get email => 'ইমেইল';

  @override
  String get password => 'পাসওয়ার্ড';

  @override
  String get confirmPassword => 'পাসওয়ার্ড নিশ্চিত করুন';

  @override
  String get logIn => 'লগ ইন';

  @override
  String get createAccount => 'অ্যাকাউন্ট তৈরি করুন';

  @override
  String get dontHaveAccount => 'অ্যাকাউন্ট নেই? সাইন আপ করুন';

  @override
  String get alreadyHaveAccount => 'অ্যাকাউন্ট আছে? লগ ইন করুন';

  @override
  String get fullName => 'পুরো নাম';

  @override
  String get phoneNumber => 'ফোন নম্বর';

  @override
  String get countryCode => 'কোড';

  @override
  String get gender => 'লিঙ্গ';

  @override
  String get genderFemale => 'নারী';

  @override
  String get genderMale => 'পুরুষ';

  @override
  String get genderOther => 'অন্যান্য';

  @override
  String get genderPreferNotToSay => 'বলতে ইচ্ছুক নই';

  @override
  String get errorInvalidEmail => 'একটি সঠিক ইমেইল দিন';

  @override
  String get errorShortPassword => 'কমপক্ষে ৬ অক্ষর';

  @override
  String get errorInvalidPhone => 'একটি সঠিক ফোন নম্বর দিন';

  @override
  String get errorGeneric => 'কিছু ভুল হয়েছে। আবার চেষ্টা করুন।';

  @override
  String get iWantTo => 'আমি চাই';

  @override
  String get country => 'দেশ';

  @override
  String get selectCountry => 'দেশ নির্বাচন করুন';

  @override
  String get roleAskForHelp => 'সাহায্য চাই';

  @override
  String get roleRespondToAlerts => 'অ্যালার্টে সাড়া দিন';

  @override
  String get roleBoth => 'উভয়';

  @override
  String onlyRoleAvailable(String role) {
    return '$role — এই অ্যাকাউন্টের জন্য একমাত্র উপলব্ধ ভূমিকা';
  }

  @override
  String get helperDashboard => 'হেল্পার ড্যাশবোর্ড';

  @override
  String nearbyAlertsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'কাছাকাছি $countটি অ্যালার্ট',
      one: 'কাছাকাছি ১টি অ্যালার্ট',
      zero: 'কাছাকাছি কোনো সক্রিয় অ্যালার্ট নেই',
    );
    return '$_temp0';
  }
}
