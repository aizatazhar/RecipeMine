import "package:flutter/material.dart";
import 'file:///C:/Users/John/Downloads/Orbital/MyFork/RecipeMine/lib/pages/Home/SearchPage/SearchPage.dart';
import 'file:///C:/Users/John/Downloads/Orbital/MyFork/RecipeMine/lib/pages/Home/CookingAssistant/CookingAssistant.dart';
import 'package:recipemine/pages/SplashScreen.dart';
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


