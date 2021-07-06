import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // User _userFromFirebaseUser(FirebaseAuth user) {
  //   return user != null ? User(uid: user.uid) : null;
  // }
//auth changee user stream
  // Stream<User> get user {
  //   return _auth.onAuthStateChanged.map(_userFromFirebaseUsr);
  // }

  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();

      print(result);
      return result;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
