import 'package:carousel_slider/carousel_slider.dart';
import "package:flutter/material.dart";
import "package:flappy_search_bar/flappy_search_bar.dart";
import "package:flappy_search_bar/search_bar_style.dart";
import 'package:recipemine/pages/Authentication/Services/Auth.dart';
import 'package:recipemine/pages/Home/CookingAssistant/CookingAssistant.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  final List<String> images = [
    "assets/Recipe 1.jpg",
    "assets/Recipe 2.jpg",
    "assets/Recipe 3.jpg",
    "assets/Recipe 4.jpg",
    "assets/Recipe 5.jpg",
  ];

  // Takes in a list of image urls and maps each url into a slider
  List<Widget> createImageSliders() {
    List<Widget> imageSliders = images.map((image) => Container(
      margin: EdgeInsets.fromLTRB(5.0, 20.0, 5.0, 0.0),
      child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          child: Stack(
            children: <Widget>[
              Image.asset(image, fit: BoxFit.cover, width: 1000, height: 1000),
              Positioned( // Top icons
                top: 0.0,
                left: 0.0,
                right: 0.0,
                child: Container(
                  decoration: BoxDecoration( // Tint to contrast
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(220, 0, 0, 0),
                        Color.fromARGB(0, 0, 0, 0)
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  // the bottom padding is to smooth out the tint
                  padding: EdgeInsets.fromLTRB(15, 0, 5, 75),
                  child: Row(
                    children: <Widget>[
                      Row(
                        children: <Widget> [
                          Padding(
                            padding: EdgeInsets.only(right: 2.5),
                            child: Icon(
                              Icons.star,
                              color: Color(0xffFFC440),
                              size: 22.0,
                            ),
                          ),
                          Text(
                            "4.9",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                      Spacer(flex: 1),
                      Row(
                        children: <Widget> [
                          Padding(
                            padding: EdgeInsets.only(right: 2.5),
                            child: Icon(
                              Icons.schedule,
                              color: Color(0xffFF5C64),
                              size: 22.0,
                            ),
                          ),
                          Text(
                            "45 min",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                      Spacer(flex: 1),
                      Row(
                        children: <Widget> [
                          Padding(
                            padding: EdgeInsets.only(right: 2.5),
                            child: Icon(
                              Icons.people_outline,
                              color: Color(0xff30C551),
                              size: 22.0,
                            ),
                          ),
                          Text(
                            "2",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                      Spacer(flex: 1),
                      Row(
                        children: <Widget> [
                          Padding(
                            padding: EdgeInsets.only(right: 2.5),
                            child: Icon(
                              Icons.kitchen,
                              color: Color(0xff1D92FF),
                              size: 22.0,
                            ),
                          ),
                          Text(
                            "4/6",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                      Spacer(flex: 2),
                      IconButton(
                        icon: Icon(
                          Icons.favorite_border,
                          color: Colors.white,
                        ),
                        iconSize: 22.0,
                        onPressed: () {
                          print("placeholder method for favouriting");
                        },
                      ),
                    ],
                  ),
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
                  padding: EdgeInsets.fromLTRB(15.0, 75.0, 15.0, 15.0),
                  child: Text(
                    "${image.substring(7, 15)}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          )
      ),
    )).toList();

    return imageSliders;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SearchBar<Ingredient>(
        onSearch: search,
        onItemFound: (Ingredient ingredient, int index) {
          List<Widget> imageSliders = createImageSliders();
          return Container(
              child: Column(
                children: <Widget>[
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, new MaterialPageRoute(
                          builder: (context) =>
                          new CookingAssistant())
                      );
                    },
                    child: CarouselSlider(
                      options: CarouselOptions(
                        aspectRatio: 0.8,
                        enlargeCenterPage: true,
                        enableInfiniteScroll: false,
                      ),
                      items: imageSliders,
                    ),
                  ),
                ],
              )
          );
        },
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
        listPadding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
        icon: Icon(
          Icons.search,
          color: Color(0xffFF464F),
        ),
      ),
    );
  }

  Future<List<Ingredient>> search(String item) async {
    List<Ingredient> eggs = [];
    eggs.add(Ingredient("French Omelette"));
    await Future.delayed(Duration(seconds: 1));
    return eggs;
  }
}

// spaghetti class for ingredients database (for searching)
class Ingredient {
  final String name;
  Ingredient(this.name);
}
