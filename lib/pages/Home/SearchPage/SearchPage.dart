import "package:carousel_slider/carousel_slider.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";
import "package:flappy_search_bar/flappy_search_bar.dart";
import "package:flappy_search_bar/search_bar_style.dart";
import "package:flutter_spinkit/flutter_spinkit.dart";
import "package:recipemine/Custom/Models/Ingredient.dart";
import 'package:recipemine/Custom/Models/Recipe.dart';
import 'DetailView.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  // Creates the body of the page
  StreamBuilder _buildBody() {
    const _iconSize = 22.0;

    // Builds the icons at the top of a slider
    Widget _buildIcon(IconData iconData, Color iconColor, String text) {
      return Row(
        children: <Widget> [
          Padding(
            padding: EdgeInsets.only(right: 2),
            child: Icon(
              iconData,
              color: iconColor,
              size: _iconSize,
            ),
          ),
          Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            ),
          ),
        ],
      );
    }

    // Builds the top section of a slider
    _buildTopSection(DocumentSnapshot recipe) {
      return Positioned( // Top icons
        top: 0.0,
        left: 0.0,
        right: 0.0,
        child: Container(
          decoration: BoxDecoration( // tint to contrast with icons
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(220, 0, 0, 0),
                Color.fromARGB(0, 0, 0, 0)
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          padding: EdgeInsets.fromLTRB(15, 0, 5, 20),
          child: Row(
            children: <Widget>[
              _buildIcon(Icons.star, Color(0xffFFC440), recipe["rating"].toString()),
              Spacer(),
              _buildIcon(Icons.schedule, Color(0xffFF5C64), recipe["duration"].toString() + " min"),
              Spacer(),
              _buildIcon(Icons.people_outline, Color(0xff30C551), recipe["servingSize"].toString()),
              Spacer(),
              _buildIcon(Icons.kitchen, Color(0xff1D92FF), "4/${recipe["ingredients"].length}"),
              Spacer(),
              IconButton(
                icon: Icon(
                  Icons.favorite_border,
                  color: Colors.white,
                ),
                iconSize: _iconSize,
                onPressed: () {
                  print("placeholder method for favouriting");
                },
              ),
            ],
          ),
        ),
      );
    }

    // Builds the bottom section of a slider
    _buildBottomSection(DocumentSnapshot recipe) {
      return Positioned( // Bottom text
        bottom: 0.0,
        left: 0.0,
        right: 0.0,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(220, 0, 0, 0),
                Color.fromARGB(0, 0, 0, 0)
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
          padding: EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 15.0),
          child: Text(
            recipe["name"],
            style: TextStyle(
              color: Colors.white,
              fontSize: 36.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }

    // Takes in a single recipe and builds its corresponding slider
    Widget _buildSlider(DocumentSnapshot recipe) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: Container(
          child: Stack(
            children: <Widget>[
              Image.asset(
                recipe["imageURL"],
                fit: BoxFit.cover,
                width: 1000,
                height: 1000
              ),
              _buildTopSection(recipe),
              _buildBottomSection(recipe),
            ],
          ),
        ),
      );

    }

    // Main Builder that reads and updates data in real time from Firestore
    return StreamBuilder(
        stream: Firestore.instance.collection("Recipes").snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return SpinKitFadingCircle(color: Colors.blueGrey);
          }

          int recipesLength = snapshot.data.documents.length;

          // Reading recipes from Firestore
          List<DocumentSnapshot> recipes = [];
          for (int i = 0; i < recipesLength; i++) {
            recipes.add(snapshot.data.documents[i]);
          }

          return SearchBar<Ingredient>(
            hintText: "type some ingredients",
            hintStyle: TextStyle(
              color: Color(0xff5F5F5F),
              fontSize: 14.0,
            ),

            searchBarPadding: EdgeInsets.symmetric(horizontal: 20.0),
            searchBarStyle: SearchBarStyle(
              backgroundColor: Colors.grey[100],
              padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
            ),

            onSearch: search,
            onItemFound: (Ingredient ingredient, int index) {
              return CarouselSlider.builder(
                options: CarouselOptions(
                  aspectRatio: 0.8,
                  enlargeCenterPage: true,
                  enableInfiniteScroll: false,
                ),
                itemCount: recipesLength,
                itemBuilder: (BuildContext context, int itemIndex) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => DetailView(
                            Recipe.fromDocumentSnapshot(recipes[itemIndex])
                          )
                      ));
                    },
                    child: _buildSlider(recipes[itemIndex]),
                  );
                }
              );
            },
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _buildBody()
    );
  }

  // Placeholder method for searching
  Future<List<Ingredient>> search(String item) async {
    List<Ingredient> eggs = [];
    eggs.add(Ingredient(
        name: "French Omelette"));
    await Future.delayed(Duration(seconds: 1));
    return eggs;
  }
}
