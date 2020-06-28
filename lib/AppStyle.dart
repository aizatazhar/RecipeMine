import 'package:flappy_search_bar/search_bar_style.dart';
import "package:flutter/material.dart";

class AppStyle {
  // Used for register and sign in
  static final textInputDecoration = InputDecoration(
    fillColor: Colors.white,
    filled: true,
    contentPadding: EdgeInsets.all(12.0),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey, width: 2.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.pink, width: 2.0),
    ),
  );

  static final searchBarStyle = SearchBarStyle(
    borderRadius: BorderRadius.circular(10),
    backgroundColor: Colors.white,
    padding: EdgeInsets.only(left: 10)
  );

  static final searchBarHintStyle = TextStyle(
    color: Color(0xff5F5F5F),
    fontSize: 14.0,
  );
}





