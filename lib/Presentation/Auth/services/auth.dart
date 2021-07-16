import 'package:firebase_auth/firebase_auth.dart';
import 'package:goandgo/Presentation/Auth/services/database.dart';
import 'package:goandgo/models/user.dart' as us;

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

// crate user obj based on firabaseUser
  us.User? _userFromFirebaseUser(User? user) {
    print('userstream$user');
    return user != null ? us.User(uid: user.uid) : null;
  }

//auth change user stream

  Stream<us.User?> get user {
    return _auth.userChanges().map(_userFromFirebaseUser);
  }

  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      return result;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('Khong ton tai tai khaon email nay');
      } else if (e.code == 'wrong-password') {
        print('Sai password');
      }
      return null;
    }
  }

  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;
      print('uid +${user!.uid}');
      await DatabaseService(uid: user.uid)
          .updateUserData('0', 'new crew member', 100);

      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('Password qua yeu.');
      } else if (e.code == 'email-already-in-use') {
        print('Tai khoan da to tai.');
      }
      return null;
    }
  }
}
