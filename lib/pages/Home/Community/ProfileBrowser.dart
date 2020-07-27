import 'package:flutter/material.dart';
import 'package:recipemine/Custom/Models/Recipe.dart';
import 'package:recipemine/Custom/Models/ReciperMinerUser.dart';
import 'package:recipemine/pages/Home/Profile/MyRecipesBuilder.dart';
import '../../../AppStyle.dart';
import '../../Loading.dart';

/// Builds the page when clicking on a user.
class ProfileBrowser extends StatelessWidget {
  final RecipeMiner viewedUser;
  final List<Recipe> recipeList;
  final Function onBeginCooking;

  ProfileBrowser({this.viewedUser, this.recipeList, @required this.onBeginCooking});

  @override
  Widget build(BuildContext context) {
    if (viewedUser != null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Currently viewing: ' + viewedUser.name),
          titleSpacing: 20.0,
          backgroundColor: Color(0xffFF464F),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 40),
                Center(
                  child: CircleAvatar(
                    radius: 75,
                    backgroundColor: Colors.pink,
                    child: ClipOval(
                      child: new SizedBox(
                        width: 150.0,
                        height: 150.0,
                        child: Image.network(
                          viewedUser.profilePic,
                          fit: BoxFit.cover,
                          width: 1000,
                          height: 1000,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Column(
                  children: <Widget>[
                    Text('Username', style: AppStyle.caption),
                    Text(viewedUser.name, style: AppStyle.userDetail),
                  ],
                ),
                SizedBox(height: 10),
                Text('User Recipes', style: AppStyle.caption),
                MyRecipes(
                  user: viewedUser,
                  recipeList: recipeList,
                  onBeginCooking: onBeginCooking,
                ),
                SizedBox(height: 20),
              ]
            ),
          ),
        ),
      );
    } else {
      return Loading();
    }
  }
}
