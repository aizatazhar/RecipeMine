import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recipemine/pages/ending.dart';
import 'package:recipemine/pages/step1.dart';
import 'package:recipemine/pages/step2.dart';
import 'package:recipemine/pages/step3.dart';
import 'package:recipemine/pages/step4.dart';

class IngredientList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.pink[100],
        appBar: AppBar(
          backgroundColor: Colors.pink[200],
          title: Text('Ingredients Needed for:\nFrench Omelette',
          textAlign: TextAlign.center,),
          centerTitle: true,
          elevation: 0,
        ),
        body: Container(
          child:Padding(
            padding: EdgeInsets.all(15),
            child: Container(
              decoration: BoxDecoration(
                  color:Colors.white70,
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
                      Text('1. 2 Large Eggs\n',
                      style: TextStyle(
                        fontFamily: "SanFranciscoDisplay",
                        fontSize: 18.0,
                        fontWeight: FontWeight.w400,
                      )),
                      Text('2. 2 tbsp water\n',
                          style: TextStyle(
                            fontFamily: "SanFranciscoDisplay",
                            fontSize: 18.0,
                            fontWeight: FontWeight.w400,
                          )),
                      Text('3. 1/8 tbsp salt\n',
                          style: TextStyle(
                            fontFamily: "SanFranciscoDisplay",
                            fontSize: 18.0,
                            fontWeight: FontWeight.w400,
                          )),
                      Text('4. Dash of pepper\n',
                          style: TextStyle(
                            fontFamily: "SanFranciscoDisplay",
                            fontSize: 18.0,
                            fontWeight: FontWeight.w400,
                          )),
                      Text('5. 1 tbsp butter\n',
                          style: TextStyle(
                            fontFamily: "SanFranciscoDisplay",
                            fontSize: 18.0,
                            fontWeight: FontWeight.w400,
                          )),
                      Text('6. 1/3 cup filling such as cheese or ham\n',
                          style: TextStyle(
                            fontFamily: "SanFranciscoDisplay",
                            fontSize: 18.0,
                            fontWeight: FontWeight.w400,
                          )),
                    ],
                  )

            )
          )
        )
      );
    }
}

//used to make bulletpoints
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
