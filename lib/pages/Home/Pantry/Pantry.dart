import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:recipemine/Custom/Models/ReciperMinerUser.dart';
import 'package:recipemine/Custom/Models/User.dart';
import 'package:recipemine/pages/Home/FireBase/Database.dart';
import 'package:recipemine/pages/Home/Pantry/CategoryColor.dart';

import '../../../AppStyle.dart';
import 'PantryAdder.dart';

class Pantry extends StatefulWidget {
  @override
  _PantryState createState() => _PantryState();
}

class _PantryState extends State<Pantry> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  Widget _buildBody() {
    final users = Provider.of<List<RecipeMiner>>(context) ?? [];
    final currentUserUID = Provider.of<User>(context);

    // contains the current user details
    RecipeMiner currentUserData = RecipeMiner(
        name: 'Loading',
        email: 'Loading',
        uid: 'Loading',
        profilePic:
            'https://moonvillageassociation.org/wp-content/uploads/2018/06/default-profile-picture1.jpg',
        pantry: []);
    users.forEach((element) {
      if (element.uid == currentUserUID.uid) {
        currentUserData = element;
      }
    });

    return currentUserData.pantry.length > 0
        ? _buildPantryView(currentUserData)
        : _buildEmptyPantryView();
  }

  Widget _buildPantryView(RecipeMiner currentUserData) {
    var userPantry = currentUserData.pantry;

    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: 10),
      itemCount: userPantry.length,
      itemBuilder: (context, index) {
        return PantryTile(
          ingredient: userPantry[index],
          currentUser: currentUserData,
          index: index,
        );
      },
    );
  }

  Widget _buildEmptyPantryView() {
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            AppStyle.buildEmptyViewIcon(Icons.kitchen),
            SizedBox(height: 20),
            Text(
              "No ingredients in your pantry",
              style: AppStyle.emptyViewHeader,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              "Your pantry ingredients can be used to search for recipes.",
              style: AppStyle.emptyViewCaption,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  FloatingActionButton _buildFloatingActionButton() {
    return FloatingActionButton(
      child: Icon(Icons.add),
      backgroundColor: Colors.redAccent,
      elevation: 0,
      onPressed: () {
        showModalBottomSheet<void>(
          context: context,
          isScrollControlled: true,
          builder: (context) {
            return PantryAdder();
          }
        );
      },
    );
  }
}

class PantryTile extends StatelessWidget {
  final String ingredient;
  final RecipeMiner currentUser;
  final int index;

  PantryTile({this.ingredient, this.currentUser, this.index});

  @override
  Widget build(BuildContext context) {
    List<String> splitIngredients = ingredient.split(",");
    String name = splitIngredients[0];
    String quantity = splitIngredients[1];
    String category = splitIngredients[2];

    return Card(
      margin: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
      child: ListTile(
        leading: Container(
          width: 80,
          child: Center(
            child: Text(
              category,
              style: TextStyle(color: CategoryColor.get(category)),
            ),
          ),
        ),
        title: Text(name),
        subtitle: Text("Quantity: " + quantity),
        trailing: IconButton(
          icon: Icon(Icons.remove),
          onPressed: () {
            currentUser.pantry.remove(ingredient);
            DatabaseService().updateUserData(
                currentUser.name,
                currentUser.email,
                currentUser.uid,
                currentUser.profilePic,
                currentUser.pantry,
                currentUser.favourites);
          },
        ),
      ),
    );
  }
}
