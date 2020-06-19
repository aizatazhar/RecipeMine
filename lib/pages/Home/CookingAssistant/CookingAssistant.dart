import 'package:countdown_flutter/countdown_flutter.dart';
import "package:flutter/material.dart";
import 'package:recipemine/Custom/CustomWidgets/TimerWidget.dart';
import 'package:recipemine/Custom/Models/Recipe.dart';
import '../HomeWrapper.dart';

class CookingAssistant extends StatefulWidget {
  @override
  _CookingAssistantState createState() => _CookingAssistantState();
}

class _CookingAssistantState extends State<CookingAssistant> {
  Recipe recipe = Recipe(
    id: "0",
    name: "Blueberry Pancakes",
    type: RecipeType.main,
    rating: 4.9,
    duration: 45,
    servingSize: 2,
    imageURL: "assets/Recipe 0.jpg",
    ingredients: [
      "3/4 cup milk",
      "2 tablespoons white vinegar",
      "1 cup flour",
      "2 tablespoons sugar",
      "1 teaspoon baking powder",
      "1/2 teaspoon baking soda",
      "1 egg",
      "2 tablespoons melted butter",
      "1 cup fresh blueberries",
      "Butter",
    ],
    instructions: [
      "Mix the milk and vinegar and let it sit for 2 minutes",
      "Whisk the dry ingredients together. Whisk the egg, milk, and melted "
          "butter into the dry ingredients until just combined.",
      "Heat a nonstick pan over medium heat. Melt a little smear of butter in the pan",
      "Pour about 1/3 cup of batter into the hot skillet and spread it flat. "
          "Arrange a few blueberries on top. Cook until you see little bubbles "
          "on top and the edges starting to firm up. Flip and cook for another "
          "1-2 minutes until the pancakes are sky-high fluffy and cooked through."
    ],
    smartTimer: [
      '0,2,0',
      '0,0,0',
      '0,0,0',
      '0,1,0'
    ]
  );



  int navigationIndex = 1;
  Widget countdownTimer = Text('Activate Smart Timer!');

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
                color: Colors.grey[100],
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
                        ? recipe.instructions[index]
                        : _buildIngredients(recipe.ingredients),
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontSize: 16,
                        )
                    ),
                    SizedBox(height:20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:(index != null && (recipe.smartTimer[index] != '0,0,0') ? <Widget>[
                        countdownTimer,
                        Row(
                          children: <Widget>[
                            IconButton(
                              icon: Icon(Icons.play_arrow),
                              onPressed: (){
                                int hours = int.parse(recipe.smartTimer[index].toString().split(',')[0]);
                                int minutes = int.parse(recipe.smartTimer[index].toString().split(',')[1]);
                                int seconds = int.parse(recipe.smartTimer[index].toString().split(',')[2]);
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

  // Maps a list of ingredients into a formatted String
  String _buildIngredients(List<dynamic> ingredients) {
    String result = "";

    ingredients.forEach((ingredient) {
      result += "• " + ingredient + "\n";
    });

    return result;
  }

  Widget _buildLastPage() {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          recipe.name,
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
                            builder: (context) => new HomeWrapper())
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

    for (int i = 0; i < recipe.instructions.length; i++) {
      stepPages.add(buildStep(i));
    }

    stepPages.add(_buildLastPage());
    return stepPages;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(children: getPages(),
        onPageChanged: (int index){
          setState(() {
            countdownTimer = Text('Activate Smart Timer!');
          });
        }),
    );
  }
}
