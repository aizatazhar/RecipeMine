import 'package:flutter/material.dart';
import 'package:recipemine/pages/Ingredients.dart';
import 'package:recipemine/pages/ending.dart';
import 'package:recipemine/pages/step1.dart';
import 'package:recipemine/pages/step2.dart';
import 'package:recipemine/pages/step3.dart';
import 'package:recipemine/pages/step4.dart';

class CookingAssistant extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageView(
      children: <Widget>[
        IngredientList(),
        Step1(),
        Step2(),
        Step3(),
        Step4(),
        Ending(),
      ],
    );
  }
}
