import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:goandgo/Presentation/Auth/Authencate/authenticate.dart';
import 'package:goandgo/Presentation/Home/firebase/homefire.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final user = Provider.of<User>(context);
    FirebaseAuth.instance.userChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
        // return Authenticate();
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Authenticate()));
      } else {
        // return HomeFire();
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeFire()));
        print('User is signed in!'); //to Home
        print(user);
      }
    });
    return Authenticate();
  }
}
