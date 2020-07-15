import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:recipemine/Custom/CustomWidgets/Alarm.dart';
import 'package:recipemine/Custom/CustomWidgets/UnorderedList.dart';
import 'package:recipemine/Custom/Models/Recipe.dart';
import 'package:recipemine/pages/Home/CookingAssistant/SmartTimerDisplay.dart';
import '../../../AppStyle.dart';
import '../HomeWrapper.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class CookingAssistant extends StatefulWidget {
  final Recipe recipe;

  CookingAssistant(this.recipe);

  @override
  _CookingAssistantState createState() => _CookingAssistantState();
}

class _CookingAssistantState extends State<CookingAssistant> {
  int navigationIndex = 1;
  bool ratingOnce = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: this.widget.recipe != null
          ? _buildRecipeView()
          : _buildEmptyView(),
    );
  }

  int getENUM(Recipe recipe){
    if(recipe.type == RecipeType.main){
      return 0;
    }
    if(recipe.type == RecipeType.side){
      return 1;
    }
    if(recipe.type == RecipeType.dessert){
      return 2;
    }
    if(recipe.type == RecipeType.drink){
      return 3;
    }
  }

  Widget _buildRatingSystem(Recipe recipe){
    return ratingOnce ?
    Column(
      children: <Widget>[
        Text(
          'Please Rate the Recipe!',
          style:AppStyle.mediumHeader,
        ),
        SizedBox(height: 20),
        RatingBar(
          initialRating: 0,
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
          itemBuilder: (context, _) => Icon(
            Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: (rating) async {
            List<dynamic> updatedRatings = recipe.ratings;
            updatedRatings.add(rating);
            double finalRating = 0;
            updatedRatings.forEach((element) {finalRating += element;});
            finalRating = double.parse((finalRating/updatedRatings.length).toStringAsFixed(1));
            await Firestore.instance.collection('Recipes').document(recipe.id).setData({
              'duration' : recipe.duration,
              'authorUID' : recipe.authorUID,
              'ratings' : updatedRatings,
              'imageURL' : recipe.imageURL,
              'ingredients' : recipe.ingredients,
              'instructions' : recipe.instructions,
              'name' : recipe.name,
              'rating' : finalRating,
              'servingSize' : recipe.servingSize,
              'type' : getENUM(recipe),
              'smartTimer' : recipe.smartTimer,
            });
            setState(() {
              ratingOnce = false;
            });
            print('done');
          },
        ),
      ],
    )
        :
    _buildPostRating();
  }

  Widget _buildRecipeView() {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          flexibleSpace: TabBar(
            indicatorColor: Colors.white,
            tabs: <Widget>[
              Tab(text: "Instructions",),
              Tab(text: "Timer",),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            ListView(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              children: <Widget>[
                _buildIngredients(this.widget.recipe.ingredients),
                SizedBox(height: 15),
                Divider(color: Colors.grey, thickness: 1),
                SizedBox(height: 15),
                _buildSteps(),
                SizedBox(height: 5),
                Divider(color: Colors.grey, thickness: 1),
                SizedBox(height: 15),
              ],
            ),
            Alarm(),
          ],
        ),
      ),
    );
  }

  Widget _buildIngredients(List<dynamic> ingredients) {
    List<String> formattedIngredients = [];

    ingredients.forEach((ingredient) {
      formattedIngredients.add(ingredient.toString().toLowerCase());
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Ingredients",
          style: AppStyle.assistantHeader
        ),
        SizedBox(height: 5),
        UnorderedList(texts: formattedIngredients, spacing: 2, style: AppStyle.caption),
      ],
    );
  }

  Widget _buildSteps() {
    List<dynamic> instructions = this.widget.recipe.instructions;
    List<Widget> steps = [];
    for (int i = 0; i < instructions.length; i++) {
      steps.add(Text("Step ${i+1}", style: AppStyle.assistantHeader));
      steps.add(SizedBox(height: 5));
      steps.add(Text("${instructions[i].toString()}", style: AppStyle.caption.copyWith(height: 1.5), textAlign: TextAlign.justify));
      steps.add(SizedBox(height: 10));
      if (this.widget.recipe.smartTimer[i] != '0,0,0') {
        steps.add(_buildSmartTimer(this.widget.recipe.smartTimer[i]));
        steps.add(SizedBox(height: 20));
      } else {
        steps.add(SizedBox(height: 10));
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: steps,
    );
  }

  Widget _buildSmartTimer(String smartTimer) {
    List<String> time = smartTimer.split(",");
    int hours = int.parse(time[0]);
    int minutes = int.parse(time[1]);
    int seconds = int.parse(time[2]);

    int totalSeconds = hours * 3600 + minutes * 60 + seconds;

    return SmartTimerDisplay(seconds: totalSeconds);
  }

  Widget _buildEmptyView() {
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            AppStyle.buildEmptyViewIcon(Icons.whatshot),
            SizedBox(height: 20),
            Text(
              "Search for a recipe",
              style: AppStyle.mediumHeader,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              "The recipe that you selected will be displayed here.",
              style: AppStyle.caption,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPostRating() {
    return Center(
      child: Container(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 20),
                Text(
                    "Find more Recipes!",
                    style: TextStyle(
                      fontSize: 24.0,
                    )
                ),
                SizedBox(height: 20),
                Container(
                  child: Ink(
                    decoration: const ShapeDecoration(
                      color: Colors.pink,
                      shape: CircleBorder(),
                    ),
                    child: IconButton(
                      icon: Icon(Icons.search),
                      color: Colors.white,
                      onPressed: () {
                        Navigator.pushReplacement(context, new MaterialPageRoute(
                            builder: (context) => new HomeWrapper(recipe: null, initialBottomNavigationBarIndex: 0))
                        );
                      },
                    ),
                  ),
                )
              ]
          )
      ),
    );
  }
}
