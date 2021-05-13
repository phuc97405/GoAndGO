import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goandgo/Presentation/Home/home_controller.dart';
import 'package:goandgo/Presentation/My_App/app_controller.dart';

class HomePage extends GetView<HomeController> {
  Widget build(BuildContext context) {
    final controllerApp = Get.find<AppController>();
    return Scaffold(
      body: Center(
        child: new TextButton(
          onPressed: () {
            controllerApp.logOut();
          },
          child: new Text('Logout'),
        ),
      ),
    );
  }
}
