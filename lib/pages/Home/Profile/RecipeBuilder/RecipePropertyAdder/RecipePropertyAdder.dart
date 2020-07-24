
import 'package:flutter/material.dart';
import 'package:recipemine/Custom/CustomWidgets/MainButton.dart';
import '../../../../../AppStyle.dart';

class RecipePropertyAdder extends StatefulWidget {
  final List<dynamic> properties;

  RecipePropertyAdder({this.properties});

  @override
  _RecipePropertyAdderState createState() => _RecipePropertyAdderState();
}

class _RecipePropertyAdderState extends State<RecipePropertyAdder> {
  FocusNode _nameFocusNode = FocusNode();
  FocusNode _nameServingSizeFocusNode = FocusNode();
  FocusNode _durationFocusNode = FocusNode();

  List<String> recipeType = ['','main','side','dessert','drinks'];
  String name = '';
  String type = '';
  double rating = 5;
  int duration = 0;
  int servingSize = 0;

  final _formKey = GlobalKey<FormState>();

  int getRecipeType(String type){
    if(type == 'main'){
      return 0;
    }
    if(type == 'side'){
      return 1;
    }
    if(type == 'dessert'){
      return 2;
    }
    if(type == 'drinks'){
      return 3;
    }
  }

  String getType(int type){
    if(type == 0){
      return 'main';
    }
    if(type == 1){
      return 'side';
    }
    if(type == 2){
      return 'dessert';
    }
    if(type == 3){
      return 'drinks';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: Text(
                    "Add properties to your recipe",
                    style: AppStyle.mediumHeader,
                  ),
                ),
                SizedBox(height:20),
                TextFormField(
                  focusNode: _nameFocusNode,
                  initialValue: widget.properties[0] ?? name,
                  decoration: AppStyle.pantryInputDecoration.copyWith(
                    labelText: "Recipe name",
                    labelStyle: TextStyle(
                        color: _nameFocusNode.hasFocus
                            ? Colors.redAccent
                            : Colors.grey[700]
                    ),
                  ),
                  validator: (val) => val.isEmpty ? 'Please enter a name' : null,
                  onChanged: (val) => setState(() => name = val),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  keyboardType: TextInputType.number,
                  focusNode: _nameServingSizeFocusNode,
                  initialValue:  widget.properties[1].toString() ?? servingSize.toString(),
                  decoration: AppStyle.pantryInputDecoration.copyWith(
                    labelText: "Recipe serving size",
                    labelStyle: TextStyle(
                        color: _nameServingSizeFocusNode.hasFocus
                            ? Colors.redAccent
                            : Colors.grey[700]
                    ),
                  ),
                  validator: (val) => val.isEmpty? 'Please enter a value' : null,
                  onChanged: (val) => setState(() => servingSize = int.parse(val.trim())),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  keyboardType: TextInputType.number,
                  focusNode: _durationFocusNode,
                  initialValue:  widget.properties[2].toString() ?? duration.toString(),
                  decoration: AppStyle.pantryInputDecoration.copyWith(
                    labelText: "Insert recipe cooking time(in minutes)",
                    labelStyle: TextStyle(
                        color: _durationFocusNode.hasFocus
                            ? Colors.redAccent
                            : Colors.grey[700]
                    ),
                  ),
                  validator: (val) => val.isEmpty? 'Please enter a value' : null,
                  onChanged: (val) => setState(() => duration = int.parse(val.trim())),
                ),
                SizedBox(height: 20.0),
                DropdownButtonFormField(
                  value: getType(widget.properties[3]) ?? '',
                  decoration: AppStyle.pantryInputDecoration.copyWith(
                    labelText: "Recipe type",
                    labelStyle: TextStyle(color: Colors.grey[700]),
                  ),
                  items: recipeType.map((units) {
                    return DropdownMenuItem(
                      value: units,
                      child: Text(units),
                    );
                  }).toList(),
                  onChanged: (val) => setState(() => type = val),
                  validator: (val) => val.isEmpty ? 'Please enter a RecipeType' : null,
                ),
                SizedBox(height: 30.0),
                MainButton(
                  child: Text(
                    "Save properties",
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
                        widget.properties.clear();
                        widget.properties.add(name);
                        widget.properties.add(servingSize);
                        widget.properties.add(duration);
                        widget.properties.add(getRecipeType(type));
                        widget.properties.add(rating);
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
