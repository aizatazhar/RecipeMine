import "package:cloud_firestore/cloud_firestore.dart";
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import "package:flappy_search_bar/flappy_search_bar.dart";
import 'package:provider/provider.dart';
import 'package:recipemine/AppStyle.dart';
import 'package:recipemine/Custom/Models/Recipe.dart';
import 'package:recipemine/Custom/Models/ReciperMinerUser.dart';
import 'package:recipemine/Custom/Models/User.dart';
import 'package:recipemine/pages/Home/FireBase/Database.dart';
import 'DetailView.dart';
import 'FilterInterface.dart';
import 'SortInterface.dart';

/// Builds the Search Page.
class SearchPage extends StatefulWidget {

  final Function onBeginCooking;

  SearchPage({this.onBeginCooking});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  double _iconSize = 22.0;

  final SearchBarController<Recipe> _searchBarController = SearchBarController();

  bool _isSearching = false;

/*
  List<Recipe> suggestion;
  bool loadingSuggestion;

  // Used for random recipe generation
  @override
  void initState() {
    loadingSuggestion = true;
    _getRandomRecipe().then((value) =>
      setState(() {
        suggestion = value;
      })
    );
    super.initState();
  }
*/

  @override
  Widget build(BuildContext context) {

    RecipeMiner user = getUser();
    return Scaffold(
      body: SearchBar<Recipe>(
        hintText: "eggs, flour, butter",
        hintStyle: AppStyle.searchBarHintStyle,

        iconActiveColor: Colors.redAccent,
        searchBarPadding: EdgeInsets.symmetric(horizontal: 20.0),
        searchBarStyle: AppStyle.searchBarStyle,
        searchBarController: _searchBarController,

        mainAxisSpacing: 20,

        onSearch: (String query) => _search(query, user.pantry),
        onItemFound: (Recipe recipe, int index) => _buildSlider(recipe, user),
        onCancelled: () => setState(() => _isSearching = false),
        onError: (Error error) {
          return Center(child: Text("Error: ${error.toString()}", style: AppStyle.caption));
        },

        emptyWidget: _buildEmptyView(),
        header: _buildHeader(),
//        suggestions: loadingSuggestion ? [] : suggestion,
      )
    );
  }

  RecipeMiner getUser() {
    List<RecipeMiner> users = Provider.of<List<RecipeMiner>>(context) ?? [];
    User currentUserUID = Provider.of<User>(context);

    // contains the current user details
    RecipeMiner currentUserData;
    for (int i = 0; i < users.length; i++) {
      if (users[i].uid == currentUserUID.uid) {
        currentUserData = users[i];
        break;
      }
    }

    return currentUserData;
  }

