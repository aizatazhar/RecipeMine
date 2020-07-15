import 'package:flutter/material.dart';
import 'package:recipemine/Custom/CustomWidgets/MainButton.dart';
import 'package:recipemine/pages/Home/Profile/RecipeBuilder/InstructionsAdder/InstructionTile.dart';

import '../../../../../AppStyle.dart';

class InstructionsAdder extends StatefulWidget {
  final List<dynamic> instructions;
  final List<dynamic> smartTimer;

  InstructionsAdder({this.instructions, this.smartTimer});
  @override
  _InstructionsAdderState createState() => _InstructionsAdderState();
}

class _InstructionsAdderState extends State<InstructionsAdder> {
  FocusNode _stepNode = FocusNode();
  FocusNode _instructionNode = FocusNode();
  FocusNode _hoursNode = FocusNode();
  FocusNode _minutesNode = FocusNode();
  FocusNode _secondsFocusNode = FocusNode();

  String hours = '0';
  String minutes = '0';
  String seconds = '0';
  String instruction = '';
  String step = '0';

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(vertical: 10),
              itemCount: widget.instructions.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: UniqueKey(),
                  onDismissed: (direction){
                    setState(() {
                      widget.instructions.removeAt(index);
                      widget.smartTimer.removeAt(index);
                    });
                  },
                  child: InstructionTile(
                    instructions: widget.instructions,
                    smartTimer: widget.smartTimer,
                    index: index,
                  ),
                );
              },
            ),
          ),
          Text('Swipe to remove instruction from recipe', style:AppStyle.caption),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: FloatingActionButton(
              child: Icon(Icons.add),
              backgroundColor: Colors.redAccent,
              elevation: 5,
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                    builder: (BuildContext context) => _buildIndividualInstructionAdder(widget.instructions, widget.smartTimer)
                ));
              },
            ),
          ),
          SizedBox(height: 15),
        ],
      ),
    );
  }

  //just have an additional steps field to insert recipe
  Widget _buildIndividualInstructionAdder(List<dynamic> instructions, List<dynamic> smartTimer){
    return Container(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              setState(() {
                hours = '0';
                minutes = '0';
                seconds = '0';
                step = '0';
              });
              Navigator.of(context).pop();
            },
          ),
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Add instructions', style: AppStyle.mediumHeader),
                  SizedBox(height: 25),
                  TextFormField(
                    focusNode: _stepNode,
                    initialValue: (widget.instructions.length+1).toString() ,
                    keyboardType: TextInputType.number,
                    maxLines: null,
                    decoration: AppStyle.pantryInputDecoration.copyWith(
                      labelText: "Step number",
                      labelStyle: TextStyle(
                          color: _stepNode.hasFocus
                              ? Colors.redAccent
                              : Colors.grey[700]
                      ),
                    ),
                    onChanged: (val) => setState(() => step = val),
                    validator: (val) => int.parse(val) > (instructions.length+1) ? 'Please insert step ' + (instructions.length+1).toString() + '\nOR insert instruction between previous steps'  : null,
                  ),
                  SizedBox(height: 25),
                  TextFormField(
                    focusNode: _instructionNode,
                    initialValue: '',
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: AppStyle.pantryInputDecoration.copyWith(
                      labelText: "Instruction for step",
                      labelStyle: TextStyle(
                          color: _instructionNode.hasFocus
                              ? Colors.redAccent
                              : Colors.grey[700]
                      ),
                    ),
                    onChanged: (val) => setState(() => instruction = val),
                    validator: (val) => val.isEmpty? 'Please insert instruction' : null,
                  ),
                  SizedBox(height: 25),
                  Text('SmartTimer Settings', style: AppStyle.caption),
                  SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Flexible(
                        flex: 1,
                        child: TextFormField(
                          focusNode: _hoursNode,
                          initialValue: '0',
                          keyboardType: TextInputType.number,
                          decoration: AppStyle.pantryInputDecoration.copyWith(
                            labelText: "Hours",
                            labelStyle: TextStyle(
                                color: _hoursNode.hasFocus
                                    ? Colors.redAccent
                                    : Colors.grey[700]
                            ),
                          ),
                          onChanged: (val) => setState(() => hours = val),
                        ),
                      ),
                      SizedBox(width: 10),
                      Flexible(
                        flex: 1,
                        child: TextFormField(
                          focusNode: _minutesNode,
                          initialValue: '0',
                          keyboardType: TextInputType.number,
                          decoration: AppStyle.pantryInputDecoration.copyWith(
                            labelText: "Minutes",
                            labelStyle: TextStyle(
                                color: _minutesNode.hasFocus
                                    ? Colors.redAccent
                                    : Colors.grey[700]
                            ),
                          ),
                          onChanged: (val) => setState(() => minutes = val),
                          validator: (val) => int.parse(val) >= 60 ? 'Less than 60' : null,
                        ),
                      ),
                      SizedBox(width: 10),
                      Flexible(
                        flex: 1,
                        child: TextFormField(
                          focusNode: _secondsFocusNode,
                          initialValue: '0',
                          keyboardType: TextInputType.number,
                          decoration: AppStyle.pantryInputDecoration.copyWith(
                            labelText: "Seconds",
                            labelStyle: TextStyle(
                                color: _secondsFocusNode.hasFocus
                                    ? Colors.redAccent
                                    : Colors.grey[700]
                            ),
                          ),
                          onChanged: (val) => setState(() => seconds = val),
                          validator: (val) =>  int.parse(val) >= 60 ? 'Less than 60' : null,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  MainButton(
                    child: Text(
                      'Add instruction to recipe',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    width: double.maxFinite,
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        setState(() {
                          if(step == '0'){
                            setState(() {
                              step = (widget.instructions.length+1).toString();
                            });
                          }
                          widget.instructions.insert(int.parse(step) - 1, instruction);
                          widget.smartTimer.insert(int.parse(step) - 1, hours.trim() + ',' + minutes.trim() + ',' + seconds.trim());
                          hours = '0';
                          minutes = '0';
                          seconds = '0';
                          step = '0';
                        });
                        Navigator.pop(context);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
