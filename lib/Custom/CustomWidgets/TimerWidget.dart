import "package:flutter/material.dart";
import "package:numberpicker/numberpicker.dart";
import "package:countdown_flutter/countdown_flutter.dart";

class Alarm extends StatefulWidget {
  @override
  _AlarmState createState() => _AlarmState();
}

//Class used to set the count down timing
class _AlarmState extends State<Alarm> {
  int hour = 0;
  int minute = 0;
  int second = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.5 * MediaQuery.of(context).devicePixelRatio),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(13,0,0,0),
            child: Row(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text("Hrs"),
                    NumberPicker.integer(
                      initialValue: 24,
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
                    initialValue: 60,
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
                    initialValue: 60,
                    minValue: 0,
                    maxValue: 60,
                    infiniteLoop: true,
                    onChanged: (val) => second = val,
                  ),
                ],
              ),
              ],
            ),
          ), // Row of NumberPickers
          SizedBox(
            height: 30,
          ),
          Center( // Start button
            child: Container(
              child: Ink(
                decoration: const ShapeDecoration(
                  color: Colors.pink,
                  shape: CircleBorder(),
                ),
                child: IconButton(
                  icon: Icon(Icons.play_arrow),
                  color: Colors.white,

                  onPressed: () {
                    showModalBottomSheet(context: context, builder: (context) {
                      return Container(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                          child: Center(child: CountDown(hour, minute,second)),
                        ),
                      );
                    });
                  }
                ),
              ),
            ),
          ),
        ],
      )
    );
  }
}


//Class used to show the countdown
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
    return  CountdownFormatted(
            duration: Duration(
            hours: widget.hour,
            minutes: widget.minute,
            seconds: widget.second,
            ),
            builder: (BuildContext ctx, String remaining) {
              return Text(
                remaining,
                style: TextStyle(fontSize: 35),
              ); // 01:00:00
            },
          );
  }
}
