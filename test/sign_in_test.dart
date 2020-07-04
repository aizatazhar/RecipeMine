import 'package:flutter/material.dart';
import "package:flutter_test/flutter_test.dart";
import "package:recipemine/pages/Authentication/SignIn.dart";

void main() {
  runUnitTests();
  runWidgetTests();
}

void runUnitTests() {
  test("Empty email returns error message", () {
    final result = emailValidator("");
    expect(result, "Enter an email");
  });

  test("Non-empty email returns null", () {
    final result = emailValidator("abc@xyz.com");
    expect(result, null);
  });

  test("Empty password returns error message", () {
    final result = passwordValidator("");
    expect(result, "Enter a password");
  });

  test("Non-empty password returns null", () {
    final result = passwordValidator("hello world");
    expect(result, null);
  });
}

void runWidgetTests() {
  Widget _buildTestableWidget(Widget child) {
    return MaterialApp(home: child);
  }

  testWidgets("Sign in page UI test", (WidgetTester tester) async {
    Widget page = _buildTestableWidget(SignIn());
    await tester.pumpWidget(page);

    expect(find.byType(Image), findsNWidgets(2));
    expect(find.byType(TextFormField), findsNWidgets(2));
    expect(find.byType(RaisedButton), findsNWidgets(2));

    expect(find.text("Enter an email"), findsNothing);
    expect(find.text("Enter a password"), findsNothing);
  });

  testWidgets("Signing in with both empty email and password gives error", (WidgetTester tester) async {
    Widget page = _buildTestableWidget(SignIn());
    await tester.pumpWidget(page);

    // Blank for both fields
    await tester.tap(find.byKey(Key("signIn")));
    await tester.pump();
    expect(find.text("Enter an email"), findsOneWidget);
    expect(find.text("Enter a password"), findsOneWidget);
  });

  testWidgets("Signing in with empty email gives error", (WidgetTester tester) async {
    Widget page = _buildTestableWidget(SignIn());
    await tester.pumpWidget(page);

    // Blank only for email field
    await tester.enterText(find.byKey(Key("password")), "password");
    await tester.tap(find.byKey(Key("signIn")));
    await tester.pump();
    expect(find.text("Enter an email"), findsOneWidget);
    expect(find.text("Enter a password"), findsNothing);
  });

  testWidgets("Signing in with empty password gives error", (WidgetTester tester) async {
    Widget page = _buildTestableWidget(SignIn());
    await tester.pumpWidget(page);

    // Blank only for password field
    await tester.enterText(find.byKey(Key("email")), "xyz@test.com");
    await tester.tap(find.byKey(Key("signIn")));
    await tester.pump();
    expect(find.text("Enter an email"), findsNothing);
    expect(find.text("Enter a password"), findsOneWidget);
  });
}