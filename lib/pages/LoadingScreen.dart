import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF1F1F1),
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
}