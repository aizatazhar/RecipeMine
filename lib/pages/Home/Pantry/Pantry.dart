import "package:flutter/material.dart";
class Pantry extends StatefulWidget {
  @override
  _PantryState createState() => _PantryState();
}

class _PantryState extends State<Pantry> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Text('Pantry')
      ),
    );
  }
}


//.contains works so just store a list of ingredients.
//Ingredient, Name, quantity
//list of ingredients within the user class
