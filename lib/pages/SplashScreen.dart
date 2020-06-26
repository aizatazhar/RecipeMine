import 'dart:async';
import 'package:flutter/material.dart';
import 'package:recipemine/pages/Authentication/ProviderWrapper.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Image(image: AssetImage("assets/Logo.png")),
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

  // After authentication implementation it transitions to the wrapper for the authentication.
  void transition() async {
    Timer(
      Duration(seconds: 2),
      () => Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => ProviderWrapper())
      )
    );
  }
}
