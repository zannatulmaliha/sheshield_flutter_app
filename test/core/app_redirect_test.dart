import 'package:flutter_test/flutter_test.dart';
import 'package:sheshield/core/router/app_redirect.dart';
import 'package:sheshield/shared/entities/app_user.dart';
import 'package:sheshield/shared/entities/gender.dart';
import 'package:sheshield/shared/entities/user_type.dart';

AppUser _userOfType(UserType type) => AppUser(
      uid: 'u1',
      name: 'Test',
      phone: '1700000000',
      countryCode: '+880',
      email: 't@example.com',
      gender: Gender.values.first,
      userType: type,
      createdAt: DateTime(2026),
    );

String? _redirect(String location, {AppUser? user, bool resolving = false}) =>
    resolveRedirect(location: location, isAuthResolving: resolving, user: user);

void main() {
  test('admin URLs bypass the user auth redirect', () {
    expect(_redirect('/admin/reports'), isNull);
  });

  test('signed-out users are sent to login', () {
    expect(_redirect('/home/user'), '/login');
    expect(_redirect('/login'), isNull);
  });

  test('nothing redirects while auth is still resolving', () {
    expect(_redirect('/home/user', resolving: true), isNull);
  });

  test('signed-in users leave the login screen for their home', () {
    expect(_redirect('/login', user: _userOfType(UserType.user)), '/home/user');
    expect(_redirect('/login', user: _userOfType(UserType.helper)), '/home/helper');
  });

  test('role gate keeps plain users out of helper tabs and vice versa', () {
    expect(_redirect('/home/helper', user: _userOfType(UserType.user)), '/home/user');
    expect(_redirect('/home/user', user: _userOfType(UserType.helper)), '/home/helper');
    expect(_redirect('/home/helper', user: _userOfType(UserType.userHelper)), isNull);
  });
}
