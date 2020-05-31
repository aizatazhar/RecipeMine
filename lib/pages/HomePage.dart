import "package:flutter/material.dart";
import "package:flappy_search_bar/flappy_search_bar.dart";
import "package:flappy_search_bar/search_bar_style.dart";
import "package:recipemine/Constants.dart";

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[100],
      body: SafeArea(
        child: SearchBar<Ingredient>(
          onSearch: search,
          onItemFound: (Ingredient ingredient, int index) {
            return Material(
              color: Colors.white,
              child: ListTile(
                contentPadding: EdgeInsets.fromLTRB(20.0, 0, 0, 0),
                enabled: true,
                onTap: onTapMethod(context, ingredient),
                title: Constants.listItemTitleLight(ingredient.name),
              ),
            );
          },
          hintText: "type some ingredients",
          hintStyle: TextStyle(
            color: Color(0xff5F5F5F),
            fontSize: 14.0,
          ),
          searchBarPadding: EdgeInsets.symmetric(horizontal: 20.0),
          searchBarStyle: SearchBarStyle(
            backgroundColor: Colors.white,
            padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
          ),
          listPadding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
          icon: Icon(
            Icons.search,
            color: Color(0xffFF464F),
          ),
        ),
      ),
    );
  }

  // spaghetti code/placeholder for searching an ingredient
  // Modified for eggs only for the video.
  Future<List<Ingredient>> search(String item) async {
    List<Ingredient> eggs = [];
    eggs.add(Ingredient("French Omelette"));
    eggs.add(Ingredient("Poached Egg"));
    eggs.add(Ingredient("Fried Egg"));

    // Not sure what this is for but it simulates loading i guess?
    await Future.delayed(Duration(seconds: 1));
    return eggs;
  }

  // placeholder method used to transition into the cooking
  // assistant when clicking a recipe
  onTapMethod(BuildContext context, Ingredient ingredient) {
    if (ingredient.name == "French Omelette") {
      Navigator.pushReplacementNamed(context, "/CookingAssistant");
    }
  }

}

// spaghetti class for ingredients database (for searching)
class Ingredient {
  final String name;

  Ingredient(this.name);
}