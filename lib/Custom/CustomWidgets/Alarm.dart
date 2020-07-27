import "package:flutter/material.dart";
import "package:numberpicker/numberpicker.dart";
import "package:countdown_flutter/countdown_flutter.dart";

/// Overall class that displays the time picker and countdown.
class Alarm extends StatefulWidget {
  @override
  _AlarmState createState() => _AlarmState();
}

class _AlarmState extends State<Alarm> {
  int hour = 0;
  int minute = 0;
  int second = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 50),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                Text("Hrs"),
                NumberPicker.integer(
                  initialValue: 0,
                  minValue: 0,
                  maxValue: 24,
                  infiniteLoop: true,
                  onChanged: (val) => hour = val,
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Text("Mins"),
                NumberPicker.integer(
                  initialValue: 0,
                  minValue: 0,
                  maxValue: 60,
                  infiniteLoop: true,
                  onChanged: (val) => minute = val,
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Text("Sec"),
                NumberPicker.integer(
                  initialValue: 0,
                  minValue: 0,
                  maxValue: 60,
                  infiniteLoop: true,
                  onChanged: (val) => second = val,
                ),
              ],
            ),
          ],
        ), // Row of NumberPickers
        SizedBox(height: 20),
        Center( // Start button
          child: Container(
            child: Ink(
              decoration: ShapeDecoration(
                color: Color(0xffDB3A34),
                shape: CircleBorder(),
              ),
              child: IconButton(
                icon: Icon(Icons.play_arrow),
                color: Colors.white,
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Center(child: CountDown(hour, minute, second));
                    }
                  );
                }
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// Class that takes in a duration and shows a countdown.
class CountDown extends StatefulWidget {
  final int hour;
  final int minute;
  final int second;
  const CountDown(this.hour, this.minute, this.second);
  @override
  _CountDownState createState() => _CountDownState();
}

class _CountDownState extends State<CountDown> {
  @override
  Widget build(BuildContext context) {
    return CountdownFormatted(
      duration: Duration(
        hours: widget.hour,
        minutes: widget.minute,
        seconds: widget.second,
      ),
      builder: (BuildContext ctx, String remaining) {
        return Text(
          remaining,
          style: TextStyle(fontSize: 30, color: Colors.blue),
        ); // 01:00:00
      },
    );
  }
}
