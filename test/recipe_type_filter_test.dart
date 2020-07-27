import "package:flutter/material.dart";
import 'package:flutter_test/flutter_test.dart';
import 'package:recipemine/Custom/Models/Recipe.dart';
import 'package:recipemine/pages/Home/SearchPage/RecipeTypeFilter.dart';

void main() {
  runWidgetTests();
}

void runWidgetTests() {
  Widget _buildTestableWidget() {
    List<RecipeType> filters = [
      RecipeType.main,
      RecipeType.side,
      RecipeType.dessert,
      RecipeType.drink,
    ];

    return MaterialApp(
        home: Scaffold(
          body: RecipeTypeFilter(
            filters: filters,
            types: RecipeType.values,
          )
        )
    );
  }

  testWidgets("RecipeTypeFilter UI test", (WidgetTester tester) async {
    Widget page = _buildTestableWidget();
    await tester.pumpWidget(page);

    expect(find.text("main"), findsOneWidget);
    expect(find.text("side"), findsOneWidget);
    expect(find.text("dessert"), findsOneWidget);
    expect(find.text("drink"), findsOneWidget);
  });
}