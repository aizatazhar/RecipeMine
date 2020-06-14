import 'package:flutter/material.dart';
import 'package:recipemine/pages/Authentication/Authenticate.dart';
import 'package:provider/provider.dart';
import 'package:recipemine/Custom/Models/User.dart';
import 'package:recipemine/pages/Home/HomeWrapper.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    if (user == null){
      return Authenticate();
    } else {
      return HomeWrapper();
    }
  }
}
