import "package:flutter/material.dart";

/// A RaisedButton with custom decorations corresponding to the main
/// call-to-action.
class MainButton extends StatelessWidget {
  final Key key;
  final Function onPressed;
  final Widget child;
  final double width;

  MainButton({this.key, @required this.onPressed, this.child, this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: width,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15)
        ),
        color: Colors.redAccent,
        child: child,
        onPressed: onPressed,
      ),
    );
  }
}
