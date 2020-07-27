import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:recipemine/Custom/Models/Recipe.dart';
import 'package:recipemine/Custom/Models/ReciperMinerUser.dart';
import 'package:recipemine/pages/Home/Community/Community.dart';
import 'package:recipemine/pages/Home/CookingAssistant/CookingAssistant.dart';
import 'package:recipemine/pages/Home/FireBase/Database.dart';
import 'Favourites/Favourites.dart';
import 'Pantry/Pantry.dart';
import 'Profile/Profile.dart';
import 'SearchPage/SearchPage.dart';

// HomeWrapper class houses the bottom navigation bar and app bar.
class HomeWrapper extends StatefulWidget {
  @override
  _HomeWrapperState createState() => _HomeWrapperState();
}

class _HomeWrapperState extends State<HomeWrapper> {

  int bottomNavigationBarIndex = 0;
  int navigationIndex = 0;

  String name;
  String email;

  Recipe recipe;

  List<Widget> _buildPages() {
    return [
      SearchPage(onBeginCooking: onBeginCooking),
      CookingAssistant(recipe: recipe),
      Favourites(onBeginCooking: onBeginCooking),
      Pantry(),
      Community(onBeginCooking: communityOnBeginCooking),
      Profile(onBeginCooking: onBeginCooking)
    ];
  }

  List<Widget> _buildAppBarTitles() {
    return [
      Text('Search'),
      Text('Assistant'),
      Text('Favourites'),
      Text('Pantry'),
      Text('Community'),
      Text('Your Details')
    ];
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<List<RecipeMiner>>.value(value: DatabaseService().DBusers),
        StreamProvider<List<Recipe>>.value(value: DatabaseService().recipeData),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: _buildAppBarTitles()[navigationIndex],
          titleSpacing: 20.0,
          backgroundColor: Colors.redAccent,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person, color: Colors.white),
              label: Text(
                'Profile',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20
                ),
              ),
              onPressed: () async {
                setState(() {
                  navigationIndex = 5;
                });
              },
            ),
          ],
        ),
        backgroundColor: Colors.white,
        body: IndexedStack(
          index: navigationIndex,
          children: _buildPages()
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.grey[100],
          selectedItemColor: Color(0xffFF464F),
          currentIndex: bottomNavigationBarIndex,
          items: <BottomNavigationBarItem> [
            BottomNavigationBarItem(icon: Icon(Icons.search), title: Text("Search")),
            BottomNavigationBarItem(icon: Icon(Icons.whatshot), title: Text("Assistant")),
            BottomNavigationBarItem(icon: Icon(Icons.favorite), title: Text("Favourites")),
            BottomNavigationBarItem(icon: Icon(Icons.kitchen), title: Text("Pantry")),
            BottomNavigationBarItem(icon: Icon(Icons.group), title: Text("Community")),
          ],
          onTap: (index) {
            setState(() {
              bottomNavigationBarIndex = index;
              navigationIndex = index;
            });
          }
        )
      ),
    );
  }

  void onBeginCooking(Recipe recipe) {
    setState(() {
      bottomNavigationBarIndex = 1;
      navigationIndex = 1;
      this.recipe = recipe;
      Navigator.of(context).pop();
    });
  }

  void communityOnBeginCooking(Recipe recipe) {
    // requires popping navigation twice
    setState(() {
      bottomNavigationBarIndex = 1;
      navigationIndex = 1;
      this.recipe = recipe;
      Navigator.of(context).pop();
      Navigator.of(context).pop();
    });
  }
}

