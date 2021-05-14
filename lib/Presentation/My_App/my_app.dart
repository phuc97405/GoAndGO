import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:goandgo/Presentation/Home/home.dart';
import 'package:goandgo/Presentation/Home/home_binding.dart';
import 'package:goandgo/Presentation/Login/Welcome/welcome.dart';
import 'package:goandgo/Presentation/Login/Welcome/welcome_binding.dart';
import 'package:goandgo/Presentation/Login/login_binding.dart';
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
        initialRoute: '/',
        getPages: [
          GetPage(name: '/', page: () => Welcome(), binding: WelcomeBingding()),
          GetPage(
              name: '/home', page: () => HomePage(), binding: HomeBinding()),
        ]);
  }
}
