import 'package:flutter_test/flutter_test.dart';
import 'package:sheshield/features/contacts/data/models/trusted_contact_model.dart';

TrustedContactModel _model({String name = 'Amina Rahman', String? linked}) =>
    TrustedContactModel(
      id: 'c1',
      name: name,
      relation: 'Sister',
      phone: '1700000000',
      countryCode: '+880',
      createdAt: DateTime(2026),
      linkedUserUid: linked,
    );

void main() {
  test('derives initials, phone, and link state', () {
    final contact = _model().toEntity();
    expect(contact.initials, 'AR');
    expect(contact.fullPhone, '+880 1700000000');
    expect(contact.hasAppLinked, isFalse);
    expect(_model(linked: 'u9').toEntity().hasAppLinked, isTrue);
  });

  test('single-word and blank names are handled', () {
    expect(_model(name: 'amina').toEntity().initials, 'A');
    expect(_model(name: '  ').toEntity().initials, '?');
  });

  test('json round-trip loses no field', () {
    final model = _model(linked: 'u9');
    expect(TrustedContactModel.fromJson(model.toJson()), model);
  });
}
