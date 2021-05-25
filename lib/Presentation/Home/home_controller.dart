import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:goandgo/Presentation/My_App/app_controller.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class HomeController extends GetxController {
  final controllerApp = Get.find<AppController>();
  StreamSubscription? locationSubscription;
  Location locationTracker = Location();
  GoogleMapController? controllerMap;
  int selectionTabIndex = 0;
  Marker? listmarkers;
  Marker? marker;
  Circle? circle;

  @override
  void onInit() {
    currentLocation();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void changeTabBottom(int index) {
    selectionTabIndex = index;
    update();
  }

  CameraPosition initialLocation = CameraPosition(
    target: LatLng(10.85446819267671, 106.62622449789902),
    zoom: 14.0,
  );

  void currentLocation() async {
    try {
      Uint8List imageData = await getMarker();
      var location = await locationTracker.getLocation();
      updateMarkerAndCircle(location, imageData);

      if (locationSubscription != null) {
        locationSubscription!.cancel();
      }
      locationSubscription =
          locationTracker.onLocationChanged.listen((newLocalData) {
        if (controllerMap != null) {
          controllerMap!.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(
              bearing: 192.8334901395799,
              target: LatLng(newLocalData.latitude!, newLocalData.longitude!),
              zoom: 18.0,
            ),
          ));
          updateMarkerAndCircle(newLocalData, imageData);
        }
      });
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        debugPrint('"Permission Denied');
      }
    }
  }

  Future<Uint8List> getMarker() async {
    // final Response response = await get("");
    // icon = await BitmapDescriptor.fromBytes(response.bodyBytes);

    ByteData byteData = await rootBundle.load('assets/icons/motoIcon.png');
    return byteData.buffer.asUint8List();
  }

  void updateMarkerAndCircle(LocationData newLocalData, Uint8List imageData) {
    LatLng latLng = LatLng(newLocalData.latitude!, newLocalData.longitude!);
    marker = Marker(
      markerId: MarkerId('home'),
      position: latLng,
      rotation: newLocalData.heading!,
      draggable: false,
      zIndex: 2,
      flat: true,
      anchor: Offset(0.5, 0.5),
      // infoWindow: InfoWindow(title: 'PhucLee'),
      icon: BitmapDescriptor.fromBytes(imageData),
    );

    circle = Circle(
        circleId: CircleId('moto'),
        radius: newLocalData.accuracy!,
        zIndex: 1,
        strokeColor: Colors.blue,
        center: latLng,
        fillColor: Colors.blue.withAlpha(70));
  }

  // Set<Marker> createMarker() {
  //   return {
  //     Marker(
  //         markerId: MarkerId("marker_1"),
  //         position: LatLng(10.85446819267671, 106.62622449789902),
  //         icon:
  //             BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
  //         infoWindow: InfoWindow(title: 'Marker 1'),
  //         rotation: 20),

  focusChange() {
    Get.toNamed('/searchadress');
  }
}
