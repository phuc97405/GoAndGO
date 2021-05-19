import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:goandgo/Presentation/Auth/Welcome/welcome.dart';
import 'package:goandgo/Presentation/Auth/Welcome/welcome_binding.dart';
import 'package:goandgo/Presentation/Auth/signin_or_signup.dart';
import 'package:goandgo/Presentation/Auth/signin_or_signup_binding.dart';
import 'package:goandgo/Presentation/Home/home.dart';
import 'package:goandgo/Presentation/Home/home_binding.dart';
import 'package:goandgo/Presentation/My_App/app_binding.dart';
import 'package:goandgo/Presentation/theme.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightThemeData(context),
        darkTheme: darkThemeData(context),
        initialBinding: AppBinding(),
        initialRoute: '/home',
        getPages: [
          GetPage(name: '/', page: () => Welcome(), binding: WelcomeBinding()),
          GetPage(
              name: '/auth',
              page: () => SignInAndSignUp(),
              binding: SignInOrSignUpBinding()),
          GetPage(
              name: '/home', page: () => HomePage(), binding: HomeBinding()),
        ]);
  }
}
