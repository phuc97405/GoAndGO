import 'package:get/get.dart';
import 'package:goandgo/Presentation/My_App/app_controller.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeController extends GetxController {
  final controllerApp = Get.find<AppController>();
  int selectionIndex = 0;

  @override
  void onClose() {
    super.onClose();
  }

  CameraPosition kGooglePlex = CameraPosition(
    target: LatLng(10.85446819267671, 106.62622449789902),
    zoom: 14.4746,
  );

  // CameraPosition kLake = CameraPosition(
  //     bearing: 192.8334901395799,
  //     target: LatLng(37.43296265331129, -122.08832357078792),
  //     tilt: 59.440717697143555,
  //     zoom: 19.151926040649414);

  @override
  void onInit() {
    super.onInit();
  }
}
