import "package:flutter/material.dart";
import 'file:///C:/Users/John/Downloads/Orbital/MyFork/RecipeMine/lib/pages/Home/CookingAssistant/FrenchOmelette.dart';
import 'file:///C:/Users/John/Downloads/Orbital/MyFork/RecipeMine/lib/pages/Home/CookingAssistant/IngredientsList.dart';
import "package:recipemine/pages/Home/CookingAssistant/Ending.dart";

class CookingAssistant extends StatefulWidget {

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
  _CookingAssistantState createState() => _CookingAssistantState();
}

class _CookingAssistantState extends State<CookingAssistant> {
  int navigationIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(children: CookingAssistant.getPages(FrenchOmelette())),
    );

  }
}
