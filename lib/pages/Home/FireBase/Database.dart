import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recipemine/Custom/Models/Recipe.dart';
import 'package:recipemine/Custom/Models/ReciperMinerUser.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ this.uid });

  // collection reference
  final Firestore db = Firestore.instance;

  Future<void> updateUserData(String name, String email, String uid,
      String profilePic, List<dynamic> pantry, List<dynamic> favourites) async {
    return await db.collection('Users').document(uid).setData({
      'name': name,
      'email': email,
      'UID': uid,
      'ProfilePic': profilePic,
      'Pantry' : pantry,
      'Favourites': favourites,
    });
  }

  // get CurrentUser methods
  Stream<RecipeMiner> get userData {
    return db.collection('Users').document(uid).snapshots()
        .map(_userDataFromSnapshot);
  }

  RecipeMiner _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return RecipeMiner(
        uid: snapshot.data['UID'] ?? '',
        name: snapshot.data['name'] ?? '',
        email: snapshot.data['email']?? '',
        profilePic: snapshot.data['ProfilePic'] ?? '',
        pantry: snapshot.data['Pantry'],
        favourites: snapshot.data['Favourites'],

    );
  }

  // get all users methods
  Stream<List<RecipeMiner>> get DBusers{
    return db.collection('Users').snapshots().map(allUserDataConversion);
  }

  List<RecipeMiner> allUserDataConversion(QuerySnapshot snaps){
    return snaps.documents.map((doc){
      return RecipeMiner(
          name: doc.data['name'] ?? 'new user',
          email: doc.data['email'] ?? 'email',
          uid: doc.data['UID'] ?? 'UIDSS',
          profilePic: doc.data['ProfilePic'] ?? '',
          pantry: doc.data['Pantry'],
        favourites: doc.data['Favourites'],
      );
    }).toList();
  }

  // get all Recipes methods
  Stream<List<Recipe>> get recipeData{
    return db.collection('Recipes').snapshots().map(_recipeDataFromSnapShot);
  }

  List<Recipe> _recipeDataFromSnapShot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return Recipe(
        id: doc.documentID,
        name: doc.data['name'],
        type: RecipeType.values[doc.data['type']],
        rating: doc.data['rating'],
        duration : doc.data['duration'],
        servingSize: doc.data['servingSize'],
        imageURL: doc.data['imageURL'],
        ingredients: doc.data['ingredients'],
        instructions: doc.data['instructions'],
        smartTimer: doc.data['smartTimer'],
        ratings: doc.data['ratings'],
        authorUID: doc.data['authorUID'],
      );
    }).toList();
  }
}
