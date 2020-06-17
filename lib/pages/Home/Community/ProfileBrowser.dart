import 'package:flutter/material.dart';
import 'package:recipemine/Custom/Models/Recipe.dart';
import 'package:recipemine/Custom/Models/ReciperMinerUser.dart';
import 'package:recipemine/pages/Home/Profile/Profile.dart';
import '../../LoadingScreen.dart';
import '../HomeWrapper.dart';

// ignore: must_be_immutable
class ProfileBrowser extends StatelessWidget {
  RecipeMiner viewedUser;

  ProfileBrowser(RecipeMiner user) {
    viewedUser = user;
  }

  @override
  Widget build(BuildContext context) {
    if (viewedUser != null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Currently Viewing: ' + viewedUser.name),
          titleSpacing: 20.0,
          backgroundColor: Color(0xffFF464F),
        ),
        body: SingleChildScrollView(
          child: Column(
              children: <Widget>[
                SizedBox(height: 50),
                CircleAvatar(
                  radius: 75,
                  backgroundColor: Colors.pink,
                  child: ClipOval(
                    child: new SizedBox(
                      width: 150.0,
                      height: 150.0,
                      child: Image.network(
                        viewedUser.profilePic,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: Column(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Username',
                                style: TextStyle(
                                    color: Colors.blueGrey, fontSize: 18.0)),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(viewedUser.name,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: Column(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Email',
                                style: TextStyle(
                                    color: Colors.blueGrey, fontSize: 18.0)),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(viewedUser.email,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ]
          ),
        ),
      );
    } else {
      Loading();
    }
  }
}
