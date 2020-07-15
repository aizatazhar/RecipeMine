import 'package:cloud_firestore/cloud_firestore.dart';

enum RecipeType {
  main,
  side,
  dessert,
  drink,
}

extension RecipeTypeExtension on RecipeType {
  String get name {
    return this.toString().split(".").last;
  }
}

// Recipe class models a recipe
class Recipe {
  String id;
  String name;
  String authorUID;

  RecipeType type;
  double rating;
  int duration;
  int servingSize;
  String imageURL;

  List<dynamic> ingredients;
  List<dynamic> instructions;
  List<dynamic> smartTimer;
  List<dynamic> ratings;

  Recipe({
    this.id,
    this.name,
    this.authorUID,

    this.type,
    this.rating,
    this.duration,
    this.servingSize,
    this.imageURL,

    this.ratings,
    this.ingredients,
    this.instructions,
    this.smartTimer,
  });

  // Named constructor that deserialises data received from Firestore
  // and initialises a new Recipe object
  Recipe.fromDocumentSnapshot(DocumentSnapshot recipe) {
    this.id = recipe.documentID;
    this.name = recipe["name"];
    this.authorUID = recipe['authorUID'];
    this.type = RecipeType.values[recipe["type"]];
    this.rating = recipe["rating"];
    this.duration = recipe["duration"];
    this.servingSize = recipe["servingSize"];
    this.imageURL = recipe["imageURL"];
    this.ratings = new List<int>.from(recipe['ratings']);
    this.ingredients = new List<String>.from(recipe["ingredients"]);
    this.instructions = new List<String>.from(recipe["instructions"]);
    this.smartTimer = new List<String>.from(recipe['smartTimer']);
  }

}