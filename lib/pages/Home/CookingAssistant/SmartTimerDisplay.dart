import "package:flutter/material.dart";
import 'package:recipemine/Custom/CustomWidgets/CustomCountdown.dart';

class SmartTimerDisplay extends StatefulWidget {
  final int seconds;

  SmartTimerDisplay({@required this.seconds});

  @override
  _SmartTimerDisplayState createState() => _SmartTimerDisplayState();
}

class _SmartTimerDisplayState extends State<SmartTimerDisplay> {
  final CountdownController controller = CountdownController();
  bool isPaused = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget> [
        CustomCountdown(
          seconds: widget.seconds,
          controller: controller,
          interval: Duration(seconds: 1),
          startImmediately: false,
          build: (BuildContext context, int time) => Text(
            CustomCountdown.prettify(Duration(seconds: time)),
            style: isPaused
                ? TextStyle(
              fontSize: 31,
              fontWeight: FontWeight.w500,
              color: Color(0xff323031),
            )
                : TextStyle(
                fontSize: 31,
                fontWeight: FontWeight.bold,
                color: Color(0xffffc857)
            ),
          ),
        ),
        Row(
          children: <Widget> [
            _buildStartButton(),
            SizedBox(width: 10),
            _buildResetButton()
          ],
        ),
      ],
    );
  }

  Widget _buildStartButton() {
    return RawMaterialButton(
      child: isPaused ? Icon(Icons.play_arrow, color: Colors.white,) : Icon(Icons.pause),
      shape: CircleBorder(),
      fillColor: isPaused ? Color(0xffDB3A34) : Colors.white,
      elevation: 2.5,
      padding: EdgeInsets.all(5),

      constraints: BoxConstraints(),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      onPressed: () {
        if (isPaused) {
          setState(() {
            controller.resume();
          });
        } else {
          setState(() {
            controller.pause();
          });
        }
        isPaused = !isPaused;
      },
    );
  }


  Widget _buildResetButton() {
    return RawMaterialButton(
      child: Icon(Icons.refresh),
      shape: CircleBorder(),
      fillColor: Colors.white,
      elevation: 2.5,
      padding: EdgeInsets.all(5),

      constraints: BoxConstraints(),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      onPressed: () {
        setState(() {
          controller.restart();
          controller.pause();
          isPaused = true;
        });
      },
    );
  }
}

