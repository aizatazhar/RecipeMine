import "package:flutter/material.dart";
import "package:recipemine/pages/Home/HomePage.dart";
import 'file:///C:/Users/John/Downloads/Orbital/RecipeMine/lib/pages/Home/CookingAssistant.dart';
import 'file:///C:/Users/John/Downloads/Orbital/RecipeMine/lib/pages/SplashScreen.dart';
import "package:recipemine/Custom/CustomWidgets/TimerWidget.dart";
import 'package:recipemine/pages/Authentication/Wrapper.dart';



void main() {
  runApp(MaterialApp(routes: {
    "/": (context) => LoadingScreen(),
    "/SearchPage": (context) => SearchPage(),
    "/CookingAssistant": (context) => CookingAssistant(),
    "/CountDown" : (context) => CountDown(),
    "/AuthenticationWrapper" : (context) => Wrapper(),

  }));
}


