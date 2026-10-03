import 'package:flutter_test/flutter_test.dart';
import 'package:sheshield/features/auth/data/models/auth_session_model.dart';
import 'package:sheshield/shared/entities/gender.dart';
import 'package:sheshield/shared/entities/user_type.dart';

Map<String, dynamic> _sessionJson({String gender = 'female', String userType = 'user_helper'}) => {
      'token': 'jwt',
      'user': {
        'uid': 'u1',
        'name': 'Amina',
        'phone': '1700000000',
        'countryCode': '+880',
        'email': 'a@example.com',
        'gender': gender,
        'userType': userType,
        'isHelperVerified': true,
        'createdAt': '2026-10-01T08:00:00Z',
      },
    };

void main() {
  test('maps a login response to token and user entity', () {
    final session = AuthSessionModel.fromJson(_sessionJson());
    final user = session.user.toEntity();

    expect(session.token, 'jwt');
    expect(user.gender, Gender.female);
    expect(user.userType, UserType.userHelper);
    expect(user.isHelperVerified, isTrue);
    expect(user.discoverableViaMutualConnections, isFalse);
  });

  test('an unknown role falls back to the least-privileged one', () {
    final user = AuthSessionModel.fromJson(_sessionJson(userType: 'superadmin'))
        .user
        .toEntity();
    expect(user.userType, UserType.user);
  });

  test('gender is read by enum name, with a safe fallback', () {
    expect(
      AuthSessionModel.fromJson(_sessionJson(gender: 'preferNotToSay')).user.toEntity().gender,
      Gender.preferNotToSay,
    );
    expect(
      AuthSessionModel.fromJson(_sessionJson(gender: '')).user.toEntity().gender,
      Gender.preferNotToSay,
    );
  });

  test('UserType wire values round-trip', () {
    for (final type in UserType.values) {
      expect(UserType.fromWireValue(type.wireValue), type);
    }
  });
}
