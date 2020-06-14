
import "Ingredient.dart";


enum RecipeType {
  main,
  side,
  dessert,
  drink,
}

// Recipe class models a recipe
class Recipe {
  final int id;
  final String name;

  final RecipeType type;
  final double rating;
  final int duration;
  final int servingSize;
  final String imageURL;

  final List<String> ingredients;
  final List<String> instructions;

  Recipe({
    this.id,
    this.name,

    this.type,
    this.rating,
    this.duration,
    this.servingSize,
    this.imageURL,

    this.ingredients,
    this.instructions
  });

  // Named constructor that deserialises data received from Firestore
  // and initialises a new Recipe object
  Recipe.fromMap(Map<String, dynamic> data, int id)
      : this(
          id: id,
          name: data["name"],

          type: RecipeType.values[data["type"]],
          rating: data["recipe"],
          duration: data["duration"],
          servingSize: data["servingSize"],
          imageURL: data["imageURL"],

          ingredients: List<String>.from(data["ingredients"]),
          instructions: List<String>.from(data["instructions"]),
  );
}