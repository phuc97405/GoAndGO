import 'package:flutter/material.dart';
import 'package:goandgo/Presentation/Auth/Authencate/sign_in.dart';

class Authenticate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SignIn(),
      ),
    );
  }
}
