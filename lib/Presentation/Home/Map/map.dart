import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:goandgo/Presentation/My_App/app_controller.dart';
import 'package:goandgo/components/constants.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';

double width = MediaQueryData.fromWindow(window).size.width;
double height = MediaQueryData.fromWindow(window).size.height;

class Map extends StatefulWidget {
  final customMarkers;
  Map({Key? key, this.customMarkers});
  @override
  MapState createState() => MapState(customMarkers: this.customMarkers);
}

class MapState extends State<Map> {
  CameraPosition initialLocation = CameraPosition(
    target: LatLng(10.85446819267671, 106.62622449789902),
    zoom: 12.0,
  );
  final customMarkers;
  MapState({this.customMarkers});
  @override
  Widget build(Object context) {
    final controllerApp = Get.find<AppController>();
    return Stack(
      children: [
        Obx(() => GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: initialLocation,
            trafficEnabled: true,
            onMapCreated: (GoogleMapController controllergg) {
              // controller.controllerMap = controllergg;
            },
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            markers: customMarkers.toSet(),
            onTap: (value) => {
                  // FocusScope.of(context).requestFocus(FocusNode()),
                  // controller.addMarkers(value)
                })),
        Positioned(
            left: 0,
            top: 0,
            child: Container(
                height: height * 0.18,
                width: width,
                child: Stack(children: [
                  Container(
                      height: height * 0.18 - 25,
                      width: width,
                      decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(35),
                              bottomRight: Radius.circular(35))),
                      child: Padding(
                          padding: EdgeInsets.all(kDefaultPadding),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              RichText(
                                  text: TextSpan(children: [
                                TextSpan(
                                    text: 'Hi ',
                                    style:
                                        TextStyle(fontSize: kDefaultPadding)),
                                TextSpan(
                                    text: controllerApp.nameStatus.toString(),
                                    style: TextStyle(
                                        fontSize: kDefaultPadding,
                                        fontWeight: FontWeight.bold)),
                                TextSpan(
                                    text: ' !',
                                    style:
                                        TextStyle(fontSize: kDefaultPadding)),
                              ])),
                              Text(
                                'Bạn muốn đi đâu ?',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: kDefaultPadding,
                                    fontWeight: FontWeight.bold,
                                    color: kContentColorDarkTheme),
                              ),
                              SizedBox(
                                height: kDefaultPadding,
                              ),
                            ],
                          ))),
                  Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                          padding: EdgeInsets.only(
                              left: kDefaultPadding, right: kDefaultPadding),
                          height: 50,
                          child: TextField(
                            autofocus: false,
                            textAlign: TextAlign.left,
                            onTap: () {
                              Get.toNamed('/searchadress');
                            },
                            decoration: InputDecoration(
                                labelStyle: TextStyle(
                                  color: kContentColorLightTheme,
                                ),
                                filled: true,
                                fillColor: kContentColorDarkTheme,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(35)),
                                hintText: 'Search',
                                hintStyle: TextStyle(
                                    color: kContentColorLightTheme
                                        .withOpacity(0.3)),
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      // Get.toNamed('/searchadress');
                                    },
                                    icon: Icon(Icons.search,
                                        color: kContentColorLightTheme
                                            .withOpacity(0.3)))),
                          )))
                ])))
      ],
    );
  }
}
