// Basic navigation/flow tests for the Horizon app.
//
// These exercise the three required screens end to end: Login ->
// Sign-Up -> Home, and Login -> Home directly, checking that the
// name typed on Sign-Up reaches Home through route arguments.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_application_1/main.dart';

void main() {
  testWidgets('Login screen shows its fields and Sign Up link', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const HorizonApp());

    expect(find.text('Horizon'), findsOneWidget);
    expect(find.text('Email or username'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.widgetWithText(ElevatedButton, 'Log In'), findsOneWidget);
    expect(find.text('Sign Up'), findsOneWidget);
  });

  testWidgets('Sign Up -> Home passes the entered name via route arguments', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const HorizonApp());

    // Login -> Sign-Up (pushNamed).
    await tester.tap(find.text('Sign Up'));
    await tester.pumpAndSettle();
    expect(find.text('Create account'), findsOneWidget);

    // Fill in the Sign-Up form.
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Full name'),
      'Ada Lovelace',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Email'),
      'ada@example.com',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Password'),
      'password123',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Confirm password'),
      'password123',
    );

    // Sign-Up -> Home (pushReplacementNamed).
    await tester.tap(find.widgetWithText(ElevatedButton, 'Sign Up'));
    await tester.pumpAndSettle();

    expect(find.text('Ada Lovelace!'), findsOneWidget);
    expect(find.text('Create account'), findsNothing);

    // Home -> Login (pushReplacementNamed via Log Out).
    await tester.tap(find.widgetWithText(OutlinedButton, 'Log Out'));
    await tester.pumpAndSettle();
    expect(find.text('Horizon'), findsOneWidget);
    expect(find.text('Email or username'), findsOneWidget);
  });

  testWidgets('Sign-Up validation blocks navigation on empty form', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const HorizonApp());

    await tester.tap(find.text('Sign Up'));
    await tester.pumpAndSettle();

    // Submitting an empty form should not navigate to Home.
    await tester.tap(find.widgetWithText(ElevatedButton, 'Sign Up'));
    await tester.pumpAndSettle();

    expect(find.text('Create account'), findsOneWidget);
    expect(find.text('Enter your full name'), findsOneWidget);
  });
}
