import 'package:flappy_search_bar/flappy_search_bar.dart';
import "package:flutter/material.dart";
import 'package:flutter_test/flutter_test.dart';
import 'package:recipemine/Custom/Models/Recipe.dart';
import 'package:recipemine/pages/Home/SearchPage/SortInterface.dart';

void main() {
  runWidgetTests();
}

void runWidgetTests() {
  Widget _buildTestableWidget() {
    SearchBarController<Recipe> searchBarController = SearchBarController();
    return MaterialApp(
      home: SortInterface(
        searchBarController: searchBarController,
        userPantry: [],
      )
    );
  }

  testWidgets("Sort interface UI test", (WidgetTester tester) async {
    Widget sortInterface = _buildTestableWidget();
    await tester.pumpWidget(sortInterface);

    expect(find.text("Sort by"), findsOneWidget);
    expect(find.text("Relevance"), findsOneWidget);
    expect(find.text("Alphabetical"), findsOneWidget);
    expect(find.text("Rating"), findsOneWidget);
    expect(find.text("Cooking time"), findsOneWidget);
    expect(find.text("Number of ingredients required"), findsOneWidget);
    expect(find.text("Number of ingredients in pantry"), findsOneWidget);
    expect(find.byType(RaisedButton), findsOneWidget);
  });
}