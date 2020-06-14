import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";
import "package:recipemine/pages/Authentication/Services/Auth.dart";
import "package:provider/provider.dart";
import "package:recipemine/pages/Home/FireBase/Database.dart";

import "CookingAssistant/CookingAssistant.dart";
import "Favourites/Favourites.dart";
import "Pantry/Pantry.dart";
import "Profile/Profile.dart";
import "SearchPage/SearchPage.dart";

//HomeWrapper class used to house the bottom navigation bar and app bar.
class HomeWrapper extends StatefulWidget {
  @override
  _HomeWrapperState createState() => _HomeWrapperState();
}

class _HomeWrapperState extends State<HomeWrapper> {
  int navigationIndex = 0;
  final AuthService _auth = AuthService();
  final tabs = [
    Center(child: SearchPage()),
    Center(child: CookingAssistant()),
    Center(child: Favourites()),
    Center(child: Pantry()),
    Center(child: Profile()),
  ];

  final appBarNames = [
    Text("Search Page"),
    Text("CookingAssistant"),
    Text("Favourites"),
    Text("Pantry"),
    Text("Profile"),
  ];

  BottomNavigationBarItem _buildBottomNavigationBarItem(Icon icon, String title) {
    return BottomNavigationBarItem(
      icon: icon,
      title: Text(title));
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<QuerySnapshot>.value(
      value: DatabaseService().DB,
      child: Scaffold(
        appBar: AppBar(
          title: appBarNames[navigationIndex],
          titleSpacing: 20.0,
          backgroundColor: Color(0xffFF464F),
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person, color: Colors.white),
              label: Text(
                "logout",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20
                ),
              ),
              onPressed: () async {
                await _auth.signOut();
              },
            ),
          ],
        ),
        backgroundColor: Colors.white,
        body: tabs[navigationIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.grey[100],
          selectedItemColor: Color(0xffFF464F),
          currentIndex: navigationIndex,
          items: <BottomNavigationBarItem> [
            _buildBottomNavigationBarItem(Icon(Icons.search), "Search"),
            _buildBottomNavigationBarItem(Icon(Icons.whatshot), "Assistant"),
            _buildBottomNavigationBarItem(Icon(Icons.favorite), "Favourites"),
            _buildBottomNavigationBarItem(Icon(Icons.kitchen), "Pantry"),
            _buildBottomNavigationBarItem(Icon(Icons.group), "Community"),
          ],
          onTap: (index) {
            setState(() {navigationIndex = index;});
          }
        )
      ),
    );
  }
}
