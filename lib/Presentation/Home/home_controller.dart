import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:goandgo/Api/get_weather_api.dart';
import 'package:goandgo/Presentation/Home/home.dart';
import 'package:goandgo/Presentation/My_App/app_controller.dart';
import 'package:goandgo/components/constants.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class HomeController extends GetxController {
  final controllerApp = Get.find<AppController>();
  StreamSubscription? locationSubscription;
  Location locationTracker = Location();
  GoogleMapController? controllerMap;
  int selectionTabIndex = 0;
  RxList<Marker> customMarkers = RxList.empty();
  Circle? circle;
  ui.Image? image;
  Widget? widget = HomePage();
  List<Widget> myWidget = [
    // Map(controller),
  ];
  String? latitude;
  String? longitude;

  @override
  void onInit() async {
    await currentLocation();
    await callApiWeather();
    super.onInit();
  }

  Future callApiWeather() async {
    await getWeatherApi(latitude!, longitude!)
        .then((value) => controllerApp.temp!.value = value.toString());
    print(controllerApp.temp!.value);
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
    zoom: 12.0,
  );

  Future currentLocation() async {
    try {
      // loadImage('assets/images/user.jpg');
      if (controllerApp.temp!.value == '') {
        callApiWeather();
      }
      final locationCurrent = await locationTracker.getLocation();
      final Uint8List markerIcon = await getBytesFromCanvas(
          (height * 0.15).toInt(), (height * 0.15).toInt());
      await updateMarkerAndCircle(locationCurrent, markerIcon);
      if (locationSubscription != null) {
        locationSubscription!.cancel();
      }
      locationSubscription =
          locationTracker.onLocationChanged.listen((newLocalData) {
        if (controllerMap != null) {
          controllerMap!.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(newLocalData.latitude!, newLocalData.longitude!),
              zoom: 16.0,
            ),
          ));
          updateMarkerAndCircle(newLocalData, markerIcon);
        }
      });
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        debugPrint('"Permission Denied');
      }
    }
  }

  Future updateMarkerAndCircle(
      LocationData newLocalData, Uint8List imageData) async {
    LatLng latLng = LatLng(newLocalData.latitude!, newLocalData.longitude!);
    latitude = newLocalData.latitude.toString();
    longitude = newLocalData.longitude.toString();
    var itemMarker = Marker(
      markerId: MarkerId('myLocation'),
      position: latLng,
      rotation: 0,
      draggable: false,
      zIndex: 2,
      flat: false,
      anchor: Offset(0.5, 0.5), //toa do marker lay
      icon: BitmapDescriptor.fromBytes(imageData),
    );
    customMarkers.add(itemMarker);
  }

  focusChange() {
    Get.toNamed('/searchadress');
  }

  Future<Uint8List> getBytesFromCanvas(int width, int height) async {
    final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);
    Radius radius = Radius.circular(20);

    final Paint paint = Paint()..color = kPrimaryColor;
    canvas.drawRRect(
        RRect.fromRectAndCorners(
          Rect.fromLTWH(0.0, 0.0, width.toDouble(), height.toDouble()),
          topLeft: radius,
          topRight: radius,
          bottomLeft: radius,
          bottomRight: radius,
        ),
        paint);
    TextPainter painter = TextPainter(textDirection: TextDirection.ltr);
    painter.text = TextSpan(
      text: controllerApp.nameStatus.toString(),
      style: TextStyle(
          fontSize: 30.0, color: Colors.white, fontWeight: FontWeight.bold),
    );
    painter.layout();
    painter.paint(
        canvas,
        Offset((width * 0.5) - painter.width * 0.5,
            (height * 0.5) - painter.height * 0.5));
    final img = await pictureRecorder.endRecording().toImage(width, height);
    final data = await img.toByteData(format: ui.ImageByteFormat.png);
    return data!.buffer.asUint8List();
  }

  // void loadImage(String path) async {
  //   var data = await rootBundle.load(path);
  //   var bytes = data.buffer.asUint8List();
  //   var image = await decodeImageFromList(bytes);
  //   this.image = image;
  // }

  void changeIndexTabBottom(int index) {
    switch (index) {
      case 0:
        break;
        widget = HomePage();
      case 1:
        break;
      case 2:
        break;
      case 3:
        break;
      default:
    }
  }
}
