import "package:flutter/material.dart";
import "package:recipemine/pages/FrenchOmelette.dart";
import "package:recipemine/pages/IngredientsList.dart";
import "package:recipemine/pages/Ending.dart";

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
      appBar: AppBar(
        title: Text("Assistant"),
        titleSpacing: 20.0,
        backgroundColor: Color(0xffFF464F),
      ),
      body: PageView(children: CookingAssistant.getPages(FrenchOmelette())),
      bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.grey[100],
            selectedItemColor: Color(0xffFF464F),
            currentIndex: navigationIndex,
            items: <BottomNavigationBarItem> [
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                title: Text("Search"),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.whatshot),
                title: Text("Assistant"),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                title: Text("Favourites"),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.kitchen),
                title: Text("Pantry"),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.group),
                title: Text("Community"),
              ),
            ],
            onTap: (index) {
              setState(() {navigationIndex = index;});
              print("placeholder method for navigating bottom bar");
            }
        )
    );

  }
}
