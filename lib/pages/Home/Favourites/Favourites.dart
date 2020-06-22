import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:recipemine/Custom/Models/Recipe.dart';
import 'package:recipemine/Custom/Models/ReciperMinerUser.dart';
import 'package:recipemine/Custom/Models/User.dart';
import 'package:recipemine/pages/Home/FireBase/Database.dart';

class Favourites extends StatefulWidget {
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

    final users = Provider.of<List<RecipeMiner>>(context) ?? [];
    final currentUserUID = Provider.of<User>(context);
    //contains the currentuser details
    RecipeMiner currentUserData = RecipeMiner(name:'Loading',email: 'Loading',uid: 'Loading', profilePic: 'https://moonvillageassociation.org/wp-content/uploads/2018/06/default-profile-picture1.jpg', favourites: []);
    users.forEach((element) {
      if(element.uid == currentUserUID.uid){
        currentUserData = element;
      }
    });


    List<Recipe> recipeList = Provider.of<List<Recipe>>(context) ?? [];
    List<Recipe> filteredList = [];
    for(Recipe recipe in recipeList){
      if(currentUserData.favourites.contains(recipe.id)){
        filteredList.add(recipe);
      }
    }


    int recipesLength = filteredList.length;

      return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 0.65,
          ),
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          itemCount: recipesLength,
          itemBuilder: (BuildContext context, int index) {
            return _buildCard(filteredList[index], currentUserData);
          }
      );
  }

  Widget _buildCard(Recipe recipe, RecipeMiner currentUser) {
    RecipeMiner user = currentUser;
    Color heartColour = user.favourites.contains(recipe.id) ? Colors.red : Colors.white;
    Icon icon = user.favourites.contains(recipe.id) ? Icon(Icons.favorite) : Icon(Icons.favorite_border);
    return GestureDetector(
      onTap: () {
        print("placeholder method for clicking on favourite recipe");
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 0.0),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
          child: Stack(
            children: <Widget>[
              Image.asset(
                recipe.imageURL != "" ? recipe.imageURL : "assets/default.jpg",
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
                    DatabaseService().updateUserData(user.name, user.email, user.uid, user.profilePic, user.pantry,user.favourites);
                  },
                  icon: icon,
                  color: heartColour,
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
                      fontSize: 14.0,
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
}
