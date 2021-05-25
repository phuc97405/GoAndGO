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
          leading: Icon(Icons.menu_open),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: kDefaultPadding),
              child: CircleAvatar(
                backgroundColor: kContentColorDarkTheme,
                child: CircleAvatar(
                    radius: 18,
                    backgroundImage: AssetImage('assets/images/user.jpg')),
                radius: 20,
              ),
            ),
          ],
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Stack(children: [
            GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: controller.initialLocation,
                trafficEnabled: true,
                onMapCreated: (GoogleMapController controllergg) {
                  controller.controllerMap = controllergg;
                },
                // myLocationEnabled: true,
                myLocationButtonEnabled: false,
                zoomControlsEnabled: false,
                markers: Set.of(
                    (controller.marker != null) ? [controller.marker!] : []),
                circles: Set.of(
                    (controller.circle != null) ? [controller.circle!] : []),
                onTap: (value) => {
                      // FocusScope.of(context).requestFocus(FocusNode()),
                      // controller.addMarkers(value)
                    }),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    'Hi PhucLee',
                                    style: TextStyle(
                                        color: kContentColorDarkTheme),
                                  ),
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
                                  left: kDefaultPadding,
                                  right: kDefaultPadding),
                              height: 50,
                              child: TextField(
                                autofocus: false,
                                textAlign: TextAlign.left,
                                onTap: () {
                                  controller.focusChange();
                                },
                                decoration: InputDecoration(
                                    labelStyle: TextStyle(
                                      color: kContentColorLightTheme,
                                    ),
                                    filled: true,
                                    fillColor: kContentColorDarkTheme,
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(35)),
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
                    ]))),
            Positioned(
              left: 0,
              bottom: 0,
              child: Container(
                width: Get.width,
                height: height * 0.07,
                child: Stack(
                  children: [
                    CustomPaint(
                      size: Size(width, height * 0.07),
                      painter: CustomBottom(),
                    ),
                    Center(
                      heightFactor: 0.7,
                      child: FloatingActionButton(
                          onPressed: () {
                            // controllerApp.boolLocationDevice();
                            controller.currentLocation();
                          },
                          backgroundColor: kContentColorDarkTheme,
                          child: Icon(
                            Icons.location_searching,
                            color: kErrorColor,
                            size: height * 0.04,
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
                                color: kContentColorDarkTheme,
                                size: kDefaultPadding,
                              )),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.people,
                                color: kContentColorDarkTheme,
                                size: kDefaultPadding,
                              )),
                          SizedBox(
                            width: width * 0.04,
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.call,
                                color: kContentColorDarkTheme,
                                size: kDefaultPadding,
                              )),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.account_box,
                                color: kContentColorDarkTheme,
                                size: kDefaultPadding,
                              ))
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ]),
        ));
  }
}
