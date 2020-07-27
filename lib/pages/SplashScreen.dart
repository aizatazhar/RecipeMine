import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recipemine/pages/Authentication/ProviderWrapper.dart';

/// Builds the splash screen.
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Image(image: AssetImage("assets/Logo/Logo cropped.png")),
            Text(
              "Find the perfect recipe",
              style: TextStyle(
                fontFamily: "Montserrat",
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
                color: Color(0xff5F3739)
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    transition();
  }

  // After authentication implementation it transitions to the wrapper for the authentication.
  void transition() async {
    Timer(
      Duration(seconds: 1),
      () => Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => ProviderWrapper())
      )
    );
  }
}
