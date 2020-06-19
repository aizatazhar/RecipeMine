import 'package:cloud_firestore/cloud_firestore.dart';

enum RecipeType {
  main,
  side,
  dessert,
  drink,
}

// Recipe class models a recipe
class Recipe {
  String id;
  String name;

  RecipeType type;
  double rating;
  int duration;
  int servingSize;
  String imageURL;

  List<dynamic> ingredients;
  List<dynamic> instructions;
  List<dynamic> smartTimer;

  Recipe({
    this.id,
    this.name,

    this.type,
    this.rating,
    this.duration,
    this.servingSize,
    this.imageURL,

    this.ingredients,
    this.instructions,
    this.smartTimer,
  });

  // Named constructor that deserialises data received from Firestore
  // and initialises a new Recipe object
  Recipe.fromDocumentSnapshot(DocumentSnapshot recipe) {
    this.id = recipe.documentID;
    this.name = recipe["name"];
    this.type = RecipeType.values[recipe["type"]];
    this.rating = recipe["rating"];
    this.duration = recipe["duration"];
    this.servingSize = recipe["servingSize"];
    this.imageURL = recipe["imageURL"];
    this.ingredients = new List<String>.from(recipe["ingredients"]);
    this.instructions = new List<String>.from(recipe["instructions"]);
    this.smartTimer = new List<String>.from(recipe['smartTimer']);
  }
}