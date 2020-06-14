
import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:recipemine/Custom/Models/User.dart";

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String name;
  String email;


  @override
  Widget build(BuildContext context) {
    //UID
    var firebaseUser = Provider.of<User>(context);
    //change name to john
    Firestore.instance.collection("Users").document(firebaseUser.uid).updateData({"name":"john"});
    //checking
    Firestore.instance.collection("Users").document(firebaseUser.uid).get().then((value){
      print(value.data["name"]);
      print(value.data["email"]);
    });


    return Scaffold(
      body: Center(
          child: Text("Profile")
      ),
    );
  }
}
