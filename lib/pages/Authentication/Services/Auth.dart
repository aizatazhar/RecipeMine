import 'package:recipemine/Custom/Models/User.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:recipemine/pages/Home/FireBase/Database.dart';

/// Class that deals with authentication.
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Creates a user object based on Firebase user.
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  /// Auth change user stream.
  Stream<User> get user {
    return _auth.onAuthStateChanged
        .map(_userFromFirebaseUser);
//        .map((FirebaseUser user) => _userFromFirebaseUser(user));
  }

  /// Signs in anonymously.
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

  /// Signs in with email and password.
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      String emailFormatted = email.trim();
      AuthResult result = await _auth.signInWithEmailAndPassword(email: emailFormatted, password: password);
      FirebaseUser user = result.user;
      return user;
    } catch (error) {
      switch (error.code) {
        case 'ERROR_WRONG_PASSWORD' : return 'Invalid password';
        case 'ERROR_INVALID_EMAIL' : return 'Invalid email';
        case 'ERROR_USER_NOT_FOUND' : return 'User not found';
        case 'ERROR_USER_DISABLED' : return 'User disabled';
        case 'ERROR_TOO_MANY_REQUESTS' : return 'Server is handling too many requests, please wait';
        case 'ERROR_OPERATION_NOT_ALLOWED' : return 'Operation not allowed';
      }
    }
  }

  /// Registers with email and password.
  Future registerWithEmailAndPassword(String email, String username, String password) async {
    try {
      String emailFormatted = email.trim();
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: emailFormatted, password: password);
      FirebaseUser user = result.user;
      // create a new document for the user with the uid
      List<dynamic> pantry = new List<dynamic>();
      List<dynamic> favourites = [];

      DatabaseService(uid: user.uid).updateUserData(
          username,
          email,
          user.uid,
          'https://moonvillageassociation.org/wp-content/uploads/2018/06/default-profile-picture1.jpg',
          pantry,
          favourites);

      return _userFromFirebaseUser(user);

    } catch (error) {
      switch (error.code) {
        case "ERROR_WEAK_PASSWORD" : return "Password too weak";
        case "ERROR_INVALID_EMAIL" : return "Invalid email";
        case "ERROR_EMAIL_ALREADY_IN_USE" : return "Email already in use";
      }
    }
  }

  /// Signs out.
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  /// Gets the current user.
  Future getCurrentUser() async {
    return await _auth.currentUser();
  }
}
