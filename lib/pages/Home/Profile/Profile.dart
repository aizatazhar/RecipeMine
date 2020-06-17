

import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:recipemine/Custom/Models/ReciperMinerUser.dart';
import 'package:recipemine/Custom/Models/User.dart';
import 'package:recipemine/pages/Authentication/Services/Auth.dart';
import 'ProfileSettings.dart';
class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {






  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();
    final users = Provider.of<List<RecipeMiner>>(context) ?? [];
    final currentUserUID = Provider.of<User>(context);



    //contains the currentuser details
    RecipeMiner currentUserData = RecipeMiner(name:'Loading',email: 'Loading',uid: 'Loading', profilePic: 'https://moonvillageassociation.org/wp-content/uploads/2018/06/default-profile-picture1.jpg');
    users.forEach((element) {
      if(element.uid == currentUserUID.uid){
        currentUserData = element;
      }
    });
    //currentuser details fields
    String name = currentUserData.name ?? '';
    String email = currentUserData.email ?? '';
    String profilePic = currentUserData.profilePic ?? 'https://moonvillageassociation.org/wp-content/uploads/2018/06/default-profile-picture1.jpg';





    return Scaffold(
      body:Column(
          children: <Widget>[
            SizedBox(height:50),
            CircleAvatar(
                radius: 75,
                backgroundColor: Colors.pink,
                child: ClipOval(
                  child: new SizedBox(
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
            SizedBox(height:30),
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                showModalBottomSheet(context: context, isScrollControlled: true, builder: (context) {
                  return Container(
                    padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
                    child: SettingsForm(),
                  );
                });
              },
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
                        child: Text(name,
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
                        child: Text(email,
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
            SizedBox(height: 25),
            RaisedButton(
                color: Colors.pink[400],
                child: Text(
                  'Logout',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  _auth.signOut();
                }
            ),
          ]
      ),
    );
  }
}
