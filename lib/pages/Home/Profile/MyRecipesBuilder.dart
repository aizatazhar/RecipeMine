import 'package:flutter/material.dart';
import 'package:recipemine/Custom/Models/Recipe.dart';
import 'package:recipemine/Custom/Models/ReciperMinerUser.dart';
import 'package:recipemine/pages/Home/SearchPage/DetailView.dart';

import '../../../AppStyle.dart';

class MyRecipes extends StatefulWidget {
  final RecipeMiner user;
  final List<Recipe> recipeList;
  final Function onBeginCooking;

  MyRecipes({this.user, this.recipeList, @required this.onBeginCooking});

  @override
  _MyRecipesState createState() => _MyRecipesState();
}

class _MyRecipesState extends State<MyRecipes> {
  @override
  Widget build(BuildContext context) {
    final currentUserUID = widget.user.uid;

    // contains the current user details
    List<Recipe> recipeList = widget.recipeList;
    List<Recipe> filteredList = [];
    for (Recipe recipe in recipeList){
      if (recipe.authorUID == widget.user.email) {
        filteredList.add(recipe);
      }
    }

    int recipesLength = filteredList.length;

    return recipesLength > 0
        ? _buildMyRecipesView(filteredList, widget.user)
        : _buildEmptyView();
  }

  Widget _buildMyRecipesView(List<Recipe> filteredList, RecipeMiner currentUserData) {
    int recipesLength = filteredList.length;

    return GridView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.65,
        ),
        itemCount: recipesLength,
        itemBuilder: (BuildContext context, int index) {
          return _buildCard(filteredList[index], currentUserData);
        }
    );
  }

  Widget _buildCard(Recipe recipe, RecipeMiner currentUser) {
    RecipeMiner user = currentUser;

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

  Widget _buildEmptyView() {
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            AppStyle.buildEmptyViewIcon(Icons.edit),
            SizedBox(height: 20),
            Text(
              "No recipes contributed yet",
              style: AppStyle.mediumHeader,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              "All recipes contributed will be shown here.",
              style: AppStyle.caption,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
