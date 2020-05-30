import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:countdown_flutter/countdown_flutter.dart';

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
          child: Padding(
            padding: const EdgeInsets.all(54.0),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text('Hrs'),
                        NumberPicker.integer(
                            initialValue: 24,
                            minValue: 0,
                            maxValue: 24,
                            infiniteLoop: true,
                            onChanged: (val){
                              hour = val;
                            }),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Text('Mins'),
                        NumberPicker.integer(
                            initialValue: 60,
                            minValue: 0,
                            maxValue: 60,
                            infiniteLoop: true,
                            onChanged: (val){
                              minute = val;
                            }),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Text('Sec'),
                        NumberPicker.integer(
                            initialValue: 60,
                            minValue: 0,
                            maxValue: 60,
                            infiniteLoop: true,
                            onChanged: (val){
                              second = val;
                            }),
                      ],
                    ),
                  ],
                ), // Row of NumberPickers
                SizedBox(
                  height: 30,
                ),
                Center(
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
                            Navigator.pushNamed(context, '/CountDown', arguments: {
                              'hour': this.hour,
                              'minute':this.minute,
                              'second':this.second,
                            });
                          }
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
      );;
  }
}

//Class used to show the countdown
class CountDown extends StatefulWidget {
  @override
  _CountDownState createState() => _CountDownState();
}

class _CountDownState extends State<CountDown> {
  Map data = {};
  @override
  Widget build(BuildContext context) {

    data = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        backgroundColor: Colors.pink[100],
        appBar: AppBar(
          backgroundColor: Colors.pink[200],
          title: Text('Timer'),
          centerTitle: true,
          elevation: 0,
        ),
        body: Container(
          child: Center(
            child: CountdownFormatted(
              duration: Duration(hours: data['hour'], minutes: data['minute'], seconds: data['second']),
              builder: (BuildContext ctx, String remaining) {
                return Text(
                  remaining,
                  style: TextStyle(fontSize: 30),
                ); // 01:00:00
              },
            ),
          )
        )
    );
  }
}
