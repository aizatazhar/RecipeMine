
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ this.uid });

  // collection reference
  final CollectionReference Users = Firestore.instance.collection('Users');

  Future<void> updateUserData(String name, String email) async {
    return await Users.document(uid).setData({
      'name': name,
      'email': email,
    });
  }

}