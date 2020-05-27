import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/search_bar_style.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: HomePage(),
//    routes: {
//      "/": (context) => LoadingScreen(),
//    }
  ));
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF1F1F1),
      body: SafeArea(
        child: SearchBar<Ingredient>(
          onSearch: this.search,
          onItemFound: (Ingredient ingredient, int index) {
            return Material(
              color: Colors.white,
              child: ListTile(
                contentPadding: EdgeInsets.fromLTRB(20.0, 0, 0, 0),
                title: Text(
                  ingredient.name,
                  style: TextStyle(
                    color: Color(0xff5F5F5F),
                    fontFamily: "SanFranciscoDisplay",
                    fontSize: 18.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            );
          },

          hintText: "type some ingredients",
          hintStyle: TextStyle(
            color: Color(0xff5F5F5F),
            fontFamily: "SanFranciscoDisplay",
            fontSize: 14.0,
            fontWeight: FontWeight.w400,
          ),

          searchBarPadding: EdgeInsets.symmetric(horizontal: 20.0),
          searchBarStyle: SearchBarStyle(
            backgroundColor: Colors.white,
            padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
          ),
          listPadding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),

          icon: Icon(
            Icons.search,
            color: Color(0xffFF464F),
          ),
        ),
      ),
    );
  }

  // spaghetti code/placeholder for searching an ingredient
  Future<List<Ingredient>> search(String item) async {
    await Future.delayed(Duration(seconds: 2));
    return List.generate(item.length, (int index) {
      return Ingredient(
        item,
      );
    });
  }

}

// spaghetti class for ingredients database (for searching)
class Ingredient {
  final String name;

  Ingredient(this.name);
}





