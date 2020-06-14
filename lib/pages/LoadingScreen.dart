import "package:flutter/material.dart";
import "package:flutter_spinkit/flutter_spinkit.dart";

//Class is for loading when accessing menus within the app.
class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: SpinKitChasingDots(
          color: Colors.pinkAccent,
          size: 50.0,
        ),
      ),
    );
  }
}