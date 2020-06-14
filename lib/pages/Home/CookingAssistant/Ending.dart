import "package:flutter/material.dart";
import 'package:recipemine/pages/Home/HomeWrapper.dart';

class Ending extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[100],
      appBar: AppBar(
        backgroundColor: Colors.pink[200],
        title: Text("French Omelette: Completed"),
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
            //******need to find a way to do this dynamically*******
            ListView(
              padding: EdgeInsets.fromLTRB(0, 120, 0, 0),
              children: <Widget>[
                Text("Good Work!\n",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30.0,
                  )
                ),
                Text("Want to cook more?\n",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25.0,
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
                        Navigator.push(context, new MaterialPageRoute(
                            builder: (context) =>
                            new HomeWrapper())
                        );
                      },
                    ),
                  ),
                )
              ]
            )
          )
        )
      )
    );
  }
}
