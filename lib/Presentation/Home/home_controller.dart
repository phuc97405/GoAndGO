import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
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
  Marker? marker;
  Circle? circle;
  ui.Image? image;
  Widget? widget = HomePage();
  List<Widget> myWidget = [
    // Map(controller),
  ];

  @override
  void onInit() {
    loadImage('assets/images/user.jpg');
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
    zoom: 12.0,
  );

  Future currentLocation() async {
    try {
      var location = await locationTracker.getLocation();
      final Uint8List markerIcon = await getBytesFromCanvas(200, 200);
      await updateMarkerAndCircle(location, markerIcon);
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
    marker = Marker(
      markerId: MarkerId('myMarker'),
      position: latLng,
      rotation: 0,
      //  newLocalData.heading!,
      draggable: false,
      zIndex: 2,
      flat: false,
      anchor: Offset(0.5, 0.5), //toa do marker lay
      icon: BitmapDescriptor.fromBytes(imageData),
    );

    // circle = Circle(
    //     circleId: CircleId('myCircle'),
    //     radius: newLocalData.accuracy!,
    //     zIndex: 1,
    //     strokeColor: kPrimaryColor,
    //     center: latLng,
    //     fillColor: kPrimaryColor.withAlpha(70));
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
      text: 'PhucLee',
      style: TextStyle(
          fontSize: 35.0, color: Colors.white, fontWeight: FontWeight.bold),
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

  Future loadImage(String path) async {
    final data = await rootBundle.load(path);
    final bytes = data.buffer.asUint8List();
    final image = await decodeImageFromList(bytes);
    this.image = image;
    print(image);
  }

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
