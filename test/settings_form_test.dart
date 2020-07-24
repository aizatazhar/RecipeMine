import 'package:flutter_test/flutter_test.dart';
import 'package:recipemine/pages/Home/Profile/SettingsForm.dart';

void main() {
  runUnitTests();

  runWidgetTests();
}

void runUnitTests() {
  test("Empty username returns error", () {
    final result = usernameValidator("");
    expect(result, "Please enter a username");
  });

  test("Non-empty ingredient returns null", () {
    final result = usernameValidator("username");
    expect(result, null);
  });
}

void runWidgetTests() {

}