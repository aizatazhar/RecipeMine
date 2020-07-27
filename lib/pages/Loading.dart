import "package:flutter/material.dart";
import "package:flutter_spinkit/flutter_spinkit.dart";

/// Class used for loading when accessing menus within the app.
class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitChasingDots(
          color: Colors.redAccent,
          size: 50.0,
        ),
      ),
    );
  }
}
