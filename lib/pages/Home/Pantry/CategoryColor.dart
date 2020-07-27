import "package:flutter/material.dart";

/// Simple class to return the colour of a category.
class CategoryColor {
  static Color get(String category) {
    if (category == 'Vegetable') {
      return Colors.green;
    } else if (category == 'Fish') {
      return Colors.lightBlueAccent;
    } else if (category == 'Meat') {
      return Colors.red;
    } else if (category == 'Grain') {
      return Colors.deepOrange;
    } else if (category == 'Fruit') {
      return Colors.purple;
    } else if (category == 'Condiment') {
      return Colors.yellowAccent[400];
    } else {
      return Colors.black;
    }
  }
}
