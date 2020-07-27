import 'package:flappy_search_bar/flappy_search_bar.dart';
import "package:flutter/material.dart";
import 'package:flutter_test/flutter_test.dart';
import 'package:recipemine/Custom/CustomWidgets/CustomRangeFilter.dart';
import 'package:recipemine/pages/Home/CookingAssistant/SmartTimerDisplay.dart';

void main() {
  runWidgetTests();
}

void runWidgetTests() {
  Widget _buildTestableWidget({int seconds}) {
    return MaterialApp(
        home: SmartTimerDisplay(seconds: seconds)
    );
  }

  testWidgets("SmartTimerDisplay UI test, 1 min", (WidgetTester tester) async {
    Widget page = _buildTestableWidget(seconds: 60);
    await tester.pumpWidget(page);

    expect(find.text("01:00"), findsOneWidget);
    expect(find.byType(RawMaterialButton), findsNWidgets(2));
  });


  testWidgets("SmartTimerDisplay UI test, 1 hour ", (WidgetTester tester) async {
    Widget page = _buildTestableWidget(seconds: 3600);
    await tester.pumpWidget(page);

    expect(find.text("1:00:00"), findsOneWidget);
    expect(find.byType(RawMaterialButton), findsNWidgets(2));
  });
}