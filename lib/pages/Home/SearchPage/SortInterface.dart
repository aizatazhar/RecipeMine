import 'package:flappy_search_bar/flappy_search_bar.dart';
import "package:flutter/material.dart";
import 'package:recipemine/Custom/CustomWidgets/MainButton.dart';
import 'package:recipemine/Custom/Models/Recipe.dart';
import '../../../AppStyle.dart';

/// Builds the sort interface.
class SortInterface extends StatefulWidget {
  final SearchBarController<Recipe> searchBarController;
  final List<dynamic> userPantry;

  SortInterface({
    @required this.searchBarController,
    @required this.userPantry,
  });

  @override
  _SortInterfaceState createState() => _SortInterfaceState();
}

class _SortInterfaceState extends State<SortInterface> {
  // static preserves the state of the sort parameter used?
  static List<SortParameter> parameters = [
    SortParameter(name: "Relevance"),
    SortParameter(name: "Alphabetical"),
    SortParameter(name: "Rating"),
    SortParameter(name: "Cooking time"),
    SortParameter(name: "Number of ingredients required"),
    SortParameter(name: "Number of ingredients in pantry"),
  ];
  static SortParameter selectedParameter = parameters[0];

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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget> [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Sort by",
                style: AppStyle.mediumHeader
              ),
            ),
            SizedBox(height: 10),
            Column(children: createRadioListParameters()),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: _buildApplyButton()
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  List<Widget> createRadioListParameters() {
    List<Widget> result = [];

    for (SortParameter parameter in parameters) {
      result.add(
        Column(
          children: <Widget>[
            Container(
              child: RadioListTile(
                value: parameter,
                groupValue: selectedParameter,
                activeColor: Colors.redAccent,
                title: Text(
                  parameter.name,
                  style: TextStyle(
                    fontSize: selectedParameter == parameter ? 18 : 16,
                    fontWeight: selectedParameter == parameter ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
                selected: selectedParameter == parameter,
                onChanged: (currentParameter) {
                  setState(() {
                    selectedParameter = currentParameter;
                  });
                },
              ),
            ),
          ],
        ),
      );
    }

    return result;
  }

  Widget _buildApplyButton() {
    return MainButton(
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
      onPressed: ()  {
        if (selectedParameter.name == "Relevance") {
          widget.searchBarController.sortList((Recipe first, Recipe second) {
            return first.calculateRelevanceScore(widget.userPantry)
                .compareTo(second.calculateRelevanceScore(widget.userPantry));
          });
          Navigator.of(context).pop();
        } else if (selectedParameter.name == "Alphabetical") {
          widget.searchBarController.sortList((Recipe first, Recipe second) {
            return first.name.compareTo(second.name);
          });
          Navigator.of(context).pop();
        } else if (selectedParameter.name == "Rating") {
          widget.searchBarController.sortList((Recipe first, Recipe second) {
            return second.rating.compareTo(first.rating); // Sorts descending
          });
          Navigator.of(context).pop();
        } else if (selectedParameter.name == "Cooking time") {
          widget.searchBarController.sortList((Recipe first, Recipe second) {
            return first.duration.compareTo(second.duration);
          });
          Navigator.of(context).pop();
        } else if (selectedParameter.name == "Number of ingredients required") {
          widget.searchBarController.sortList((Recipe first, Recipe second) {
            return first.ingredients.length.compareTo(second.ingredients.length);
          });
          Navigator.of(context).pop();
        } else if (selectedParameter.name == "Number of ingredients in pantry") {
          widget.searchBarController.sortList((Recipe first, Recipe second) {
            return second.numberOfIngredientsPresent(widget.userPantry)
                .compareTo(first.numberOfIngredientsPresent(widget.userPantry));
          });
          Navigator.of(context).pop();
        } else {
          print("Error. Unknown parameter");
        }
      },
    );
  }

}

/// Simple class that encapsulates a sort parameter.
class SortParameter {
  String name;

  SortParameter({this.name});
}

