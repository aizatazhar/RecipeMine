import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:recipemine/AppStyle.dart';
import 'package:recipemine/Custom/CustomWidgets/MainButton.dart';
import 'package:recipemine/Custom/Models/ReciperMinerUser.dart';
import 'package:recipemine/Custom/Models/User.dart';
import 'package:recipemine/pages/Home/FireBase/Database.dart';
import 'package:recipemine/pages/Loading.dart';
import 'CategoryColor.dart';

/// Builds the page for adding a pantry ingredient.
class PantryAdder extends StatefulWidget {
  @override
  _PantryAdderState createState() => _PantryAdderState();
}

class _PantryAdderState extends State<PantryAdder> {
  final _formKey = GlobalKey<FormState>();
  final List<String> siUnits = ['', 'grams', 'kg', 'ml', 'litres', 'pcs'];
  final List<String> categories = [
    "",
    'Vegetable',
    'Fish',
    'Meat',
    'Grain',
    'Fruit',
    'Condiment',
  ];

  String name = '';
  String quantity = '';
  String unit = '';
  String category = '';

  bool _isAddingIngredient = false; // to update UI of button
  bool _buttonPressed = false; // so that user can only press the button once

  final _clearIconSize = 20.0;

  // Used to change color of label text when in focus
  FocusNode _ingredientNameFocusNode = FocusNode();
  FocusNode _quantityFocusNode = FocusNode();

  // Used to clear input
  final TextEditingController _ingredientController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();

  @override
  void dispose() {
    _ingredientNameFocusNode.dispose();
    _quantityFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: StreamBuilder<RecipeMiner>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Loading();
          }

          return Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Add an ingredient to your pantry",
                      style: AppStyle.mediumHeader,
                    ),
                    SizedBox(height: 30),
                    DropdownButtonFormField(
                      value: category ?? '',
                      decoration: AppStyle.pantryInputDecoration.copyWith(
                        labelText: "Category",
                        labelStyle: TextStyle(color: Colors.grey[700])
                      ),
                      items: categories.map((category) {
                        return DropdownMenuItem(
                          value: category,
                          child: Text(
                            category,
                            style: TextStyle(color: CategoryColor.get(category)),
                          ),
                        );
                      }).toList(),
                      onChanged: (val) => setState(() => category = val),
                      validator: (val) => val.isEmpty ? 'Please enter a category' : null,
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      focusNode: _ingredientNameFocusNode,
                      controller: _ingredientController,
                      decoration: AppStyle.pantryInputDecoration.copyWith(
                        labelText: "Ingredient name",
                        labelStyle: TextStyle(
                          color: _ingredientNameFocusNode.hasFocus
                              ? Colors.redAccent
                              : Colors.grey[700]
                        ),
                        suffixIcon: _ingredientNameFocusNode.hasFocus && _ingredientController.text.length > 0
                            ? _buildClearButton(_ingredientController)
                            : null,
                      ),
                      validator: ingredientValidator,
                      onChanged: (val) => setState(() => name = val),
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      focusNode: _quantityFocusNode,
                      controller: _quantityController,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        WhitelistingTextInputFormatter.digitsOnly
                      ],
                      decoration: AppStyle.pantryInputDecoration.copyWith(
                        labelText: "Quantity",
                        labelStyle: TextStyle(
                          color: _quantityFocusNode.hasFocus
                              ? Colors.redAccent
                              : Colors.grey[700]
                        ),
                        suffixIcon: _quantityFocusNode.hasFocus && _quantityController.text.length > 0
                            ? _buildClearButton(_quantityController)
                            : null,
                      ),
                      validator: quantityValidator,
                      onChanged: (val) => setState(() => quantity = val),
                    ),
                    SizedBox(height: 20.0),
                    DropdownButtonFormField(
                      value: unit ?? '',
                      decoration: AppStyle.pantryInputDecoration.copyWith(
                        labelText: "Units",
                        labelStyle: TextStyle(color: Colors.grey[700]),
                      ),
                      items: siUnits.map((units) {
                        return DropdownMenuItem(
                          value: units,
                          child: Text(units),
                        );
                      }).toList(),
                      onChanged: (val) => setState(() => unit = val),
                      validator: (val) => val.isEmpty ? 'Please enter a measuring unit' : null,
                    ),
                    SizedBox(height: 30.0),
                    _buildAddIngredientButton(user, snapshot),
                  ],
                ),
              ),
            ),
          );
        }
      ),
    );
  }

  Widget _buildAddIngredientButton(User user, AsyncSnapshot<RecipeMiner> snapshot) {
    return MainButton(
      width: double.maxFinite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            _isAddingIngredient
                ? "Adding ingredient..."
                : "Add ingredient to pantry",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
      onPressed: () async {
        if (!_buttonPressed) {
          String toAdd = "$name,$quantity $unit,$category";
          snapshot.data.pantry.add(toAdd);

          if (_formKey.currentState.validate()) {
            setState(() {
              _isAddingIngredient = true;
              _buttonPressed = true;
            });

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
      },
    );
  }

  Widget _buildClearButton(TextEditingController controller) {
    return IconButton(
      onPressed: () => controller.clear(),
      icon: Icon(
        Icons.clear,
        size: _clearIconSize,
        color: Colors.redAccent,
      ),
    );
  }
}

String ingredientValidator(String string) {
  return string.isEmpty ? 'Please enter an ingredient' : null;
}

String quantityValidator(String string) {
  return string.isEmpty ? 'Please enter a quantity' : null;
}
