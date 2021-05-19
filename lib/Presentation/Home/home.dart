import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goandgo/Presentation/Home/home_controller.dart';
import 'package:goandgo/Presentation/constants.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage extends GetView<HomeController> {
  Completer<GoogleMapController> controllerGoogle = Completer();

  Widget build(BuildContext context) {
    // final controllerApp = Get.find<AppController>();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Home'),
        actions: [IconButton(icon: Icon(Icons.search), onPressed: () {})],
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: controller.kGooglePlex,
        trafficEnabled: true,
        onMapCreated: (GoogleMapController controller) {
          controllerGoogle.complete(controller);
        },
        myLocationEnabled: true,
        zoomControlsEnabled: false,
      ),
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: kPrimaryColor,
        child: Icon(Icons.location_searching),
      ),

      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }

  BottomNavigationBar buildBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: controller.selectionIndex,
      onTap: (value) => {controller.selectionIndex = value},
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "Home",
        ),
        BottomNavigationBarItem(icon: Icon(Icons.people), label: "People"),
        BottomNavigationBarItem(icon: Icon(Icons.call), label: "Call"),
        BottomNavigationBarItem(
            icon: CircleAvatar(
              backgroundImage: AssetImage('assets/images/user.jpg'),
              radius: 14,
            ),
            label: 'Profile')
      ],
    );
  }
}
