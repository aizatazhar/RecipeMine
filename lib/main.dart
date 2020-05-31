import "package:flutter/material.dart";
import "package:recipemine/pages/HomePage.dart";
import "package:recipemine/pages/CookingAssistant.dart";
import "package:recipemine/pages/LoadingScreen.dart";

void main() {
  runApp(MaterialApp(routes: {
    "/": (context) => LoadingScreen(),
    "/homePage": (context) => HomePage(),
    "/CookingAssistant": (context) => CookingAssistant(),
  }));
}


