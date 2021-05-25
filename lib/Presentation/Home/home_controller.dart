import 'dart:async';

import 'package:get/get.dart';
import 'package:goandgo/Presentation/My_App/app_controller.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class HomeController extends GetxController {
  final controllerApp = Get.find<AppController>();
  GoogleMapController? controllerGoogle;
  int selectionTabIndex = 0;
  Marker? listmarkers;

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
    LocationData currentLocation;
    var location = new Location();
    currentLocation = await location.getLocation();

    controllerGoogle!.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        bearing: 0,
        target: LatLng(currentLocation.latitude!, currentLocation.longitude!),
        zoom: 15.0,
      ),
    ));
  }

  Set<Marker> createMarker() {
    return {
      Marker(
          markerId: MarkerId("marker_1"),
          position: LatLng(10.85446819267671, 106.62622449789902),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          infoWindow: InfoWindow(title: 'Marker 1'),
          rotation: 20),
      Marker(
        markerId: MarkerId("marker_2"),
        position: LatLng(10.85446819267671, 106.64622449789902),
      ),
    };
  }

  addMarkers(LatLng pos) {
    listmarkers = Marker(
        markerId: MarkerId('myid'),
        infoWindow: InfoWindow(title: 'my infdo'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        position: pos);
  }

  focusChange() {
    Get.toNamed('/searchadress');
  }
}
