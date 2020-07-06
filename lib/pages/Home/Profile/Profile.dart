import 'package:flutter/gestures.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:recipemine/Custom/Models/ReciperMinerUser.dart';
import 'package:recipemine/Custom/Models/User.dart';
import 'package:recipemine/pages/Authentication/Services/Auth.dart';
import '../../../AppStyle.dart';
import 'SettingsForm.dart';

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
                  Text(
                    'Username',
                    style: AppStyle.caption,
                  ),
                  Text(
                    name,
                    style: AppStyle.userDetail,
                  ),
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
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) {
                  return SettingsForm();
                }
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLogOutButton(AuthService authService) {
    return Container(
      height: 50,
      width: double.maxFinite,
      child: RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: Colors.redAccent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Log out",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
        onPressed: () async {
          authService.signOut();
        },
      ),
    );
  }
}
