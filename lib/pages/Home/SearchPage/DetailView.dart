import 'package:flutter/material.dart';
import 'package:recipemine/Custom/CustomWidgets/MainButton.dart';
import 'package:recipemine/Custom/Models/Recipe.dart';
import 'package:recipemine/Custom/Models/ReciperMinerUser.dart';
import '../../../AppStyle.dart';
import 'SliverCustomHeaderDelegate.dart';

/// Builds the page displayed when clicking on a recipe.
class DetailView extends StatefulWidget {
  final Recipe recipe;
  final RecipeMiner user;

  final Function onBeginCooking;

  DetailView({@required this.recipe, @required this.user, @required this.onBeginCooking});

  @override
  _DetailViewState createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {
  final double _appBarHeight = AppBar().preferredSize.height;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverPersistentHeader(
            pinned: true,
            delegate: SliverCustomHeaderDelegate(
              collapsedHeight: _appBarHeight,
              expandedHeight: 300,
              paddingTop: MediaQuery.of(context).padding.top,
              recipe: this.widget.recipe,
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                  padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 50.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      _buildIconRow(this.widget.recipe),
                      SizedBox(height: 20),
                      Text(
                        "Ingredients",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      SizedBox(height: 10),
                      _buildIngredients(),
                      SizedBox(height: 20),
                      _buildBeginButton(),
                    ]
                  ),
                );
              },
              childCount: 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIconRow(Recipe recipe) {
    int numIngredients = recipe.numberOfIngredientsPresent(widget.user.pantry);
    return Row(
      children: [
        _buildIcon(Icons.star, Color(0xffFFC440), recipe.rating.toString()),
        _buildIcon(Icons.schedule, Color(0xffFF5C64), recipe.duration.toString() + " min"),
        _buildIcon(Icons.people_outline, Color(0xff30C551), recipe.servingSize.toString()),
        _buildIcon(Icons.kitchen, Color(0xff1D92FF), "$numIngredients/${recipe.ingredients.length}"),
      ],
    );
  }

  Widget _buildIcon(IconData iconData, Color iconColor, String text) {
    return Padding(
      padding: EdgeInsets.only(right: 15),
      child: Row(
        children: <Widget> [
          Padding(
            padding: EdgeInsets.only(right: 2.5),
            child: Icon(
              iconData,
              color: iconColor,
            ),
          ),
          Text(
            text,
            style: TextStyle(
              color: Colors.grey[800],
              fontSize: 18.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIngredients() {
    return Column(
      children: this.widget.recipe.ingredients.map((ingredient) =>
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget> [
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    ingredient,
                    style: AppStyle.subtitle,
                  ),
                ),
                SizedBox(
                  child: pantryContainsIngredient(ingredient)
                      ? Icon(Icons.check, color: Color(0xff1D92FF))
                      : null,
                ),
              ],
            ),
            Divider(
              thickness: 1.5,
              color: Colors.grey[400],
            ),
          ],
        )).toList(),
    );
  }

  bool pantryContainsIngredient(String ingredient) {
    return widget.user.pantry.any((pantryItem) {
      String pantryIngredient = pantryItem.split(",").first;
      return ingredient.contains(pantryIngredient.toLowerCase());
    });
  }

  Widget _buildBeginButton() {
    return MainButton(
      child: Text(
        "Begin Cooking",
        style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20
        ),
      ),
      width: double.maxFinite,
      onPressed: () {
        this.widget.onBeginCooking(this.widget.recipe);
      },
    );
  }
}



