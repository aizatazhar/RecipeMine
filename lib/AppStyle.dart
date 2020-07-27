import 'package:flappy_search_bar/search_bar_style.dart';
import "package:flutter/material.dart";

/// Class that contains the standardised style of the app.
class AppStyle {
  // ----- TextStyle -----
  static final caption = TextStyle(
    color: Colors.grey[700],
    fontSize: 16,
  );

  static final subtitle = TextStyle(
    fontSize: 16,
  );

  static final mediumHeader = TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.w500,
  );

  static final largeHeader = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 42,
  );

  static final clickableCaption = TextStyle(
      color: Colors.redAccent,
      fontSize: 16,
      fontWeight: FontWeight.w500
  );

  static final userDetail = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  static final assistantHeader = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: Colors.redAccent,
  );

  static final assistantTitle = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );


  // ----- InputDecoration -----
  static final signInDecoration = InputDecoration(
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.redAccent, width: 2),
    ),
    hintStyle: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: Colors.grey,
    ),
  );

  static final registerDecoration = InputDecoration(
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.redAccent, width: 2),
    ),
    hintStyle: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: Colors.grey,
    ),
    floatingLabelBehavior: FloatingLabelBehavior.always,
  );

  static final pantryInputDecoration = InputDecoration(
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.redAccent, width: 2.0),
    ),
    fillColor: Colors.white,
    filled: true,
    floatingLabelBehavior: FloatingLabelBehavior.always
  );


  // ----- SearchBarStyle -----
  static final searchBarStyle = SearchBarStyle(
    borderRadius: BorderRadius.circular(10),
    backgroundColor: Colors.white,
    padding: EdgeInsets.only(left: 10)
  );

  static final searchBarHintStyle = TextStyle(
    color: Color(0xff5F5F5F),
    fontSize: 14.0,
  );


  // ----- Icon -----
  static Widget buildEmptyViewIcon(IconData icon) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        border: Border.all(width: 3, color: Colors.red),
      ),
      child: Icon(
        icon,
        color: Colors.red,
        size: 50,
      ),
    );
  }
}





