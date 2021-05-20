import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goandgo/Presentation/Home/home_controller.dart';
import 'package:goandgo/Presentation/My_App/app_controller.dart';
import 'package:goandgo/Presentation/constants.dart';
import 'package:goandgo/Presentation/custom_bottom.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

double width = MediaQueryData.fromWindow(window).size.width;
double height = MediaQueryData.fromWindow(window).size.height;

class HomePage extends GetView<HomeController> {
  Widget build(BuildContext context) {
    final controllerApp = Get.find<AppController>();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Home'),
        actions: [IconButton(icon: Icon(Icons.search), onPressed: () {})],
      ),
      body: Stack(children: [
        GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: controller.kGooglePlex,
          trafficEnabled: true,
          onMapCreated: (GoogleMapController controllergg) {
            controller.controllerGoogle.complete(controllergg);
          },
          myLocationEnabled: true,
          myLocationButtonEnabled: false,
          zoomControlsEnabled: false,
        ),
        Positioned(
          left: 0,
          bottom: 0,
          child: Container(
            // color: kPrimaryColor,
            width: Get.width,
            height: height * 0.1,
            child: Stack(
              children: [
                CustomPaint(
                  size: Size(width, height * 0.1),
                  painter: CustomBottom(),
                ),
                Center(
                  heightFactor: 0.6,
                  child: FloatingActionButton(
                      onPressed: () {
                        controllerApp.boolLocationDevice();
                        controller.currentLocation();
                      },
                      backgroundColor: kPrimaryColor,
                      child: Icon(
                        Icons.location_searching,
                        size: 40,
                      ),
                      elevation: 0.1),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.home,
                            size: 40,
                          )),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.people,
                            size: 40,
                          )),
                      SizedBox(
                        width: width * 0.02,
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.call,
                            size: 40,
                          )),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.call,
                            size: 40,
                          ))
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      ]),
      // ),

      // bottomNavigationBar: BottomNavigationBar(
      //   type: BottomNavigationBarType.fixed,
      //   // iconSize: 25,
      //   // selectedFontSize: 10,
      //   selectedItemColor: Colors.black,
      //   unselectedItemColor: Colors.black54,
      //   onTap: controller.changeTabBottom,
      //   currentIndex: controller.selectionTabIndex,
      //   items: [
      //     _bottomNavigationBarItem(icon: CupertinoIcons.home, label: "Home"),
      //     _bottomNavigationBarItem(
      //         icon: CupertinoIcons.person_crop_circle_badge_checkmark,
      //         label: "People"),
      //     _bottomNavigationBarItem(icon: CupertinoIcons.phone, label: "Call"),
      //     BottomNavigationBarItem(
      //         icon: CircleAvatar(
      //           backgroundImage: AssetImage('assets/images/user.jpg'),
      //           radius: 14,
      //         ),
      //         label: 'Profile')
      //   ],
      // )
    );
  }

  _bottomNavigationBarItem({IconData? icon, String? label}) {
    return BottomNavigationBarItem(icon: Icon(icon), label: label);
  }
}
