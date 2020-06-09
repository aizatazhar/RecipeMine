
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recipemine/Custom/Models/RecipeMinerProfile.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ this.uid });

  // collection reference
  final Firestore db = Firestore.instance;


  Future<void> updateUserData(String name, String email) async {
    return await db.document(uid).setData({
      'name': name,
      'email': email,
    });

  }

   Stream<QuerySnapshot> get DB{
    return db.collection('Users').snapshots();
  }

  Future<RecipeMinerProfile> getCurrentUserDetails(String userUID) async {
    RecipeMinerProfile currentUser;
    await Firestore.instance.collection('Users').document(userUID).get().then( (user){
      currentUser = new RecipeMinerProfile(
          name: user.data['name'],
          EmailAddress: user.data['email']
      );
    });
    return currentUser;
  }
}
