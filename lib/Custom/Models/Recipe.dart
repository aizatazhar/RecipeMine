import 'package:cloud_firestore/cloud_firestore.dart';

/// Enumerates the various types of recipes.
enum RecipeType {
  main,
  side,
  dessert,
  drink,
}

/// Extension to have a custom toString() method for enums.
extension RecipeTypeExtension on RecipeType {
  String get name {
    return this.toString().split(".").last;
  }
}

/// Models a recipe.
class Recipe {
  String id;
  String name;
  String authorUID;

  RecipeType type;
  double rating;
  int duration;
  int servingSize;
  String imageURL;

  List<dynamic> ingredients; // String array used for ingredient display only.
  List<dynamic> instructions;
  List<dynamic> smartTimer; // String array for creating timers for each step.
  List<dynamic> ratings; // Double array of all user ratings of the recipe.

  int numberOfMatchingQueries = 0;
  List<dynamic> queryIngredients; // String array used for querying only.

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

  /// Named constructor initialises a new Recipe object from the snapshot received
  /// from Firestore
  Recipe.fromDocumentSnapshot(DocumentSnapshot recipe) {
    this.id = recipe.documentID;
    this.name = recipe["name"];
    this.authorUID = recipe['authorUID'];
    this.type = RecipeType.values[recipe["type"]];
    this.rating = recipe["rating"];
    this.duration = recipe["duration"];
    this.servingSize = recipe["servingSize"];
    this.imageURL = recipe["imageURL"];
    this.ratings = new List<dynamic>.from(recipe['ratings']);
    this.ingredients = new List<String>.from(recipe["ingredients"]);
    this.instructions = new List<String>.from(recipe["instructions"]);
    this.smartTimer = new List<String>.from(recipe['smartTimer']);
    this.queryIngredients = recipe["queryIngredients"];
  }

  /// Returns the number of ingredients required for this recipe that the
  /// user has in their pantry.
  int numberOfIngredientsPresent(List<dynamic> pantry) {
    int result = 0;

    bool pantryContainsIngredient(String ingredient) {
      return pantry.any((pantryItem) {
        String pantryIngredient = pantryItem.split(",").first;
        return ingredient.contains(pantryIngredient.toLowerCase());
      });
    }

    for (String ingredient in ingredients) {
      if (pantryContainsIngredient(ingredient)) {
        result++;
      }
    }

    return result;
  }

  /// Calculates the relevance score of a recipe based off of various parameters.
  ///
  /// First normalise the parameters then multiply by a desired weight.
  double calculateRelevanceScore(List<dynamic> pantry) {
    double normalise(double value, double min, double max) {
      return (value - min) / (max - min);
    }

    return normalise(rating, 0, 5) * 0.3
      - normalise(duration.toDouble(), 0, 1000) * 0.2
      + normalise(numberOfIngredientsPresent(pantry).toDouble(), 0, ingredients.length.toDouble()) * 0.4
      - normalise(ingredients.length.toDouble(), 0, 100) * 0.1
      + normalise(numberOfMatchingQueries.toDouble(), 0, ingredients.length.toDouble()) * 0.5;
  }
}