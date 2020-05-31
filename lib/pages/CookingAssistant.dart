import "package:flutter/material.dart";
import "package:recipemine/pages/FrenchOmelette.dart";
import "package:recipemine/pages/IngredientsList.dart";
import "package:recipemine/pages/Ending.dart";

class CookingAssistant extends StatelessWidget {

  // Method that returns a list of widgets of the pages of a recipe
  static List<Widget> getPages(FrenchOmelette recipe) {
    List<Widget> stepPages = <Widget>[];
    stepPages.add(IngredientList());

    for (int i = 0; i < recipe.instructions.length; i++) {
      stepPages.add(recipe.buildStep(i + 1, recipe.instructions[i]));
    }

    stepPages.add(Ending());
    return stepPages;
  }

  @override
  Widget build(BuildContext context) {
    return PageView(children: getPages(FrenchOmelette()));
  }
}
