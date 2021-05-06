import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:goandgo/Presentation/Home/home.dart';
import 'package:goandgo/Presentation/Home/home_binding.dart';
import 'package:goandgo/Presentation/Login/login.dart';
import 'package:goandgo/Presentation/Login/login_binding.dart';
import 'package:goandgo/Presentation/My_App/app_binding.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // final controllerApp = Get.find<AppController>();
  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    return GetMaterialApp(
        theme: ThemeData(fontFamily: 'Roboto-Regular'),
        initialBinding: AppBinding(),
        initialRoute: '/',
        getPages: [
          GetPage(name: '/', page: () => LoginPage(), binding: LoginBinding()),
          GetPage(
              name: '/home', page: () => HomePage(), binding: HomeBinding()),
        ]);
  }
}
