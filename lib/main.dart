import "package:flutter/material.dart";
import 'package:recipemine/pages/Home/CookingAssistant/CookingAssistant.dart';
import 'package:recipemine/pages/Home/SearchPage/SearchPage.dart';
import 'package:recipemine/pages/SplashScreen.dart';
import "package:recipemine/pages/Authentication/Wrapper.dart";

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    routes: {
      "/": (context) => SplashScreen(),
      "/SearchPage": (context) => SearchPage(),
      "/CookingAssistant": (context) => CookingAssistant(recipe: null),
      "/AuthenticationWrapper" : (context) => Wrapper(),
    })
  );
}
