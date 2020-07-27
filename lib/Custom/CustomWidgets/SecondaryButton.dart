import "package:flutter/material.dart";

/// A RaisedButton button with custom decorations corresponding to the secondary
/// call-to-action.
class SecondaryButton extends StatelessWidget {
  final Key key;
  final double width;
  final Widget child;
  final Function onPressed;

  SecondaryButton({this.key, this.width, this.child, @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: width,
      child: RaisedButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          color: Colors.white,
          child: child,
          onPressed: onPressed,
      ),
    );
  }
}
