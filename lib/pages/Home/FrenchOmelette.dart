import "package:flutter/material.dart";
import "package:recipemine/Custom/CustomWidgets/TimerWidget.dart";
import "package:recipemine/Constants.dart";

class FrenchOmelette {
  // Probably can have a Recipe class, and each instance is a specific recipe.
  // Constructor can take in list of String for building a page, String for
  // recipe name, etc.
  // Possible to integrate IngredientsList class into a Recipe

  List<String> instructions = <String>[
    "○ Beat eggs, water, salt and pepper in small bowl for 20 seconds until blended.",
    "○ Tilt pan to coat bottom. Pour egg mixture into pan.\n○ Mixture should set immediately at edges.",
    "○ Gently push cooked portions from edges toward the center with inverted turner so that uncooked eggs can reach the hot pan surface.\n○ Continue cooking, tilting pan and gently moving cooked portions as needed.\n",
    "○ When top surface of eggs is thickened and no visible liquid egg remains, place filling on one side of the omelet.\n○ Fold omelet in half with turner, with a quick flip of the wrist, turn pan and invert or slide omelet onto plate.\n○ Serve immediately.",
  ];

  // Builds the page for an instruction
  Widget buildStep(int stepIndex, String instruction) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.pink[100],
        appBar: AppBar(
          backgroundColor: Colors.pink[200],
          title: Text("French Omelette Step $stepIndex"),
          centerTitle: true,
          elevation: 0,
          bottom: TabBar(
            tabs: <Widget>[
              Tab(text: "Instructions",),
              Tab(text: "Timer",),
            ],
          )
        ),
        body: TabBarView(children: [
          Container(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white70,
                  border: Border.all(
                    color: Colors.white70,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                child: ListView(// ***need to find a way to do this dynamically***
                  padding: EdgeInsets.all(10),
                  children: <Widget>[Constants.paragraphTextLight(instruction)],
                )
              )
            )
          ),
          Container(
            color: Colors.pink[75],
            child: Center(
              child: Alarm(),
            ),
          ),
        ])
      ),
    );
  }
}
