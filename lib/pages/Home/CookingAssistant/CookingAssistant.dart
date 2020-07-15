import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:recipemine/Custom/CustomWidgets/Alarm.dart';
import 'package:recipemine/Custom/Models/Recipe.dart';
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

  Widget countdownTimer = Text('Activate Smart Timer!');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: this.widget.recipe != null
          ? _buildRecipeView()
          : _buildEmptyView(),
    );
  }

  Widget _buildRecipeView() {
    // Maps a list of ingredients into a formatted String
    String _buildIngredients(List<dynamic> ingredients) {
      String result = "";

      ingredients.forEach((ingredient) {
        result += "• " + ingredient + "\n";
      });

      return result;
    }

    // Builds a page per step
    Widget buildStep(int index) {
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
                )
            ),
            body: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: [
                  Container(
                    child: ListView(
                      padding: EdgeInsets.all(20),
                      children: <Widget>[
                        Text(
                          index != null
                              ? "Step ${index + 1}"
                              : "Ingredients List",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(index != null
                            ? this.widget.recipe.instructions[index]
                            : _buildIngredients(this.widget.recipe.ingredients),
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              fontSize: 16,
                            )
                        ),
                        SizedBox(height:20),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:(index != null && (this.widget.recipe.smartTimer[index] != '0,0,0') ? <Widget>[
                              countdownTimer,
                              Row(
                                children: <Widget>[
                                  IconButton(
                                    icon: Icon(Icons.play_arrow),
                                    onPressed: (){
                                      int hours = int.parse(this.widget.recipe.smartTimer[index].toString().split(',')[0]);
                                      int minutes = int.parse(this.widget.recipe.smartTimer[index].toString().split(',')[1]);
                                      int seconds = int.parse(this.widget.recipe.smartTimer[index].toString().split(',')[2]);
                                      setState(() {
                                        countdownTimer = CountDown(hours,minutes,seconds);
                                      });
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.stop),
                                    onPressed: (){
                                      setState(() {
                                        countdownTimer = Text('Activate Smart Timer!');
                                      });
                                    },
                                  )
                                ],
                              ),
                            ] : <Widget>[])
                        ),
                      ],
                    ),
                  ),
                  Alarm(),
                ]
            )
        ),
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

    Widget _buildLastPage(Recipe recipe) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            this.widget.recipe.name,
          ),
          centerTitle: true,
          backgroundColor: Colors.redAccent,
        ),
        body: Center(
          child: Container(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text('Recipe author: ' + widget.recipe.authorUID, style: AppStyle.caption),
                    SizedBox(height: 20),
                    _buildRatingSystem(recipe),
                  ]
              )
          ),
        ),
      );
    }

    // Method that returns a list of widgets of the pages of a recipe
    List<Widget> getPages(Recipe recipe) {
      List<Widget> stepPages = <Widget>[];
      stepPages.add(buildStep(null));

      for (int i = 0; i < this.widget.recipe.instructions.length; i++) {
        stepPages.add(buildStep(i));
      }

      stepPages.add(_buildLastPage(recipe));
      return stepPages;
    }

    return PageView(
        children: getPages(widget.recipe),
        onPageChanged: (int index) {
          setState(() {countdownTimer = Text('Activate Smart Timer!');});
        }
    );
  }

  Widget _buildEmptyView() {
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            AppStyle.buildEmptyViewIcon(Icons.favorite_border),
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
