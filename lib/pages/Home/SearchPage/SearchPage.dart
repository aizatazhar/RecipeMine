import "package:cloud_firestore/cloud_firestore.dart";
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import "package:flappy_search_bar/flappy_search_bar.dart";
import "package:flappy_search_bar/search_bar_style.dart";
import 'package:provider/provider.dart';
import 'package:recipemine/Custom/Models/Recipe.dart';
import 'package:recipemine/Custom/Models/ReciperMinerUser.dart';
import 'package:recipemine/Custom/Models/User.dart';
import 'package:recipemine/pages/Home/FireBase/Database.dart';
import 'DetailView.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  double _iconSize = 22.0;

  // Builds the icons at the top of a slider
  Widget _buildIcon(IconData iconData, Color iconColor, String text) {
    return Row(
      children: <Widget> [
        Padding(
          padding: EdgeInsets.only(right: 2),
          child: Icon(
            iconData,
            color: iconColor,
            size: _iconSize,
          ),
        ),
        Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
          ),
        ),
      ],
    );
  }

  // Builds the top section of a slider
  _buildTopSection(Recipe recipe) {
    final users = Provider.of<List<RecipeMiner>>(context) ?? [];
    final currentUserUID = Provider.of<User>(context);

    // contains the current user details
    RecipeMiner currentUserData = RecipeMiner(name:'Loading',email: 'Loading',uid: 'Loading', profilePic: 'https://moonvillageassociation.org/wp-content/uploads/2018/06/default-profile-picture1.jpg', favourites: []);
    users.forEach((element) {
      if(element.uid == currentUserUID.uid){
        currentUserData = element;
      }
    });

    Color heartColour = currentUserData.favourites.contains(recipe.id) ? Colors.red : Colors.white;
    IconData iconData = currentUserData.favourites.contains(recipe.id) ? Icons.favorite : Icons.favorite_border;

    return Positioned( // Top icons
      top: 0.0,
      left: 0.0,
      right: 0.0,
      child: Container(
        decoration: BoxDecoration( // tint to contrast with icons
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(220, 0, 0, 0),
              Color.fromARGB(0, 0, 0, 0)
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: EdgeInsets.fromLTRB(15, 0, 5, 20),
        child: Row(
          children: <Widget>[
            _buildIcon(Icons.star, Color(0xffFFC440), recipe.rating.toString()),
            Spacer(),
            _buildIcon(Icons.schedule, Color(0xffFF5C64), recipe.duration.toString() + " min"),
            Spacer(),
            _buildIcon(Icons.people_outline, Color(0xff30C551), recipe.servingSize.toString()),
            Spacer(),
            _buildIcon(Icons.kitchen, Color(0xff1D92FF), "4/${recipe.ingredients.length}"),
            Spacer(),
            IconButton(
              icon: Icon(
                iconData,
                color: heartColour,
              ),
              iconSize: _iconSize,
              onPressed: () {
                if (currentUserData.favourites.contains(recipe.id)){
                  currentUserData.favourites.remove(recipe.id);
                  DatabaseService().updateUserData(currentUserData.name, currentUserData.email, currentUserData.uid, currentUserData.profilePic, currentUserData.pantry,currentUserData.favourites);
                } else {
                  currentUserData.favourites.add(recipe.id);
                  DatabaseService().updateUserData(currentUserData.name, currentUserData.email, currentUserData.uid, currentUserData.profilePic, currentUserData.pantry,currentUserData.favourites);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  // Builds the bottom section of a slider
  _buildBottomSection(Recipe recipe) {
    return Positioned( // Bottom text
      bottom: 0.0,
      left: 0.0,
      right: 0.0,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(220, 0, 0, 0),
              Color.fromARGB(0, 0, 0, 0)
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        padding: EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 15.0),
        child: Text(
          recipe.name,
          style: TextStyle(
            color: Colors.white,
            fontSize: 36.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  // Takes in a single recipe and builds its corresponding slider
  Widget _buildSlider(Recipe recipe) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: Container(
        child: Stack(
          children: <Widget>[
            Image.network(
              recipe.imageURL ,
              fit: BoxFit.cover,
              width: 1000,
              height: 1000
            ),
            _buildTopSection(recipe),
            _buildBottomSection(recipe),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SearchBar<Recipe>(
        hintText: "Type some ingredients",
        hintStyle: TextStyle(
          color: Color(0xff5F5F5F),
          fontSize: 14.0,
        ),

        searchBarPadding: EdgeInsets.symmetric(horizontal: 20.0),
        searchBarStyle: SearchBarStyle(
          backgroundColor: Colors.grey[100],
          padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
        ),

        onSearch: search,
        onItemFound: (Recipe recipe, int index) {
          return GestureDetector(
            child: Container(
              height: 520,
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: _buildSlider(recipe)
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => DetailView(recipe)
                )
              );
            },
          );
        }
      )
    );
  }

  // Placeholder method for searching
  Future<List<Recipe>> search(String input) async {

    // Get recipes from Firestore
    QuerySnapshot querySnapshot = await Firestore.instance.collection("Recipes").getDocuments();
    List<DocumentSnapshot> recipes = querySnapshot.documents;

    // Parse user input
    Set<String> queries = _getQueries(input);

    Set<Recipe> result = Set();

    // Add recipes that contains an ingredient which was queried to result
    recipes.forEach((recipeSnapshot) {
      Recipe recipe = Recipe.fromDocumentSnapshot(recipeSnapshot);
      Set<String> flattenedIngredients = _flattenIngredients(recipe.ingredients);

      for (String query in queries) {
        if (flattenedIngredients.contains(query)) {
          result.add(recipe);
        }
      }
    });

    await Future.delayed(Duration(seconds: 1));

    return result.toList();
  }

  // Parses based on comma
  Set<String> _getQueries(String query) {
    Set<String> result = Set();

    for (String word in query.split(",")) {
      if (word != "") {
        result.add(word.trim().toLowerCase());
      }
    }

    return result;
  }

  Set<String> _flattenIngredients(List<String> ingredients) {
    Set<String> result = Set();

    for (String ingredient in ingredients) {
      List<String> words = ingredient.split(" ");
      for (String word in words) {
        result.add(word.trim().toLowerCase());
      }
    }

    return result;
  }
}
