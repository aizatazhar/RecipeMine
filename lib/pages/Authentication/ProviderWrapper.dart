import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipemine/pages/Authentication/Services/Auth.dart';
import 'package:recipemine/pages/Authentication/Wrapper.dart';
import 'package:recipemine/Custom/Models/User.dart';

class ProviderWrapper extends StatefulWidget {
  @override
  _ProviderWrapperState createState() => _ProviderWrapperState();
}

class _ProviderWrapperState extends State<ProviderWrapper> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
          home: Wrapper()
      ),
    );
  }
}
