import "package:flutter/material.dart";
import 'package:recipemine/Custom/Models/Recipe.dart';

/// Builds the FilterChips for filtering recipes.
class RecipeTypeFilter extends StatefulWidget {
  final List<RecipeType> types;
  final List<RecipeType> filters;

  RecipeTypeFilter({@required this.types, @required this.filters});

  @override
  _RecipeTypeFilterState createState() => _RecipeTypeFilterState();
}

class _RecipeTypeFilterState extends State<RecipeTypeFilter> {

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: getTypeWidgets(),
      spacing: 5,
    );
  }

  List<Widget> getTypeWidgets() {
    List<Widget> result = [];

    for (RecipeType type in widget.types) {
      result.add(
        FilterChip(
          label: Text(type.name),
          labelStyle: TextStyle(
            fontSize: widget.filters.contains(type) ? 16 : 14,
            fontWeight: widget.filters.contains(type) ? FontWeight.bold : FontWeight.normal,
            color: widget.filters.contains(type) ? Colors.white : Colors.grey[800],
          ),
          checkmarkColor: Colors.white,

          selectedColor: Colors.redAccent,
          backgroundColor: Colors.white,
          elevation: 2,

          selected: widget.filters.contains(type),
          onSelected: (bool value) {
            setState(() {
              if (value) {
                widget.filters.add(type);
              } else {
                widget.filters.removeWhere((item) => item == type);
              }
            });
          },
        )
      );
    }

    return result;
  }
}
