
import 'package:flutter/material.dart';
import 'package:recipemine/Custom/Models/Recipe.dart';
import 'SliverCustomHeaderDelegate.dart';

class DetailView extends StatelessWidget {
  final double _appBarHeight = AppBar().preferredSize.height;
  final Recipe recipe;

  DetailView(this.recipe);

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
              recipe: this.recipe,
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                return Container(
                  color: Colors.grey[200],
                  padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 50.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        _buildIconRow(this.recipe),
                        SizedBox(height: 20),
                        Text(
                          "Ingredients",
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        SizedBox(height: 10),
                        _buildIngredients(context),
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
    return Row(
      children: [
        _buildIcon(Icons.star, Color(0xffFFC440), recipe.rating.toString()),
        _buildIcon(Icons.schedule, Color(0xffFF5C64), recipe.duration.toString() + " min"),
        _buildIcon(Icons.people_outline, Color(0xff30C551), recipe.servingSize.toString()),
        _buildIcon(Icons.kitchen, Color(0xff1D92FF), "4/${recipe.ingredients.length}"),
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

  Widget _buildIngredients(BuildContext context) {
    return Column(
      children: this.recipe.ingredients.map((ingredient) =>
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget> [
              Text(
                ingredient,
                style: Theme.of(context).textTheme.subtitle1,
              ),
              Divider(
                thickness: 1.5,
                color: Colors.grey[400],
              ),
            ],
          )).toList(),
    );

  }

  Widget _buildBeginButton() {
    return Container(
      height: 40,
      width: 1000,
      child: RaisedButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)
          ),
          color: Colors.red,
          onPressed: () {},
          child: Text(
            "Begin Cooking",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20
            ),
          )
      ),
    );
  }
}