  /// Takes in a single recipe and builds its corresponding slider
  Widget _buildSlider(Recipe recipe, RecipeMiner user) {
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
      int ingredientsPresent = recipe.numberOfIngredientsPresent(user.pantry);
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
              _buildIcon(Icons.kitchen, Color(0xff1D92FF), "$ingredientsPresent/${recipe.ingredients.length}"),
              Spacer(),
              IconButton(
                icon: Icon(
                  user.favourites.contains(recipe.id)  ? Icons.favorite : Icons.favorite_border,
                  color: user.favourites.contains(recipe.id) ? Colors.red : Colors.white,
                ),
                iconSize: _iconSize,
                onPressed: () {
                  if (user.favourites.contains(recipe.id)){
                    user.favourites.remove(recipe.id);
                    DatabaseService().updateUserData(user.name, user.email, user.uid, user.profilePic, user.pantry,user.favourites);
                  } else {
                    user.favourites.add(recipe.id);
                    DatabaseService().updateUserData(user.name, user.email, user.uid, user.profilePic, user.pantry,user.favourites);
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

    return GestureDetector(
      child: Container(
        height: 500,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow:  [
              BoxShadow(
                color: Colors.grey[600],
                blurRadius: 2.0,
                spreadRadius: 0.0,
                offset: Offset(2.5, 2.5), // shadow direction: bottom right
              )
            ]
        ),
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Container(
            child: Stack(
              children: <Widget>[
                Image.network(
                  recipe.imageURL,
                  fit: BoxFit.cover,
                  width: 1000,
                  height: 1000
                ),
                _buildTopSection(recipe),
                _buildBottomSection(recipe),
              ],
            ),
          ),
        ),
      ),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => DetailView(
            recipe: recipe,
            user: user,
            onBeginCooking: this.widget.onBeginCooking,
          )
        ));
      },
    );
  }

  /// Method for searching for recipes.
  Future<List<Recipe>> _search(String input, List<dynamic> userPantry) async {
    // Triggers rebuild to remove the default view
    setState(() => _isSearching = true);

    // Get recipes from Firestore
    QuerySnapshot querySnapshot = await Firestore.instance.collection("Recipes").getDocuments();
    List<DocumentSnapshot> recipes = querySnapshot.documents;

    // Parse user input
    Set<String> queries = _getQueries(input);

    Set<Recipe> resultSet = Set();

    // Add recipes that contains an ingredient which was queried to result or
    // if the name of the recipe contains the query, and subsequently
    // increment the numberOfMatchingQueries
    recipes.forEach((recipeSnapshot) {
      int numberOfMatchingQueries = 0;
      Recipe recipe = Recipe.fromDocumentSnapshot(recipeSnapshot);
      Set<String> flattenedIngredients = recipe.queryIngredients == null
          ? _flattenIngredients(recipe.ingredients)
          : _flattenQueryIngredients(recipe.queryIngredients);

      for (String query in queries) {
        if (flattenedIngredients.contains(query) || recipe.name.toLowerCase().contains(query)) {
          resultSet.add(recipe);
          numberOfMatchingQueries++;
        }
      }
      recipe.numberOfMatchingQueries = numberOfMatchingQueries;
    });

    await Future.delayed(Duration(seconds: 1));

    List<Recipe> result = resultSet.toList();
    result.sort((Recipe first, Recipe second) {
      return first.calculateRelevanceScore(userPantry)
          .compareTo(second.calculateRelevanceScore(userPantry));
    });

    return result;
  }

  /// Parses query based on comma.
  Set<String> _getQueries(String query) {
    Set<String> result = Set();

    for (String word in query.split(",")) {
      if (word != "") {
        result.add(word.trim().toLowerCase());
      }
    }

    return result;
  }

  /// Takes in a list of ingredients and returns a set containing every word of
  /// the list. Used to enable searching for recipes which do not have a
  /// queryIngredients field.
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

  /// Removes duplicate ingredients.
  Set<String> _flattenQueryIngredients(List<dynamic> ingredients) {
    Set<String> result = Set();

    for (String ingredient in ingredients) {
      result.add(ingredient);
    }

    return result;
  }

  /// Builds the view when no recipes are found with the given user query.
  Widget _buildEmptyView() {
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AppStyle.buildEmptyViewIcon(Icons.search),
            SizedBox(height: 20),
            Text(
              "No recipes found",
              style: AppStyle.mediumHeader,
            ),
            SizedBox(height: 10),
            Text(
              "Try searching with different ingredients!",
              style: AppStyle.caption,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

/*
  // Used to build initial suggestion when user has not searched anything
  Future<List<Recipe>> _getRandomRecipe() async {
    // Hardcoded number of the total number of recipes to save reads on Firestore
    int endIndex = 52;

    // Create a list of numbers from 0 to 52, then shuffle
    List<int> randomList = List.generate(endIndex + 1, (i) => i);
    randomList.shuffle();
    int randomIndex = randomList[0];

    List<Recipe> result = [];

    // Get recipes from Firestore corresponding to the random index
    await Firestore.instance
        .collection("Recipes")
        .document(randomIndex.toString())
        .get()
        .then((snapshot) {
      if (snapshot.exists) {
        Recipe recipe = Recipe.fromDocumentSnapshot(snapshot);
        result.add(recipe);
        loadingSuggestion = false;
      } else {
        print("value does not exist");
      }
    });

    return result;
  }
*/

  /// Builds the view below the search bar.
  Widget _buildHeader()  {
    List<Widget> body = [];

    // Widgets that are always present
//    body.add();

    // Widgets that are only present when user is not searching
    if (!_isSearching) {
//    body.add();
    }

    // Widgets that are only present when user is searching
    if (_isSearching) {
      body.add(
        Container(
          padding: EdgeInsets.only(bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildSortButton(_searchBarController),
              _buildFilterButton(_searchBarController),
            ],
          ),
        )
      );
    }

    return Column(
      children: body,
    );
  }

  Widget _buildSortButton(SearchBarController searchBarController) {
    return RaisedButton(
      child: Row(
        children: <Widget>[
          Icon(Icons.sort),
          Text(
            "Sort",
            style: TextStyle(
              color: Colors.grey[800],
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: Colors.grey, width: 0.5),
      ),
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (BuildContext context) => SortInterface(
            searchBarController: searchBarController,
            userPantry: getUser().pantry,
          )
        ));
      },
    );
  }

  Widget _buildFilterButton(SearchBarController searchBarController) {
    return RaisedButton(
      child: Row(
        children: <Widget>[
          Icon(Icons.filter_list),
          Text(
            "Filter",
            style: TextStyle(
              color: Colors.grey[800],
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: Colors.grey, width: 0.5),
      ),
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) => FilterInterface(
              searchBarController: searchBarController,
              userPantry: getUser().pantry,
            )
        ));
      },
    );
  }
}

