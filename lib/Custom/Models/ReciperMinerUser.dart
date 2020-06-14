import 'package:recipemine/Custom/Models/PantryIngredient.dart';

class RecipeMiner{
  final String name;
  final String email;
  final String uid;
  final String ProfilePic;
  final List<String> Pantry;

  RecipeMiner({this.name, this.email, this.uid, this.ProfilePic, this.Pantry});
  @override
  String toString() {
    return name + ' ' + email;
  }
}