import 'package:flutter/material.dart';

class Step3 extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.pink[100],
        appBar: AppBar(
          backgroundColor: Colors.pink[200],
          title: Text('French Omelette: Step 3'),
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
                    //******need to find a way to do this dynamically*******
                    ListView(
                      padding: EdgeInsets.all(10),
                      children: <Widget>[
                        Text('○ Gently push cooked portions from edges toward the center with inverted turner so that uncooked eggs can reach the hot pan surface.\n',
                            style: TextStyle(
                              fontFamily: "SanFranciscoDisplay",
                              fontSize: 20.0,
                              fontWeight: FontWeight.w400,
                            )),
                        Text('○ Continue cooking, tilting pan and gently moving cooked portions as needed.\n',
                            style: TextStyle(
                              fontFamily: "SanFranciscoDisplay",
                              fontSize: 20.0,
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
