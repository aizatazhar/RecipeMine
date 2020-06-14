import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Favourites extends StatefulWidget {
  @override
  _FavouritesState createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return StreamBuilder(
      stream: Firestore.instance.collection("Recipes").snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return SpinKitFadingCircle(color: Colors.blueGrey);
        } else {
          int recipesLength = snapshot.data.documents.length;

          // Reading <favourite> recipes from Firestore
          List<DocumentSnapshot> recipes = [];
          for (int i = 0; i < recipesLength; i++) {
            recipes.add(snapshot.data.documents[i]);
          }

          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 0.7,
            ),
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            itemCount: recipesLength,
            itemBuilder: (BuildContext context, int index) {
              return _buildCard(recipes[index]);
            }
          );
        }
      }
    );
  }

  Widget _buildCard(DocumentSnapshot recipe) {
    return GestureDetector(
      onTap: () {
        print("placeholder method for clicking on favourite recipe");
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 0.0),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
          child: Stack(
            children: <Widget>[
              Image.asset(
                recipe["imageURL"],
                fit: BoxFit.cover,
                width: 1000,
                height: 1000,
              ),
              Positioned(
                top: -5.0,
                right: -10.0,
                child: IconButton(
                  onPressed: () {
                    print("placeholder method for removing from favourites");
                  },
                  icon: Icon(Icons.favorite),
                  color: Colors.red,
                  iconSize: 20.0,
                ),
              ),
              Positioned( // Bottom text
                bottom: 0.0,
                left: 0.0,
                right: 0.0,
                child: Container(
                  decoration: BoxDecoration( // Tint to contrast
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(220, 0, 0, 0),
                        Color.fromARGB(0, 0, 0, 0)
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                  // the top padding is to smooth out the tint
                  padding: EdgeInsets.fromLTRB(10.0, 50.0, 10.0, 10.0),
                  child: Text(
                    recipe["name"],
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          )
        ),
      ),
    );
  }
}
