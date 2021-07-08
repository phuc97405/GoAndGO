import 'package:flutter/material.dart';
import 'package:goandgo/Presentation/Auth/services/auth.dart';

class SignIn extends StatelessWidget {
  final AuthService _auth = AuthService();
  String? email;
  String? password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown,
      appBar: AppBar(
        backgroundColor: Colors.brown[200],
        elevation: 0.0,
        title: Text('Sign In'),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
            child: TextButton(
              child: Text('Sign In Anon'),
              onPressed: () async {
                dynamic result = await _auth.signInAnon();
                if (result == null) {
                  print('sign in Error');
                } else {
                  print('sign in $result');
                }
              },
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
            child: TextButton(
              child: Text('Sign out'),
              onPressed: () async {
                await _auth.signOut();
              },
            ),
          ),
          TextFormField(
            onChanged: (value) {
              email = value;
            },
          ),
          TextFormField(
            obscureText: true,
            onChanged: (value) {
              password = value;
            },
          ),
          TextButton(
              onPressed: () {
                print(email! + password!);
              },
              style: ButtonStyle(),
              child: Text('Login'))
        ],
      )),
    );
  }
}
