import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipemine/Custom/Models/ReciperMinerUser.dart';
import 'package:recipemine/Custom/Models/User.dart';
import 'package:recipemine/pages/Authentication/Services/Auth.dart';
import 'package:recipemine/pages/Home/FireBase/Database.dart';

class PantryList extends StatefulWidget {
  @override
  _PantryListState createState() => _PantryListState();
}

class _PantryListState extends State<PantryList> {
  @override
  Widget build(BuildContext context) {

    final AuthService _auth = AuthService();
    final users = Provider.of<List<RecipeMiner>>(context) ?? [];
    final currentUserUID = Provider.of<User>(context);


    //contains the currentuser details
    RecipeMiner currentUserData = RecipeMiner(name:'Loading',email: 'Loading',uid: 'Loading', profilePic: 'https://moonvillageassociation.org/wp-content/uploads/2018/06/default-profile-picture1.jpg', pantry: []);
    users.forEach((element) {
      if(element.uid == currentUserUID.uid){
        currentUserData = element;
      }
    });
    List<dynamic> userPantry = currentUserData.pantry;

    return ListView.builder(
      itemCount: userPantry.length,
      itemBuilder: (context, index) {
        return PantryTile(ingredient: userPantry[index], currentUser: currentUserData, index: index,);
      },
    );
  }
}

class PantryTile extends StatelessWidget {
  final String ingredient;
  final RecipeMiner currentUser;
  final int index;
  PantryTile({ this.ingredient , this.currentUser, this.index});

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

  @override
  Widget build(BuildContext context) {

    String name = ingredient.split(",")[0];
    String quantity = ingredient.split(",")[1];
    String Category = ingredient.split(',')[2];


    return Card(
      margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
      child: ListTile(
        leading: Padding(
          padding: const EdgeInsets.fromLTRB(0,0,0,7),
          child: Container(
            width: 90,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0,10,0,0),
                child: Text(Category,
                  style: TextStyle(
                      color: colorgetter(Category)),
                  ),
              ),
            ),
          ),
        ),
        title: Text(name),
        subtitle: Text("Qty: " +  quantity),
        trailing: IconButton(
          icon: Icon(Icons.remove),
          onPressed: (){
              currentUser.pantry.remove(ingredient);
              DatabaseService().updateUserData(currentUser.name, currentUser.email, currentUser.uid, currentUser.profilePic, currentUser.pantry,currentUser.favourites);
          },
        ),
      ),
    );
  }
}