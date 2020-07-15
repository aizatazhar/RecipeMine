import 'package:flutter/material.dart';

class InstructionTile extends StatelessWidget {
  final List<dynamic> instructions;
  final List<dynamic> smartTimer;
  final int index;

  InstructionTile({this.instructions, this.smartTimer, this.index});

  @override
  Widget build(BuildContext context) {
    String instruction = this.instructions[index];
    String smartTimer = this.smartTimer[index];



    return Card(
      margin: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
      child: ListTile(
        title: Text('Step ' + (index+1).toString() + " : \n" + instruction),
        subtitle: smartTimerProcessor(smartTimer).isEmpty ? null : Text('Smart Timer: ' + smartTimerProcessor(smartTimer)),
      ),
    );
  }

  String smartTimerProcessor(String time){

    String hours = time.split(',')[0];
    String minutes = time.split(',')[1];
    String seconds = time.split(',')[2];


    if(hours != 0.toString()){
      hours += ' Hours ';
    } else {
      hours = '';
    }
    if(minutes != 0.toString()){
      minutes += ' Minutes ';
    } else {
      minutes = '';
    }
    if(seconds != 0.toString()){
      seconds += ' Seconds ';
    } else {
      seconds = '';
    }

    return hours + minutes + seconds;
  }
}