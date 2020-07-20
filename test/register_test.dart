import "package:flutter/material.dart";
import 'package:flutter_test/flutter_test.dart';
import "package:recipemine/pages/Authentication/Register.dart";

void main() {
  runUnitTests();

  runWidgetTests();
}

void runUnitTests() {

  test("Non-empty email return null", () {
    final result = emailValidator("xyz@test.com");
    expect(result, null);
  });

  test("Empty email returns error message", () {
    final result = emailValidator("");
    expect(result, "Enter an email");
  });

  test("Non-empty password return null", () {
    final result = passwordValidator("password123");
    expect(result, null);
  });

  test("Empty password returns error message", () {
    final result = passwordValidator("");
    expect(result, "Password must be at least 6 characters");
  });

  test("Matching non-empty passwords return null", () {
    final result = confirmPasswordValidator("password123", "password123");
    expect(result, null);
  });

  test("Non-matching passwords return error", () {
    final result = confirmPasswordValidator("firstPassword", "secondPassword");
    expect(result, "Passwords do not match");
  });

  test("Empty username returns error", () {
    final result = usernameValidator("");
    expect(result, "Username cannot be empty");
  });

  test("Non-empty username returns null", () {
    final result = usernameValidator("username");
    expect(result, null);
  });

}

void runWidgetTests() {
  Widget _buildTestableWidget(Widget child) {
    return MaterialApp(home: child);
  }

  testWidgets("Register page UI test", (WidgetTester tester) async {
    Widget page = _buildTestableWidget(Register());
    await tester.pumpWidget(page);

    expect(find.text("Create a new account"), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(4));
    expect(find.byType(RaisedButton), findsNWidgets(1));

    expect(find.text("Enter an email"), findsNothing);
    expect(find.text("Password must be at least 6 characters"), findsNothing);
    expect(find.text("Passwords do not match"), findsNothing);
  });

  testWidgets("Registering with empty fields gives errors ", (WidgetTester tester) async {
    Widget page = _buildTestableWidget(Register());
    await tester.pumpWidget(page);

    // Blank only for all field
    await tester.tap(find.byKey(Key("signUp")));
    await tester.pump();

    expect(find.text("Enter an email"), findsOneWidget);
    expect(find.text("Password must be at least 6 characters"), findsOneWidget);
  });

  testWidgets("Registering with empty email gives errors ", (WidgetTester tester) async {
    Widget page = _buildTestableWidget(Register());
    await tester.pumpWidget(page);

    // Blank only for all field
    await tester.enterText(find.byKey(Key("password")), "password");
    await tester.tap(find.byKey(Key("signUp")));
    await tester.pump();

    expect(find.text("Enter an email"), findsOneWidget);
    expect(find.text("Password must be at least 6 characters"), findsNothing);
    expect(find.text("Passwords do not match"), findsOneWidget);
  });

  testWidgets("Registering with empty password gives errors ", (WidgetTester tester) async {
    Widget page = _buildTestableWidget(Register());
    await tester.pumpWidget(page);

    // Blank only for all field
    await tester.enterText(find.byKey(Key("email")), "test@email.com");
    await tester.tap(find.byKey(Key("signUp")));
    await tester.pump();

    expect(find.text("Enter an email"), findsNothing);
    expect(find.text("Password must be at least 6 characters"), findsOneWidget);
    expect(find.text("Passwords do not match"), findsNothing);
  });

  testWidgets("Registering non-matching passwords gives errors ", (WidgetTester tester) async {
    Widget page = _buildTestableWidget(Register());
    await tester.pumpWidget(page);

    // Blank only for all field
    await tester.enterText(find.byKey(Key("email")), "test@email.com");
    await tester.enterText(find.byKey(Key("password")), "password123");
    await tester.enterText(find.byKey(Key("confirmPassword")), "password12345");
    await tester.tap(find.byKey(Key("signUp")));
    await tester.pump();

    expect(find.text("Enter an email"), findsNothing);
    expect(find.text("Password must be at least 6 characters"), findsNothing);
    expect(find.text("Passwords do not match"), findsOneWidget);
  });

  testWidgets("Registering with all valid fields gives no errors", (WidgetTester tester) async {
    Widget page = _buildTestableWidget(Register());
    await tester.pumpWidget(page);

    // Blank only for all field
    await tester.enterText(find.byKey(Key("email")), "test@email.com");
    await tester.enterText(find.byKey(Key("password")), "password123");
    await tester.enterText(find.byKey(Key("confirmPassword")), "password123");
    await tester.tap(find.byKey(Key("signUp")));
    await tester.pump();

    expect(find.text("Enter an email"), findsNothing);
    expect(find.text("Password must be at least 6 characters"), findsNothing);
    expect(find.text("Passwords do not match"), findsNothing);
  });
}