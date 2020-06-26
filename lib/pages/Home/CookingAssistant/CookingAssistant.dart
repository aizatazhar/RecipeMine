import 'package:countdown_flutter/countdown_flutter.dart';
import "package:flutter/material.dart";
import 'package:recipemine/Custom/CustomWidgets/TimerWidget.dart';
import 'package:recipemine/Custom/Models/Recipe.dart';
import '../HomeWrapper.dart';

class CookingAssistant extends StatefulWidget {
  final Recipe recipe;

  CookingAssistant(this.recipe);

  @override
  _CookingAssistantState createState() => _CookingAssistantState();
}

class _CookingAssistantState extends State<CookingAssistant> {
  int navigationIndex = 1;

  Widget countdownTimer = Text('Activate Smart Timer!');

  Widget _buildDefaultView() {
    return Container(
      child: Center(
        child: Text(
          "Search for a recipe!",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 32
          ),
        ),
      ),
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

    Widget _buildLastPage() {
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
                    Text(
                        "Good Work!\n",
                        style: TextStyle(
                          fontSize: 30.0,
                        )
                    ),
                    Text(
                        "Want to cook more?\n",
                        style: TextStyle(
                          fontSize: 24.0,
                        )
                    ),
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
        ),
      );
    }

    // Method that returns a list of widgets of the pages of a recipe
    List<Widget> getPages() {
      List<Widget> stepPages = <Widget>[];
      stepPages.add(buildStep(null));

      for (int i = 0; i < this.widget.recipe.instructions.length; i++) {
        stepPages.add(buildStep(i));
      }

      stepPages.add(_buildLastPage());
      return stepPages;
    }

    return PageView(
      children: getPages(),
      onPageChanged: (int index) {
        setState(() {countdownTimer = Text('Activate Smart Timer!');});
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: this.widget.recipe != null
          ? _buildRecipeView()
          : _buildDefaultView(),
    );
  }
}
