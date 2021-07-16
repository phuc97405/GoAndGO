import 'package:flutter/material.dart';
import 'package:goandgo/Presentation/Auth/services/auth.dart';
import 'package:goandgo/Presentation/Auth/services/database.dart';
import 'package:goandgo/Presentation/Home/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:goandgo/models/user.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyAppp());
}

class MyAppp extends StatelessWidget {
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User?>.value(
        value: AuthService().user,
        initialData: User(uid: ''),
        child: MaterialApp(
          home: Wrapper(),
        ));
  }
}
