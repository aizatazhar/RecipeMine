import 'package:flappy_search_bar/flappy_search_bar.dart';
import "package:flutter/material.dart";
import 'package:recipemine/Custom/CustomWidgets/CustomRangeFilter.dart';
import 'package:recipemine/Custom/CustomWidgets/MainButton.dart';
import 'package:recipemine/Custom/CustomWidgets/SecondaryButton.dart';
import 'package:recipemine/Custom/Models/Recipe.dart';
import 'package:recipemine/pages/Home/SearchPage/RecipeTypeFilter.dart';
import '../../../AppStyle.dart';

/// Builds the interface for filtering recipes.
class FilterInterface extends StatefulWidget {
  final SearchBarController<Recipe> searchBarController;
  final List<dynamic> userPantry;

  FilterInterface({
    @required this.searchBarController,
    @required this.userPantry,
  });

  @override
  _FilterInterfaceState createState() => _FilterInterfaceState();
}

class _FilterInterfaceState extends State<FilterInterface> {
  // Static preserves state?
  static RangeValues ratingSelectedRange = RangeValues(0, 5);
  static RangeValues cookingTimeSelectedRange = RangeValues(0, 600);
  static RangeValues servingSizeSelectedRange = RangeValues(1, 10);
  static List<RecipeType> recipeTypeFilters = [
    RecipeType.main,
    RecipeType.side,
    RecipeType.dessert,
    RecipeType.drink,
  ];

  bool allIngredientsInPantrySwitch = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Filter",
                  style: AppStyle.mediumHeader,
                ),
                SizedBox(height: 20),
                CustomRangeFilter(
                    title: "Rating",
                    unit: "",
                    min: 0,
                    max: 5,
                    selectedRange: ratingSelectedRange,
                    divisions: 5,
                    onChanged: (RangeValues value) {
                      setState(() {
                        ratingSelectedRange = value;
                      });
                    }
                ),
                SizedBox(height: 20),
                CustomRangeFilter(
                  title: "Cooking time",
                  unit: "min",
                  min: 0,
                  max: 600,
                  selectedRange: cookingTimeSelectedRange,
                  divisions: 40,
                  onChanged: (RangeValues value) {
                    setState(() {
                      cookingTimeSelectedRange = value;
                    });
                  }
                ),
                SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget> [
                    Text(
                      "Dish",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                    RecipeTypeFilter(
                      types: RecipeType.values,
                      filters: recipeTypeFilters,
                    ),
                  ],
                ),
                SizedBox(height: 20),
                CustomRangeFilter(
                  title: "Serving size",
                  unit: "people",
                  min: 1,
                  max: 10,
                  selectedRange: servingSizeSelectedRange,
                  divisions: 9,
                  onChanged: (RangeValues value) {
                    setState(() {
                      servingSizeSelectedRange = value;
                    });
                  }
                ),
                SizedBox(height: 20),
                _haveAllIngredients(),
                SizedBox(height: 20),
                Row(
                  children: <Widget>[
                    Expanded(flex: 1, child: _buildResetButton()),
                    SizedBox(width: 10),
                    Expanded(flex: 2, child: _buildApplyButton()),
                  ],
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
    );
  }

  Widget _haveAllIngredients() {
    return Row(
      children: <Widget>[
        Text(
          "Have all ingredients in pantry",
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500
          ),
        ),
        Expanded(child: Container(),),
        Switch(
          onChanged: (bool value) {
            setState(() {
              allIngredientsInPantrySwitch = value;
            });
          },
          value: allIngredientsInPantrySwitch,
          activeTrackColor: Colors.redAccent,
          activeColor: Colors.redAccent,
        ),
      ],
    );
  }

  Widget _buildResetButton() {
    return SecondaryButton(
      child: Text(
        "Reset",
        style: TextStyle(
          color: Colors.grey[800],
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      onPressed: resetFilters,
    );
  }

  void resetFilters() {
    setState(() {
      ratingSelectedRange = RangeValues(0, 5);
      cookingTimeSelectedRange = RangeValues(0, 600);
      servingSizeSelectedRange = RangeValues(1, 10);

      List<RecipeType> resetRecipeTypeFilters = [];
      for (RecipeType type in RecipeType.values) {
        resetRecipeTypeFilters.add(type);
      }
      recipeTypeFilters = resetRecipeTypeFilters;

      allIngredientsInPantrySwitch = false;
    });
  }

  Widget _buildApplyButton() {
    return MainButton(
      child: Text(
        "Apply",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      onPressed: applyFilters,
    );
  }

  void applyFilters() {
    widget.searchBarController.filterList(
      (Recipe recipe) {
        return
          (recipe.rating >= ratingSelectedRange.start &&
              recipe.rating <= ratingSelectedRange.end)
          &&
          (recipe.duration >= cookingTimeSelectedRange.start &&
              recipe.duration <= cookingTimeSelectedRange.end)
          &&
          (recipe.servingSize >= servingSizeSelectedRange.start &&
              recipe.servingSize <= servingSizeSelectedRange.end)
          &&
          (recipeTypeFilters.contains(recipe.type))
          &&
          (allIngredientsInPantrySwitch
              ? recipe.ingredients.length == recipe.numberOfIngredientsPresent(widget.userPantry)
              : true
          );
      }
    );

    Navigator.of(context).pop();
  }
}

