import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:recipemine/Custom/Models/Recipe.dart';
import 'package:recipemine/Custom/CustomWidgets/MainButton.dart';
import 'package:recipemine/Custom/Models/ReciperMinerUser.dart';
import 'package:recipemine/Custom/Models/User.dart';
import 'package:recipemine/pages/Authentication/Services/Auth.dart';
import 'package:recipemine/pages/Home/Profile/MyRecipesBuilder.dart';
import 'package:recipemine/pages/Home/Profile/RecipeBuilder/RecipeBuilder.dart';
import '../../../AppStyle.dart';
import 'SettingsForm.dart';

/// Builds the user's profile page.
class Profile extends StatefulWidget {
  final Function onBeginCooking;

  Profile({@required this.onBeginCooking});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();
    final users = Provider.of<List<RecipeMiner>>(context) ?? [];
    final currentUserUID = Provider.of<User>(context);
    List<Recipe> recipeList = Provider.of<List<Recipe>>(context) ?? [];

    // contains the current user details
    RecipeMiner currentUserData = RecipeMiner(
        name: 'Loading',
        email: 'Loading',
        uid: 'Loading',
        profilePic: 'https://moonvillageassociation.org/wp-content/uploads/2018/06/default-profile-picture1.jpg'
    );

    users.forEach((element) {
      if (element.uid == currentUserUID.uid) {
        currentUserData = element;
      }
    });

    // current user details fields
    String name = currentUserData.name ?? '';
    String email = currentUserData.email ?? '';
    String profilePic = currentUserData.profilePic ?? 'https://moonvillageassociation.org/wp-content/uploads/2018/06/default-profile-picture1.jpg';

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildAvatar(profilePic),
              SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Username', style: AppStyle.caption),
                  Text(name, style: AppStyle.userDetail),
                ],
              ),
              SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Email',
                    style: AppStyle.caption,
                  ),
                  Text(
                    email,
                    style: AppStyle.userDetail,
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text('Your recipes', style: AppStyle.caption),
              MyRecipes(
                user: currentUserData,
                recipeList: recipeList,
                onBeginCooking: this.widget.onBeginCooking,
              ),
              SizedBox(height: 20),
              _buildRecipeMakerButton(currentUserData),
              SizedBox(height: 20),
              _buildLogOutButton(_auth),
            ]
          ),
        ),
      ),
    );
  }

  Widget _buildAvatar(String profilePic) {
    return Center(
      child: Column(
        children: <Widget> [
          CircleAvatar(
            radius: 75,
            child: ClipOval(
              child: SizedBox(
                width: 150.0,
                height: 150.0,
                child: Image.network(
                  profilePic,
                  fit: BoxFit.cover,
                  width: 1000,
                  height: 1000,
                ),
              ),
            ),
          ),
          SizedBox(height: 5),
          RaisedButton(
            child: Text(
              "Edit profile",
              style: TextStyle(
                color: Colors.grey[800],
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(color: Colors.grey, width: 0.5),
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                  builder: (BuildContext context) => SettingsForm()
              ));
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLogOutButton(AuthService authService) {
    return MainButton(
      child: Text(
        "Log out",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      width: double.maxFinite,
      onPressed: () async {
        authService.signOut();
      },
    );
  }

  Widget _buildRecipeMakerButton(RecipeMiner currentUserData){
    return Center(
      child: Container(
        child: RaisedButton(
          child: Text(
            "Contribute a recipe!",
            style: TextStyle(
              color: Colors.grey[800],
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(color: Colors.grey, width: 0.5),
          ),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (BuildContext context) => StatefulBuilder(
                builder: (BuildContext context, StateSetter setState /*You can rename this!*/) {
                  return RecipeBuilder(currentUser: currentUserData);
                }
              )
            ));
          }
        ),
      ),
    );
  }
}
