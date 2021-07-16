import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:goandgo/Presentation/Home/Map/map.dart';
import 'package:goandgo/Presentation/Home/SearchAdress/search_adress.dart';
import 'package:goandgo/Presentation/My_App/app_controller.dart';
import 'package:goandgo/Shared/constants.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart' as geo;

class HomeController extends GetxController {
  final controllerApp = Get.find<AppController>();
  bool? serviceEnabled;
  geo.LocationPermission? permission;
  StreamSubscription<geo.Position>? _positionStreamSubscription;

  GoogleMapController? controllerMap;
  RxList<Marker> customMarkers = RxList.empty();
  Circle? circle;
  ui.Image? image;
  RxInt? indexTabBottom = 0.obs;

  RxList<Widget> myWidget = [Map(), SearchAdress()].obs;

  @override
  void onInit() async {
    await currentLocation();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  CameraPosition initialLocation = CameraPosition(
    target: LatLng(10.85446819267671, 106.62622449789902),
    zoom: 12.0,
  );

  Future currentLocation() async {
    try {
      final locationCurrent = await geo.Geolocator.getCurrentPosition();
      final Uint8List markerIcon = await getBytesFromCanvas(
          (Get.height * 0.15).toInt(), (Get.height * 0.15).toInt());
      await updateMarkerAndCircle(locationCurrent, markerIcon);

      _positionStreamSubscription =
          geo.Geolocator.getPositionStream().listen((geo.Position position) {
        if (controllerMap != null) {
          controllerMap!.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(position.latitude, position.longitude),
              zoom: 16.0,
            ),
          ));
          updateMarkerAndCircle(position, markerIcon);
        }
      });
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        debugPrint('"Permission Denied');
      }
    }
  }

  Future updateMarkerAndCircle(
      geo.Position newLocalData, Uint8List imageData) async {
    LatLng latLng = LatLng(newLocalData.latitude, newLocalData.longitude);
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

  void changeIndexTabBottom(int index) {
    switch (index) {
      case 0:
        indexTabBottom!.value = 0;
        break;
      case 1:
        indexTabBottom!.value = 1;
        break;
      case 2:
        indexTabBottom!.value = 2;
        break;

      case 3:
        indexTabBottom!.value = 3;
        break;
      default:
        indexTabBottom!.value = 0;
    }
  }
}

class LocationData {}
