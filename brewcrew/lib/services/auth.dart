import 'package:brewcrew/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:brewcrew/models/user.dart';

class AuthService {
  //underscore before variable name means that it is private
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user object based on User
  UserCustom? _userFromFirebaseUser(User? user) {
    return user != null ? UserCustom(uid: user.uid) : null;
  }

  //Auth change user stream
  //everytime user signs in or signs out, we get a response down the stream
  Stream<UserCustom?> get user {
    return _auth
        .authStateChanges()
        //.map((User? user) => _userFromFirebaseUser(user));
        .map(_userFromFirebaseUser); //same functionality
  }

  //sign in anonymously
  Future signInAnonymously() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user; //FireBaseUser
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign in with email and password
  Future signInWithEmailandPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //register with email and password
  Future registerWithEmailandPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;

      //create a new doc for the user with uid
      await DatabaseService(uid: user!.uid)
          .updateUserData('0', 'New Crew Member', 100);
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
