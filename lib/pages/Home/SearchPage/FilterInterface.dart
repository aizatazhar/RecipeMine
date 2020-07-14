import 'package:flappy_search_bar/flappy_search_bar.dart';
import "package:flutter/material.dart";
import 'package:recipemine/Custom/Models/Recipe.dart';
import 'package:recipemine/pages/Home/SearchPage/RecipeTypeFilter.dart';
import '../../../AppStyle.dart';

class FilterInterface extends StatefulWidget {
  final SearchBarController<Recipe> searchBarController;

  FilterInterface({@required this.searchBarController});

  @override
  _FilterInterfaceState createState() => _FilterInterfaceState();
}

class _FilterInterfaceState extends State<FilterInterface> {
  // static preserves state
  static RangeValues cookingTimeSelectedRange = RangeValues(0, 600);
  static RangeValues servingSizeSelectedRange = RangeValues(1, 10);
  static List<RecipeType> recipeTypeFilters = [
    RecipeType.main,
    RecipeType.side,
    RecipeType.dessert,
    RecipeType.drink,
  ];

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Filter",
                style: AppStyle.mediumHeader,
              ),
              SizedBox(height: 20),
              _buildRangeFilter(
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
              _buildRangeFilter(
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
              Expanded(child: Container()),
              Row(
                children: <Widget>[
                  Flexible(flex: 1, child: _buildResetButton()),
                  SizedBox(width: 10),
                  Flexible(flex: 2, child: _buildApplyButton()),
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
    );
  }

  Widget _buildRangeFilter({@required String title, @required String unit,
      @required double min, @required double max, @required RangeValues selectedRange,
      @required int divisions, @required Function onChanged }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget> [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500
              ),
            ),
            Row(
              children: <Widget>[
                Container(
                  width: 40,
                  height: 34,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Color(0xffFFE5E7),
                  ),
                  child: Center(child: Text("${selectedRange.start.round()}")),
                ),
                SizedBox(width: 5),
                Container(
                  child: Text("to"),
                ),
                SizedBox(width: 5),
                Container(
                  width: 40,
                  height: 34,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Color(0xffFFE5E7),
                  ),
                  child: Center(child: Text("${selectedRange.end.round()}")),
                ),
                SizedBox(width: 5),
                Container(
                  child: Text(unit),
                ),
              ],
            ),
          ],
        ),
        RangeSlider(
          values: selectedRange,
          min: min,
          max: max,
          divisions: divisions,
          activeColor: Colors.redAccent,
          onChanged: onChanged,
        ),
      ],
    );

  }

  Widget _buildResetButton() {
    return Container(
      height: 50,
      child: RaisedButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Reset",
                style: TextStyle(
                  color: Colors.grey[800],
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          onPressed: resetFilters
      ),
    );
  }

  void resetFilters() {
    setState(() {
      cookingTimeSelectedRange = RangeValues(0, 600);
      servingSizeSelectedRange = RangeValues(1, 10);

      List<RecipeType> resetRecipeTypeFilters = [];
      for (RecipeType type in RecipeType.values) {
        resetRecipeTypeFilters.add(type);
      }
      recipeTypeFilters = resetRecipeTypeFilters;
    });
  }

  Widget _buildApplyButton() {
    return Container(
      height: 50,
      child: RaisedButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          color: Colors.redAccent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Apply",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          onPressed: applyFilters
      ),
    );
  }

  void applyFilters() {
    widget.searchBarController.filterList(
      (Recipe recipe) {
        return
            (recipe.duration >= cookingTimeSelectedRange.start &&
                recipe.duration <= cookingTimeSelectedRange.end)
            &&
            (recipe.servingSize >= servingSizeSelectedRange.start &&
                recipe.servingSize <= servingSizeSelectedRange.end)
            &&
            (recipeTypeFilters.contains(recipe.type));
      }
    );

    Navigator.of(context).pop();
  }
}

