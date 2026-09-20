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

    // Tapping the SOS button starts an auto-send countdown.
    await tester.tap(find.byIcon(Icons.home_outlined));
    await tester.pump(const Duration(milliseconds: 300));
    await tester.tap(find.text('SOS'));
    await tester.pump(const Duration(milliseconds: 50));
    await tester.pump(const Duration(milliseconds: 400));
    expect(find.text('Sending SOS alert...'), findsOneWidget);
    expect(find.text('5'), findsOneWidget);

    // Letting the countdown run out should auto-send the alert.
    for (var i = 0; i < 5; i++) {
      await tester.pump(const Duration(seconds: 1));
    }
    await tester.pump(const Duration(milliseconds: 700));
    expect(find.text('SOS Alert Sent'), findsOneWidget);

    // The SOS drill should award XP and unlock the Ninja Reflexes badge,
    // proving GameScope is reachable from the pushed overlay route.
    await tester.pump(const Duration(milliseconds: 500));
    await tester.pump(const Duration(milliseconds: 400));
    expect(find.textContaining('Ninja Reflexes unlocked'), findsOneWidget);
  });

  testWidgets('Cancelling the SOS countdown dismisses it without sending', (WidgetTester tester) async {
    await tester.pumpWidget(const SheShieldApp());
    await tester.pump(const Duration(milliseconds: 300));

    await tester.tap(find.text('SOS'));
    await tester.pump(const Duration(milliseconds: 50));
    await tester.pump(const Duration(milliseconds: 400));
    expect(find.text('Sending SOS alert...'), findsOneWidget);

    await tester.tap(find.text('Cancel'));
    await tester.pump(const Duration(milliseconds: 50));
    await tester.pump(const Duration(milliseconds: 400));
    expect(find.text('Sending SOS alert...'), findsNothing);
    expect(find.text('SOS Alert Sent'), findsNothing);
  });

  testWidgets('Enabling an AI feature awards XP and unlocks AI Sentinel', (WidgetTester tester) async {
    await tester.pumpWidget(const SheShieldApp());
    await tester.pump(const Duration(milliseconds: 300));

    await tester.tap(find.byIcon(Icons.auto_awesome_outlined));
    await tester.pump(const Duration(milliseconds: 50));
    await tester.pump(const Duration(milliseconds: 400));
    expect(find.text('AI Guardian'), findsOneWidget);

    // Only 'Route Risk Analysis' starts disabled; switching it on enables
    // every AI feature, which should unlock the AI Sentinel badge.
    final switches = tester.widgetList<Switch>(find.byType(Switch)).toList();
    expect(switches.length, 4);
    expect(switches[2].value, isFalse);

    await tester.ensureVisible(find.byType(Switch).at(2));
    await tester.pump();
    await tester.tap(find.byType(Switch).at(2));
    await tester.pump(const Duration(milliseconds: 50));
    await tester.pump(const Duration(milliseconds: 400));
    expect(find.textContaining('AI Sentinel unlocked'), findsOneWidget);
  });

  testWidgets('Adding a trusted contact awards XP and unlocks Circle Guardian', (WidgetTester tester) async {
    await tester.pumpWidget(const SheShieldApp());
    await tester.pump(const Duration(milliseconds: 300));

    await tester.tap(find.byIcon(Icons.people_alt_outlined));
    await tester.pump(const Duration(milliseconds: 50));
    await tester.pump(const Duration(milliseconds: 400));
    expect(find.text('Trusted Contacts'), findsOneWidget);

    await tester.tap(find.text('Add Contact'));
    await tester.pump(const Duration(milliseconds: 50));
    await tester.pump(const Duration(milliseconds: 400));
    expect(find.textContaining('Circle Guardian unlocked'), findsOneWidget);
  });

  testWidgets('Switching to Helper Dashboard and responding to an alert awards XP', (WidgetTester tester) async {
    await tester.pumpWidget(const SheShieldApp());
    await tester.pump(const Duration(milliseconds: 300));

    await tester.tap(find.byIcon(Icons.person_outline_rounded));
    await tester.pump(const Duration(milliseconds: 50));
    await tester.pump(const Duration(milliseconds: 400));
    expect(find.text('My Profile'), findsOneWidget);
    expect(find.text('Helper Dashboard'), findsOneWidget);

    // Helper Dashboard starts offline: no alerts should be visible yet.
    await tester.tap(find.text('Helper Dashboard'));
    await tester.pump(const Duration(milliseconds: 50));
    await tester.pump(const Duration(milliseconds: 400));
    expect(find.text("You're Offline"), findsOneWidget);
    expect(find.text('Respond'), findsNothing);

    // Flip availability on; nearby alerts should now appear.
    await tester.tap(find.byType(Switch));
    await tester.pump(const Duration(milliseconds: 50));
    await tester.pump(const Duration(milliseconds: 400));
    expect(find.text("You're Available"), findsOneWidget);
    expect(find.text('Respond'), findsWidgets);

    // Responding to the first alert should award XP and unlock the badge.
    await tester.tap(find.text('Respond').first);
    await tester.pump(const Duration(milliseconds: 50));
    await tester.pump(const Duration(milliseconds: 400));
    expect(find.textContaining('Guardian Helper unlocked'), findsOneWidget);
    expect(find.text('On the way'), findsOneWidget);

    // Switching back to My Profile should restore the usual content.
    await tester.tap(find.text('My Profile'));
    await tester.pump(const Duration(milliseconds: 50));
    await tester.pump(const Duration(milliseconds: 400));
    expect(find.text('Achievements'), findsOneWidget);
  });
}
