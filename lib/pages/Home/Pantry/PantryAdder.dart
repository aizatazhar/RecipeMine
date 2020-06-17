import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipemine/Constants.dart';
import 'package:recipemine/Custom/Models/ReciperMinerUser.dart';
import 'package:recipemine/Custom/Models/User.dart';
import 'package:recipemine/pages/Home/FireBase/Database.dart';
import 'package:recipemine/pages/LoadingScreen.dart';

class PantryAdder extends StatefulWidget {


  @override
  _PantryAdderState createState() => _PantryAdderState();
}

class _PantryAdderState extends State<PantryAdder> {

  final _formKey = GlobalKey<FormState>();
  final List<String> siUnits = ['','grams','kg','ml','litres','pcs'];
  final List<String> categories = ['','Vegetable','Fish','Meat','Grains','Fruits','Condiment','NA'];
  String name = 'input ingredient name';
  String quantity = 'input ingredient quantity';
  String unit = '';
  String Category = '';


  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);

    Color colorgetter(String Category){
      if(Category == 'Vegetable'){
        return Colors.green;
      } else if(Category == 'Fish'){
        return Colors.lightBlueAccent;
      } else if(Category == 'Meat'){
        return Colors.red;
      } else if(Category == 'Grains'){
        return Colors.brown[150];
      } else if(Category == 'Fruits') {
        return Colors.deepPurple;
      } else if(Category == 'Condiment'){
        return Colors.orange;
      } else {
        return Colors.black;
      }
    }

    return StreamBuilder<RecipeMiner>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if(snapshot.hasData){
            RecipeMiner userData = snapshot.data;
            return Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20.0),
                  Text(
                    'Add an ingredient to your pantry',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(height: 30.0),
                  Text('Add ingredient Category',
                    style: TextStyle(fontSize: 14.0),
                  ),
                  SizedBox(height: 10.0),
                  DropdownButtonFormField(
                    value: Category ?? '',
                    decoration: textInputDecoration.copyWith(hintText: 'Type of ingredient'),
//                    validator: (val) => val == ''? 'Please set a category' : null,
                    items: categories.map((units) {
                      return DropdownMenuItem(
                        value: units,
                        child: Text(units, style: TextStyle(color: colorgetter(units)),),
                      );
                    }).toList(),
                    onChanged: (val) => setState(() => Category = val ),
                  ),
                  SizedBox(height: 20.0),
                  Text('Input name of ingredient',
                    style: TextStyle(fontSize: 14.0),
                  ),
                  SizedBox(height: 10.0),
                  TextFormField(
                    initialValue: '',
                    decoration: textInputDecoration.copyWith(hintText: 'Ingredient'),
                    validator: (val) => val.isEmpty ? 'Please enter an ingredient' : null,
                    onChanged: (val) => setState(() => name = val),
                  ),
                  SizedBox(height: 20.0),
                  Text('Input quantity of ingredient',
                    style: TextStyle(fontSize: 14.0),
                  ),
                  SizedBox(height: 10.0),
                  TextFormField(
                    initialValue: '',
                    keyboardType: TextInputType.number,
                    decoration: textInputDecoration.copyWith(hintText: 'Quantity'),
                    validator: (val) => val.isEmpty ? 'Please enter a quantity' : null,
                    onChanged: (val) => setState(() => quantity = val),

                  ),
                  SizedBox(height: 20.0),
                  Text('Specify units',
                    style: TextStyle(fontSize: 14.0),
                  ),
                  SizedBox(height: 10.0),
                  DropdownButtonFormField(
                    value: unit ?? '',
                    decoration: textInputDecoration.copyWith(hintText: 'Units'),
                    items: siUnits.map((units) {
                      return DropdownMenuItem(
                        value: units,
                        child: Text(units),
                      );
                    }).toList(),
                    onChanged: (val) => setState(() => unit = val ),
                  ),
                  SizedBox(height: 40.0),
                  RaisedButton(
                      color: Colors.pink[400],
                      child: Text(
                        'update',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        snapshot.data.pantry.add(name + "," + quantity +" "+ unit+ "," + Category);
                          if (_formKey.currentState.validate()) {
                            await DatabaseService(uid: user.uid).updateUserData(
                                snapshot.data.name,
                                snapshot.data.email,
                                snapshot.data.uid,
                                snapshot.data.profilePic,
                                snapshot.data.pantry,
                                snapshot.data.favourites,
                            );
                            Navigator.pop(context);
                          }
                      }
                  ),
                ],
              ),
            );
          } else {
            return Loading();
          }
        }
    );


  }
}
