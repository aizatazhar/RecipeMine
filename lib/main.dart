import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/search_bar_style.dart';
import 'package:flutter/material.dart';
import 'package:recipemine/pages/CookingAssistant.dart';
import 'package:recipemine/pages/LoadingScreen.dart';
import 'package:recipemine/pages/step1.dart';
import 'package:recipemine/pages/step2.dart';
import 'package:recipemine/pages/step3.dart';
import 'package:recipemine/pages/step4.dart';
import 'package:recipemine/pages/ending.dart';
import 'package:recipemine/pages/Ingredients.dart';


void main() {
  runApp(MaterialApp(
    routes: {
      '/': (context) => LoadingScreen(),
      '/ingredientList' : (context) => IngredientList(),
      '/step1': (context) => Step1(),
      '/step2': (context) => Step2(),
      '/step3': (context) => Step3(),
      '/step4': (context) => Step4(),
      '/ending' : (context) => Ending(),
      '/homePage': (context) => HomePage(),
      '/CookingAssistant': (context) => CookingAssistant(),



    }
  ));
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[100],
      body: SafeArea(
        child: SearchBar<Ingredient>(
          onSearch: this.search,
          onItemFound: (Ingredient ingredient, int index) {
            return Material(
              color: Colors.white,
              child: ListTile(
                contentPadding: EdgeInsets.fromLTRB(20.0, 0, 0, 0),
                enabled: true,
                onTap: (){
                  //placeholder method used to transition into the cooking assistant
                  if(ingredient.name == 'French Omelette'){
                      Navigator.pushReplacementNamed(context, '/CookingAssistant');
                  }
                },
                title: Text(
                  ingredient.name,
                  style: TextStyle(
                    color: Color(0xff5F5F5F),
                    fontFamily: "SanFranciscoDisplay",
                    fontSize: 18.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            );
          },
          hintText: "type some ingredients",
          hintStyle: TextStyle(
            color: Color(0xff5F5F5F),
            fontFamily: "SanFranciscoDisplay",
            fontSize: 14.0,
            fontWeight: FontWeight.w400,
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
  //Modified for eggs only for the video.
  Future<List<Ingredient>> search(String item) async {
    List<Ingredient> Eggs = [];
    Eggs.add(new Ingredient('French Omelette'));
    Eggs.add(new Ingredient('Poached Egg'));
    Eggs.add(new Ingredient('Fried Egg'));
    await Future.delayed(Duration(seconds: 2));
    return Eggs;
  }


}

// spaghetti class for ingredients database (for searching)
class Ingredient {
  final String name;

  Ingredient(this.name);
}







