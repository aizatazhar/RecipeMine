import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipemine/AppStyle.dart';
import 'package:recipemine/Custom/CustomWidgets/MainButton.dart';
import 'package:recipemine/Custom/Models/ReciperMinerUser.dart';

class CompletionScreen extends StatefulWidget {
  final List<dynamic> properties;
  final List<dynamic> instructions;
  final List<dynamic> ingredients;
  final List<dynamic> smartTimer;
  final RecipeMiner currentUser;
  String imageURL;

  CompletionScreen(
    {
      this.properties,
      this.instructions,
      this.ingredients,
      this.smartTimer,
      this.imageURL,
      this.currentUser
    }
  );

  @override
  _CompletionScreenState createState() => _CompletionScreenState();
}

class _CompletionScreenState extends State<CompletionScreen>  {
  bool disableButton = true;

  @override
  Widget build(BuildContext context) {
    if(widget.properties[3] != null){
      disableButton = false;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: <Widget>[
          SizedBox(height:20),
          Text(
            'Upload a picture of your dish!',
            style: AppStyle.mediumHeader
          ),
          SizedBox(height:20),
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: SizedBox(
                width: 200.0,
                height: 200.0,
                child: Image.network(
                  widget.imageURL ?? 'https://firebasestorage.googleapis.com/v0/b/recipemine-18d5f.appspot.com/o/67894614-organic-food-background-food-photography-different-fruits-on-wood-background-copy-space-.jpg?alt=media&token=cfe240ec-43a7-44f9-a979-066a1bf663e9',
                  fit: BoxFit.cover,
                  width: 1000,
                  height: 1000,
                ),
              ),
            ),
          ),
          SizedBox(height:10),
          Center(
              child:IconButton(
                icon: Icon(Icons.edit),
                onPressed: () async {
                  await _getImage();
                  setState(() {
                  });
                },
              )
          ),
          SizedBox(height: 30),
          MainButton(
            child: Text(
              "Publish my recipe!",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            width: double.maxFinite,
            onPressed: () async {
              if (!disableButton) {
                await uploadRecipe();
                Navigator.pop(context);
              }
            },
          ),
          SizedBox(height: 10),
          Text(
            'Your recipe will only be uploaded if you have saved your recipe properties.',
            style: AppStyle.caption,
            textAlign: TextAlign.center
          ),
        ],
      ),
    );
  }

  Future _getImage() async {
    var image = await ImagePicker().getImage(
        source: ImageSource.gallery,
        imageQuality: 50
    );

    String fileName = basename(image.path);
    StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child(
        fileName);
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(File(image.path));
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;

    await FirebaseStorage.instance
        .ref()
        .child(fileName)
        .getDownloadURL()
        .then((value) {
             widget.imageURL = value;
    });
  }

  Future<void> uploadRecipe() async {
    List<dynamic> buffer = [];
    widget.ingredients.forEach((element) {
      List<String> splitIngredients = element.split(",");
      String numericalQuantity = splitIngredients[0];
      String units = splitIngredients[1];
      String name = splitIngredients[2];
      buffer.add(numericalQuantity + ' '+ units + ' '+ name);
    });
    return await Firestore.instance.collection('Recipes').document().setData({
      'duration' : widget.properties[2],
      'imageURL' : widget.imageURL ?? 'https://firebasestorage.googleapis.com/v0/b/recipemine-18d5f.appspot.com/o/67894614-organic-food-background-food-photography-different-fruits-on-wood-background-copy-space-.jpg?alt=media&token=cfe240ec-43a7-44f9-a979-066a1bf663e9',
      'ingredients' : buffer,
      'instructions' : widget.instructions,
      'smartTimer' : widget.smartTimer,
      'name': widget.properties[0],
      'rating' : widget.properties[4],
      'servingSize': widget.properties[1],
      'type' : widget.properties[3],
      'authorUID' : widget.currentUser.email,
      'ratings' : [5]
    });
  }
}
