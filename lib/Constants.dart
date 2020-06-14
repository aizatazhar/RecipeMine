import 'package:flutter/material.dart';

// Constants class defines standard widgets for reusability and modification
class Constants {

  // ---------- Text styles ----------
  static Widget pageTitleDark(String text) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.black,
        fontSize: 20
      ),
    );
  }

  static Widget pageTitleLight(String text) {
    return Text(
      text,
      style: TextStyle(
          color: Colors.black,
          fontSize: 20
      ),
    );
  }

  static Widget paragraphTextDark(String text) {
    return Text(
      text,
      style: TextStyle(
          color: Colors.black,
          fontSize: 14
      ),
    );
  }

  static Widget paragraphTextLight(String text) {
    return Text(
      text,
      style: TextStyle(
          color: Colors.black,
          fontSize: 14
      ),
    );
  }

  static Widget listTitleDark(String text) {
    return Text(
      text,
      style: TextStyle(
          color: Colors.black,
          fontSize: 14,
          fontWeight: FontWeight.w500,
      ),
    );
  }

  static Widget listTitleLight(String text) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.black,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  static Widget listItemTitleDark(String text) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.black,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  static Widget listItemTitleLight(String text) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.black,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  // For secondary text such as captions, extra details, etc.
  static Widget secondaryTextDark(String text) {
    return Text(
      text,
      style: TextStyle(
        color: Color(0xff5F5F5F),
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  static Widget secondaryTextLight(String text) {
    return Text(
      text,
      style: TextStyle(
        color: Color(0xff5F5F5F),
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  // For user input such as forms
  static Widget textInputDark(String text) {
    return Text(
      text,
      style: TextStyle(
        color: Color(0xff5F5F5F),
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  static Widget textInputLight(String text) {
    return Text(
      text,
      style: TextStyle(
        color: Color(0xff5F5F5F),
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    );
  }


  // -------------------------------------------------

  // ---------- Buttons ----------


}

//For register and sign in only
const textInputDecoration = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  contentPadding: EdgeInsets.all(12.0),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 2.0),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.pink, width: 2.0),
  ),
);

