import 'package:flappy_search_bar/flappy_search_bar.dart';
import "package:flutter/material.dart";
import 'package:flutter_test/flutter_test.dart';
import 'package:recipemine/Custom/CustomWidgets/CustomRangeFilter.dart';
import 'package:recipemine/Custom/Models/Recipe.dart';
import 'package:recipemine/pages/Home/SearchPage/FilterInterface.dart';

void main() {
  runWidgetTests();
}

void runWidgetTests() {
  Widget _buildTestableWidget() {
    SearchBarController<Recipe> searchBarController = SearchBarController();
    return MaterialApp(
        home: FilterInterface(
          searchBarController: searchBarController,
          userPantry: [],
        )
    );
  }

  testWidgets("Filter interface UI test", (WidgetTester tester) async {
    Widget sortInterface = _buildTestableWidget();
    await tester.pumpWidget(sortInterface);

    expect(find.text("Filter"), findsOneWidget);
    expect(find.text("Rating"), findsOneWidget);
    expect(find.text("Cooking time"), findsOneWidget);
    expect(find.text("Dish"), findsOneWidget);
    expect(find.text("main"), findsOneWidget);
    expect(find.text("side"), findsOneWidget);
    expect(find.text("dessert"), findsOneWidget);
    expect(find.text("drink"), findsOneWidget);
    expect(find.text("Serving size"), findsOneWidget);
    expect(find.text("Have all ingredients in pantry"), findsOneWidget);
    expect(find.byType(RaisedButton), findsNWidgets(2));
    expect(find.byType(CustomRangeFilter), findsNWidgets(3));
  });
}