import 'package:flutter/material.dart';
import 'package:recipemine/Custom/Models/ReciperMinerUser.dart';
import 'package:recipemine/pages/Home/Profile/RecipeBuilder/FinalStep/CompletionScreen.dart';
import 'package:recipemine/pages/Home/Profile/RecipeBuilder/IngredientAdder/IngredientAdderPage.dart';
import 'package:recipemine/pages/Home/Profile/RecipeBuilder/InstructionsAdder/InstructionsAdder.dart';
import 'package:recipemine/pages/Home/Profile/RecipeBuilder/RecipePropertyAdder/RecipePropertyAdder.dart';

/// Class responsible for building a user-contributed recipe.
class RecipeBuilder extends StatefulWidget {
  final RecipeMiner currentUser;

  RecipeBuilder({this.currentUser});
  @override
  _RecipeBuilderState createState() => _RecipeBuilderState();
}

class _RecipeBuilderState extends State<RecipeBuilder> {
  List<dynamic> ingredients = [];
  List<dynamic> instructions = ['cut the meat', 'cut the fish'];
  List<dynamic> smartTimer = ['1,1,1', '0,0,0'];
  List<dynamic> recipeProperties = ['','','',null,''];
  String imageURL;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length:4,
      child: Scaffold(
        appBar: AppBar(
          title: Text('RecipeMaker'),
          backgroundColor: Colors.redAccent,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          bottom: TabBar(
            isScrollable: true,
            indicatorColor: Colors.white,
            tabs: <Widget>[
              Tab(text:'Ingredients'),
              Tab(text:'Instructions'),
              Tab(text:'Properties'),
              Tab(text:'Publish'),
            ],
          ),
        ),
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            IngredientAdder(ingredients: ingredients),
            InstructionsAdder(instructions: instructions, smartTimer: smartTimer),
            RecipePropertyAdder(properties: recipeProperties),
            CompletionScreen(
              ingredients: ingredients,
              instructions: instructions,
              smartTimer: smartTimer,
              properties:  recipeProperties,
              imageURL: imageURL,
              currentUser: widget.currentUser,
            ),
          ],
        ),
      ),
    );
  }
}


