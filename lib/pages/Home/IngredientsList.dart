import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:recipemine/Constants.dart";

class IngredientList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.pink[100],
        appBar: AppBar(
          backgroundColor: Colors.pink[200],
          title: Text(
            "Ingredients Needed for\nFrench Omelette",
            textAlign: TextAlign.center,
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: Container(
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white70,
                border: Border.all(
                  color: Colors.white70,
                ),
                borderRadius: BorderRadius.all(Radius.circular(20))
              ),
            child:
            //DID NOT COMBINE THE TEXT BECAUSE THE EXCEL FILE WILL HAVE THE INGREDIENTS SEPARATED ALREADY, PLAN IS TO PARSE DATA DYNAMICALLY.
              ListView(
                padding: EdgeInsets.all(10),
                children: <Widget>[
                  Constants.paragraphTextLight("1. 2 Large Eggs"),
                  Constants.paragraphTextLight("2. 2 tbsp water"),
                  Constants.paragraphTextLight("3. 1/8 tbsp salt"),
                  Constants.paragraphTextLight("4. Dash of pepper"),
                  Constants.paragraphTextLight("5. 1 tbsp butter"),
                  Constants.paragraphTextLight("6. 1/3 cup filling such as cheese or ham"),
                ],
              )
            )
          )
        )
    );
  }
}

//used to make bullet points
//class MyBullet extends StatelessWidget{
//  @override
//  Widget build(BuildContext context) {
//    return new Container(
//      height: 20.0,
//      width: 20.0,
//      decoration: new BoxDecoration(
//        color: Colors.black,
//        shape: BoxShape.circle,
//      ),
//    );
//  }
//}
