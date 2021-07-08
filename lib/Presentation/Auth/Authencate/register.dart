import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:goandgo/Presentation/Auth/services/auth.dart';
import 'package:goandgo/components/primary_button.dart';

class RegisterState extends StatefulWidget {
  @override
  Register createState() => Register();
}

class Register extends State<RegisterState> {
  final AuthService _auth = AuthService();
  String? email;
  String? password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Spacer(
              flex: 2,
            ),
            TextFormField(
              decoration: InputDecoration(
                  icon: Icon(Icons.email),
                  hintText: 'Email',
                  border: InputBorder.none),
              onChanged: (value) {
                email = value;
              },
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              obscureText: true,
              decoration: InputDecoration(
                  fillColor: Colors.black26,
                  icon: Icon(Icons.lock),
                  hintText: 'Password',
                  border: InputBorder.none),
              onChanged: (value) {
                password = value;
              },
            ),
            Spacer(
              flex: 1,
            ),
            PrimaryButton(
                text: 'Login',
                press: () {
                  _auth.loginWithEmail(email, password);
                }),
            Spacer(
              flex: 2,
            ),
          ],
        ),
      ),
    );
  }
}
