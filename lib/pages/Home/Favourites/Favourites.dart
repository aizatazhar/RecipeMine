import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:recipemine/Custom/Models/Recipe.dart';
import 'package:recipemine/Custom/Models/ReciperMinerUser.dart';
import 'package:recipemine/Custom/Models/User.dart';
import 'package:recipemine/pages/Home/FireBase/Database.dart';
import 'package:recipemine/pages/Home/SearchPage/DetailView.dart';
import '../../../AppStyle.dart';

/// Builds the Favourites page.
class Favourites extends StatefulWidget {
  final Function onBeginCooking;

  Favourites({@required this.onBeginCooking});

  @override
  _FavouritesState createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  Widget build(BuildContext context) {
    return Scaffold(
        body: _buildBody(),
    );
  }

  Widget _buildBody() {
    List<RecipeMiner> users = Provider.of<List<RecipeMiner>>(context) ?? [];
    User currentUserUID = Provider.of<User>(context);

    // contains the current user details
    RecipeMiner user;
    for (int i = 0; i < users.length; i++) {
      if (users[i].uid == currentUserUID.uid) {
        user = users[i];
        break;
      }
    }

    List<Recipe> recipeList = Provider.of<List<Recipe>>(context) ?? [];
    List<Recipe> filteredList = [];
    for (Recipe recipe in recipeList){
      if (user.favourites.contains(recipe.id)) {
        filteredList.add(recipe);
      }
    }

    int recipesLength = filteredList.length;

    return recipesLength > 0
        ? _buildFavouritesView(filteredList, user)
        : _buildEmptyView();
  }

  /// Builds the view when the user has favourited recipes.
  Widget _buildFavouritesView(List<Recipe> filteredList, RecipeMiner user) {
    int recipesLength = filteredList.length;

    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.65,
        ),
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        itemCount: recipesLength,
        itemBuilder: (BuildContext context, int index) {
          return _buildCard(filteredList[index], user);
        }
    );
  }

  /// Builds the card corresponding to a favourited recipe
  Widget _buildCard(Recipe recipe, RecipeMiner user) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => DetailView(
              recipe: recipe,
              user: user,
              onBeginCooking: this.widget.onBeginCooking,
            )
        ));
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow:  [
            BoxShadow(
              color: Colors.grey[600],
              blurRadius: 2.0,
              spreadRadius: 0.0,
              offset: Offset(2.0, 2.0), // shadow direction: bottom right
            )
          ]
        ),
        margin: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 0.0),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
          child: Stack(
            children: <Widget>[
              Image.network(
                recipe.imageURL,
                fit: BoxFit.cover,
                width: 1000,
                height: 1000,
              ),
              Positioned(
                top: -5.0,
                right: -10.0,
                child: IconButton(
                  onPressed: () {
                    user.favourites.remove(recipe.id);
                    DatabaseService().updateUserData(
                        user.name,
                        user.email,
                        user.uid,
                        user.profilePic,
                        user.pantry,
                        user.favourites
                    );
                  },
                  icon: user.favourites.contains(recipe.id)
                      ? Icon(Icons.favorite)
                      : Icon(Icons.favorite_border),
                  color: user.favourites.contains(recipe.id)
                      ? Colors.red
                      : Colors.white,
                  iconSize: 20.0,
                ),
              ),
              Positioned( // Bottom text
                bottom: 0.0,
                left: 0.0,
                right: 0.0,
                child: Container(
                  decoration: BoxDecoration( // Tint to contrast
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(220, 0, 0, 0),
                        Color.fromARGB(0, 0, 0, 0)
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                  // the top padding is to smooth out the tint
                  padding: EdgeInsets.fromLTRB(10.0, 50.0, 10.0, 10.0),
                  child: Text(
                    recipe.name,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          )
        ),
      ),
    );
  }

  /// Builds the view when the user has not favourited any recipes.
  Widget _buildEmptyView() {
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            AppStyle.buildEmptyViewIcon(Icons.favorite_border),
            SizedBox(height: 20),
            Text(
              "Nothing favourited yet",
              style: AppStyle.mediumHeader,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              "All the recipes that you've favourited will be shown here.",
              style: AppStyle.caption,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
