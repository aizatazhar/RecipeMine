import 'package:flutter/material.dart';
import 'package:recipemine/pages/Home/Profile/RecipeBuilder/IngredientAdder/IngredientTile.dart';


import '../../../../../AppStyle.dart';

class IngredientAdder extends StatefulWidget {

  final List<dynamic> ingredients;

  IngredientAdder({this.ingredients});

  @override
  _IngredientAdderState createState() => _IngredientAdderState();
}

class _IngredientAdderState extends State<IngredientAdder> {
  final List<String> siUnits = ['', 'grams', 'kg', 'ml', 'litres', 'pcs','tablespoon','teaspoon', 'pinch', 'cup'];
  final _formKey = GlobalKey<FormState>();

  FocusNode _ingredientNameFocusNode = FocusNode();
  FocusNode _quantityFocusNode = FocusNode();

  String name = '';
  String quantity = '';
  String unit = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(vertical: 10),
              itemCount: widget.ingredients.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: UniqueKey(),
                  onDismissed: (direction){
                    setState(() {
                      widget.ingredients.removeAt(index);
                    });
                  },
                  child: IngredientTile(
                    ingredient: widget.ingredients[index],
                    ingredients: widget.ingredients,
                    index: index,
                  ),
                );
              },
            ),
          ),
          Text('Swipe to remove ingredient from recipe', style:AppStyle.caption),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FloatingActionButton(
              child: Icon(Icons.add),
              backgroundColor: Colors.redAccent,
              elevation: 0,
              onPressed: () {
                showModalBottomSheet<void>(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) {
                      return _buildIndividualIngredientAdder(widget.ingredients);
                    }
                );
              },
            ),
          ),
          SizedBox(height: 15),
        ],
      ),
    );
  }

  Widget _buildIndividualIngredientAdder(List<dynamic> ingredients){

    return Container(
      child: Scaffold(
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
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Add an ingredient to your Recipe",
                    style: AppStyle.mediumHeader,
                  ),
                  SizedBox(height: 30),
                  TextFormField(
                    focusNode: _ingredientNameFocusNode,
                    initialValue: '',
                    decoration: AppStyle.pantryInputDecoration.copyWith(
                      labelText: "Ingredient name",
                      labelStyle: TextStyle(
                          color: _ingredientNameFocusNode.hasFocus
                              ? Colors.redAccent
                              : Colors.grey[700]
                      ),
                    ),
                    validator: (val) => val.isEmpty ? 'Please enter an ingredient' : null,
                    onChanged: (val) => setState(() => name = val),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    focusNode: _quantityFocusNode,
                    initialValue: '',
                    keyboardType: TextInputType.number,
                    decoration: AppStyle.pantryInputDecoration.copyWith(
                      labelText: "Quantity",
                      labelStyle: TextStyle(
                          color: _quantityFocusNode.hasFocus
                              ? Colors.redAccent
                              : Colors.grey[700]
                      ),
                    ),
                    validator: (val) => val.isEmpty ? 'Please enter a quantity' : null,
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
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12,0,12,0),
                    child: RaisedButton(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        color: Colors.redAccent,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Add Instruction to recipe',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            setState(() {
                              ingredients.add(quantity + ',' + unit + ',' + name);
                              quantity = '';
                              unit = '';
                              name = '';
                            });
                            Navigator.pop(context);
                          }
                        }
                    ),
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
