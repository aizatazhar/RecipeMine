import 'package:flutter/material.dart';

class IngredientTile extends StatelessWidget {

  final String ingredient;
  final List<dynamic> ingredients;
  final int index;

  IngredientTile({this.ingredient, this.ingredients, this.index});

  @override
  Widget build(BuildContext context) {
    List<String> splitIngredients = ingredient.split(",");
    String numericalQuantity = splitIngredients[0];
    String units = splitIngredients[1];
    String name = splitIngredients[2];

    return Card(
      margin: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
      child: ListTile(
        title: Text(name),
        subtitle: Text('Quantity: ' + numericalQuantity + " " + units),
      ),
    );
  }
}