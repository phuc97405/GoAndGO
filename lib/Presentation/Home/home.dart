import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goandgo/Presentation/Home/home_controller.dart';
import 'package:goandgo/Presentation/My_App/app_controller.dart';
import 'package:goandgo/Presentation/constants.dart';

class HomePage extends GetView<HomeController> {
  Widget build(BuildContext context) {
    final controllerApp = Get.find<AppController>();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Home'),
        actions: [IconButton(icon: Icon(Icons.search), onPressed: () {})],
      ),
      body:
          //  Expanded(
          //   child:
          new TextButton(
        onPressed: () {
          controllerApp.logOut();
        },
        child: new Text('Logout'),
      ),
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: kPrimaryColor,
        child: Icon(Icons.location_searching),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: controller.selectionIndex.value,
        onTap: (value) => {controller.selectionIndex = value.obs},
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: "People"),
          BottomNavigationBarItem(icon: Icon(Icons.call), label: "Call"),
          BottomNavigationBarItem(
              icon: CircleAvatar(
                backgroundImage: AssetImage('assets/images/user.jpg'),
                radius: 14,
              ),
              label: 'Profile')
        ],
      ),
    );
  }
}
