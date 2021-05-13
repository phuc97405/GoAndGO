import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goandgo/Presentation/Login/login_controller.dart';
import 'package:goandgo/Presentation/My_App/app_controller.dart';

class LoginPage extends GetView<LoginController> {
  Widget build(BuildContext context) {
    final controllerApp = Get.find<AppController>();
    return Scaffold(
        body: Container(
      color: Colors.black38,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text(
              controllerApp.userData != null
                  ? controllerApp.prettyPrint(controllerApp.userData)
                  : "NO LOGGED",
              style: TextStyle(color: Colors.black),
            ),
            Image.asset(
              'assets/icons/logo.jpeg',
              width: Get.width / 2,
              height: Get.width / 2,
            ),

            new TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),
              onPressed: () {
                controller.login();
              },
              child: new Text(
                'Login with Facebook',
                style: TextStyle(fontSize: 20),
              ),
            ),
            // new TextButton(
            //   onPressed: () {
            //     // controller.logOut();
            //   },
            //   child: new Text('Logout'),
            // ),
          ],
        ),
      ),
    ));
  }
}
