import "package:flutter/material.dart";
import 'PantryAdder.dart';
import 'PantryList.dart';

class Pantry extends StatefulWidget {
  @override
  _PantryState createState() => _PantryState();
}

class _PantryState extends State<Pantry> {

  @override
  Widget build(BuildContext context) {

    //Contains current User's pantry
    return Scaffold(
      body: PantryList(),
      bottomNavigationBar: RaisedButton(
        color: Colors.redAccent,
        child:Text("Add more ingredients",
          style: TextStyle(color: Colors.white),
        ),
        onPressed: (){
          showModalBottomSheet(context: context,isScrollControlled: true, builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              color: Colors.red[50],
              child: PantryAdder(),
            );
          });
        },
      ),
    );
  }
}

// .contains works so just store a list of ingredients.
// Ingredient, Name, quantity
// list of ingredients within the user class