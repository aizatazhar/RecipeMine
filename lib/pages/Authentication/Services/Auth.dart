import 'package:recipemine/Custom/Models/User.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:recipemine/pages/Home/FireBase/Database.dart';
class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj based on firebase user
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged
    //.map((FirebaseUser user) => _userFromFirebaseUser(user));
        .map(_userFromFirebaseUser);
  }

  // sign in anon
  Future signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      String emailformatted = email.trim();
      AuthResult result = await _auth.signInWithEmailAndPassword(email: emailformatted, password: password);
      FirebaseUser user = result.user;
      return user;
    } catch (error) {
      switch (error.code) {
        case 'ERROR_WRONG_PASSWORD' : return 'Invalid Password';
        case 'ERROR_INVALID_EMAIL' : return 'Invalid Email';
        case 'ERROR_USER_NOT_FOUND' : return 'User not found';
        case 'ERROR_USER_DISABLED' : return 'User Disabled';
        case 'ERROR_TOO_MANY_REQUESTS' : return 'Server is handling many requests, please wait';
        case 'ERROR_OPERATION_NOT_ALLOWED' : return 'Operation not allowed';
      }
    }
  }


  // register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      String emailformatted = email.trim();
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: emailformatted, password: password);
      FirebaseUser user = result.user;
      // create a new document for the user with the uid
    List<String> Pantry = new List<String>();
      DatabaseService(uid: user.uid).updateUserData('New User', email, user.uid, 'https://moonvillageassociation.org/wp-content/uploads/2018/06/default-profile-picture1.jpg',Pantry);
      return _userFromFirebaseUser(user);
    } catch (error) {
      switch (error.code) {
        case 'ERROR_WEAK_PASSWORD' : return 'Weak Password';
        case 'ERROR_INVALID_EMAIL' : return 'Invalid Email';
        case 'ERROR_EMAIL_ALREADY_IN_USE' : return 'Email Used';
      }
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future getCurrentUser() async {
    return await _auth.currentUser();
  }

}