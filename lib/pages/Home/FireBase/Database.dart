
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recipemine/Custom/Models/ReciperMinerUser.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ this.uid });

  // collection reference
  final Firestore db = Firestore.instance;


  Future<void> updateUserData(String name, String email, String UID, String ProfilePic, List<String> Pantry) async {
    return await db.collection('Users').document(uid).setData({
      'name': name,
      'email': email,
      'UID': UID,
      'ProfilePic': ProfilePic,
      'Pantry' : Pantry
    });

  }
  // get ALL user doc stream
  Stream<List<RecipeMiner>> get DBusers{
    return db.collection('Users').snapshots().map(convertAll);
  }

  //get CurrentUser
  Stream<RecipeMiner> get userData {
    return db.collection('Users').document(uid).snapshots()
        .map(_userDataFromSnapshot);
  }

  List<RecipeMiner> convertAll(QuerySnapshot snaps){
    return snaps.documents.map((doc){
      return RecipeMiner(
        name: doc.data['name'] ?? 'new user',
        email: doc.data['email'] ?? 'email',
        uid: doc.data['UID'] ?? 'UIDSS',
        ProfilePic: doc.data['ProfilePic'] ?? ''
      );
    }).toList();
  }

  RecipeMiner _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return RecipeMiner(
        uid: snapshot.data['UID'] ?? '',
        name: snapshot.data['name'] ?? '',
        email: snapshot.data['email']?? '',
        ProfilePic: snapshot.data['ProfilePic'] ?? ''

    );
  }

}
