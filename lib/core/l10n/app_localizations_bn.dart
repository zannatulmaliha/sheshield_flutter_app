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

  @override
  String get chooseLanguage => 'ভাষা বেছে নিন';

  @override
  String get language => 'ভাষা';

  @override
  String get sendEmergencyAlert => 'জরুরি সতর্কতা পাঠাবেন?';

  @override
  String get sendEmergencyAlertBody =>
      'আপনার বিশ্বস্ত পরিচিতিরা সাথে সাথে আপনার লাইভ অবস্থান ও সাহায্যের কল পাবে।';

  @override
  String get cancel => 'বাতিল';

  @override
  String get sendSos => 'এসওএস পাঠান';

  @override
  String get sosAlertSentTitle => 'সতর্কতা পাঠানো হয়েছে';

  @override
  String get sosNotifiedFallback => 'আপনার জরুরি পরিচিতিদের জানানো হয়েছে।';

  @override
  String sosNotifiedAll(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'সব $count জন পরিচিতিকে জানানো হয়েছে',
      one: '১ জন পরিচিতিকে জানানো হয়েছে',
    );
    return '$_temp0';
  }

  @override
  String sosNotifiedPartial(int sent, int total, int failed) {
    return '$total জনের মধ্যে $sent জনকে জানানো হয়েছে — $failed জনের কাছে পৌঁছানো যায়নি।';
  }

  @override
  String get imSafe => 'আমি নিরাপদ';

  @override
  String greetingHi(String name) {
    return 'হাই, $name 👋';
  }

  @override
  String homeTagline(String gender) {
    String _temp0 = intl.Intl.selectLogic(
      gender,
      {
        'female': 'নিরাপদ থাকুন, আত্মবিশ্বাসী থাকুন',
        'male': 'আপনার প্রিয়জনদের খেয়াল রাখছেন',
        'other': 'শক্ত থাকুন, প্রস্তুত থাকুন',
      },
    );
    return '$_temp0';
  }

  @override
  String get tapForEmergencyAlert => 'জরুরি সতর্কতার জন্য ট্যাপ করুন';

  @override
  String get youAreProtected => 'আপনি সুরক্ষিত আছেন';

  @override
  String liveLocationSharingCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count জন বিশ্বস্ত পরিচিতির সাথে লাইভ অবস্থান শেয়ার চালু আছে',
      one: '১ জন বিশ্বস্ত পরিচিতির সাথে লাইভ অবস্থান শেয়ার চালু আছে',
    );
    return '$_temp0';
  }

  @override
  String get quickActions => 'দ্রুত পদক্ষেপ';

  @override
  String get fakeCall => 'ভুয়া কল';

  @override
  String get shareLocation => 'অবস্থান শেয়ার করুন';

  @override
  String get recordEvidence => 'প্রমাণ রেকর্ড করুন';

  @override
  String get safeRoute => 'নিরাপদ রুট';

  @override
  String get checkInTimer => 'চেক-ইন টাইমার';

  @override
  String get checkInSheetTitle => 'চেক-ইন টাইমার সেট করুন';

  @override
  String get checkInSheetBody =>
      'সময় শেষ হওয়ার আগে চেক-ইন না করলে, আমরা স্বয়ংক্রিয়ভাবে আপনার লাইভ অবস্থানসহ একটি এসওএস আপনার বিশ্বস্ত পরিচিতিদের কাছে পাঠাব।';

  @override
  String checkInStartButton(int minutes) {
    return '$minutes মিনিটের টাইমার শুরু করুন';
  }

  @override
  String get checkInAlreadyRunningTitle => 'চেক-ইন ইতিমধ্যে চলছে';

  @override
  String checkInAlreadyRunningBody(String time) {
    return 'স্বয়ংক্রিয় এসওএস আপনার বিশ্বস্ত পরিচিতিদের কাছে যাওয়ার আগে $time বাকি আছে।';
  }

  @override
  String get checkInImSafeCancel => 'আমি নিরাপদ — বাতিল করুন';

  @override
  String checkInBannerCountdown(String time) {
    return 'স্বয়ংক্রিয় এসওএসের আগে $time বাকি';
  }

  @override
  String get checkInImSafe => 'আমি নিরাপদ';

  @override
  String get checkInSosSentMessage =>
      'আপনি সময়মতো চেক-ইন করেননি — স্বয়ংক্রিয়ভাবে একটি এসওএস পাঠানো হয়েছে।';

  @override
  String get trustedContacts => 'বিশ্বস্ত পরিচিতি';

  @override
  String get seeAll => 'সব দেখুন';

  @override
  String get addContactToEnableSos => 'এসওএস চালু করতে একজন পরিচিতি যোগ করুন';

  @override
  String contactsWillBeAlerted(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count জন পরিচিতিকে সতর্ক করা হবে',
      one: '১ জন পরিচিতিকে সতর্ক করা হবে',
    );
    return '$_temp0';
  }

  @override
  String get profileTitle => 'প্রোফাইল';

  @override
  String get settingsTitle => 'সেটিংস';

  @override
  String get emergencyInfo => 'জরুরি তথ্য';

  @override
  String get phone => 'ফোন';

  @override
  String get role => 'ভূমিকা';

  @override
  String get userTypeUser => 'ব্যবহারকারী';

  @override
  String get userTypeHelper => 'হেল্পার';

  @override
  String get userTypeUserHelper => 'ব্যবহারকারী ও হেল্পার';

  @override
  String get homeAddress => 'বাড়ির ঠিকানা';

  @override
  String get tapToAdd => 'যোগ করতে ট্যাপ করুন';

  @override
  String get notifications => 'নোটিফিকেশন';

  @override
  String get noNotificationsYetTitle => 'এখনো কোনো সতর্কতা নেই';

  @override
  String get noNotificationsYetBody =>
      'আপনার পূর্ববর্তী এসওএস সতর্কতাগুলো এখানে দেখা যাবে।';

  @override
  String get alertStatusActive => 'সক্রিয়';

  @override
  String get alertStatusResolved => 'সমাধান হয়েছে';

  @override
  String get alertStatusAccepted => 'গৃহীত হয়েছে';

  @override
  String get privacyPermissions => 'গোপনীয়তা ও অনুমতি';

  @override
  String get notificationSettings => 'নোটিফিকেশন সেটিংস';

  @override
  String get appTheme => 'অ্যাপ থিম';

  @override
  String get chooseTheme => 'চেহারা নির্বাচন করুন';

  @override
  String get themeSystem => 'সিস্টেম অনুসরণ করুন';

  @override
  String get themeLight => 'লাইট';

  @override
  String get themeDark => 'ডার্ক';

  @override
  String get helpSupport => 'সাহায্য ও সহায়তা';

  @override
  String get logOut => 'লগ আউট';
}
