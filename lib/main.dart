import 'package:flutter/material.dart';
import 'package:goandgo/Presentation/Auth/services/auth.dart';
import 'package:goandgo/Presentation/Home/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:goandgo/models/user.dart' as us;
import 'package:provider/provider.dart';
import 'Presentation/Auth/services/auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyAppp());
}

class MyAppp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Wrapper(),
    );
  }
}
