import 'package:flutter_test/flutter_test.dart';
import 'package:recipemine/pages/Home/Pantry/PantryAdder.dart';

void main() {
  runUnitTests();
}

void runUnitTests() {
  test("Empty ingredient returns error", () {
    final result = ingredientValidator("");
    expect(result, "Please enter an ingredient");
  });

  test("Non-empty ingredient returns null", () {
    final result = ingredientValidator("fish");
    expect(result, null);
  });

  test("Empty quantity returns error", () {
    final result = quantityValidator("");
    expect(result, "Please enter a quantity");
  });

  test("Non-empty quantity returns null", () {
    final result = quantityValidator("100");
    expect(result, null);
  });
}