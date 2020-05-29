import 'dart:async';

import 'package:flutter/material.dart';
import 'package:recipemine/main.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[100],
      body: SafeArea(
        top: true,
        bottom: true,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Image( // Logo image
                image: AssetImage("assets/Logo.png"),
              ),
              Padding( // Motto underneath logo
                padding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
                child: Text(
                  "Find the perfect recipe",
                  style: TextStyle(
                    fontFamily: "SanFranciscoDisplay",
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff5F3739).withOpacity(0.70),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    transition();

  }

  //method used to transition to the homescreen.
  //copied from stackover flow, don't know why this code works.
  //Beet to leave it.
  void transition()  async{
    Timer(
        Duration(seconds: 1),
            () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => HomePage())));
    }

}