import 'package:flutter/material.dart';

class Step1 extends StatelessWidget {  @override
Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.pink[100],
        appBar: AppBar(
          backgroundColor: Colors.pink[200],
          title: Text('French Omelette: Step 1'),
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
                        Text('○ Beat eggs, water, salt and pepper in small bowl until blended\n',
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


