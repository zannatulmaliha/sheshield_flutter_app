import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:sheshield/main.dart';

void main() {
  testWidgets('SheShield app loads home screen with SOS button', (WidgetTester tester) async {
    await tester.pumpWidget(const SheShieldApp());
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.text('SOS'), findsOneWidget);
    expect(find.text('Home'), findsOneWidget);
    expect(find.byIcon(Icons.auto_awesome_outlined), findsOneWidget);

    await tester.tap(find.byIcon(Icons.people_alt_outlined));
    await tester.pump(const Duration(milliseconds: 300));
    expect(find.text('Trusted Contacts'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.auto_awesome_outlined));
    await tester.pump(const Duration(milliseconds: 300));
    expect(find.text('AI Guardian'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.person_outline_rounded));
    await tester.pump(const Duration(milliseconds: 300));
    expect(find.text('Profile'), findsWidgets);

    // Tapping the SOS button should open the confirmation sheet.
    await tester.tap(find.byIcon(Icons.home_outlined));
    await tester.pump(const Duration(milliseconds: 300));
    await tester.tap(find.text('SOS'));
    await tester.pump(const Duration(milliseconds: 300));
    expect(find.text('Send emergency alert?'), findsOneWidget);
  });
}
