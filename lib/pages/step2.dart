import 'package:flutter/material.dart';
import 'package:recipemine/CustomeWidgets/TimerWidget.dart';
class Step2 extends StatelessWidget {
  Widget build(BuildContext context) {
    return DefaultTabController(
      length:2,
      child: Scaffold(
          backgroundColor: Colors.pink[100],
          appBar: AppBar(
              backgroundColor: Colors.pink[200],
              title: Text('French Omelette: Step 2'),
              centerTitle: true,
              elevation: 0,
              bottom: TabBar(
                tabs: <Widget>[
                  Tab(
                    text: 'Instructions',
                  ),
                  Tab(
                    text: 'Timer',
                  ),
                ],
              )
          ),
          body: TabBarView(
              children: [
                Container(
                    child:Padding(
                        padding: EdgeInsets.all(10),
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
                                Text('○ Heat butter in 6 to 8-inch nonstick omelet pan or skillet over medium-high heat for 3 minutes until hot.\n',
                                    style: TextStyle(
                                      fontFamily: "SanFranciscoDisplay",
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w400,
                                    )),
                                Text('○ Tilt pan to coat bottom. Pour egg mixture into pan.\n',
                                    style: TextStyle(
                                      fontFamily: "SanFranciscoDisplay",
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w400,
                                    )),
                                Text('○ Mixture should set immediately at edges.\n',
                                    style: TextStyle(
                                      fontFamily: "SanFranciscoDisplay",
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w400,
                                    )),
                              ],
                            )
                        )
                    )
                ),
                Container(
                  color: Colors.pink[75],
                  child: Container(
                    child: Center(
                      child: Alarm(),
                    ),
                  ),
                ),
              ])
      ),
    );
  }
}
