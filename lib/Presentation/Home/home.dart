import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goandgo/Presentation/Home/Map/map.dart';
import 'package:goandgo/Presentation/Home/home_controller.dart';
import 'package:goandgo/Presentation/My_App/app_controller.dart';
import 'package:goandgo/components/constants.dart';
import 'package:goandgo/components/custom_bottom.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

double width = MediaQueryData.fromWindow(window).size.width;
double height = MediaQueryData.fromWindow(window).size.height;

class HomePage extends GetView<HomeController> {
  Widget build(BuildContext context) {
    final controllerApp = Get.find<AppController>();
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: Icon(Icons.menu_open),
          title: Obx(() => controllerApp.temp!.value != 0
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.cloud_queue_sharp),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      controllerApp.temp.toString() + ' °C',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                )
              : Center(
                  child: SizedBox(
                  height: 25,
                  width: 25,
                  child: Icon(Icons.cloud_off_outlined),
                ))),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: kDefaultPadding),
              child: CircleAvatar(
                backgroundColor: kContentColorDarkTheme,
                child: CircleAvatar(
                    radius: 18,
                    backgroundImage: NetworkImage(controllerApp.imageUrl!.value)
                    // : AssetImage('assets/images/user.jpg')
                    ),
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
            // Map(),
            controller.myWidget[controller.indexTabBottom!.value],
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
                              onPressed: () {
                                controller.changeIndexTabBottom(0);
                              },
                              icon: Icon(
                                Icons.home,
                                color: kContentColorDarkTheme,
                                size: kDefaultPadding,
                              )),
                          IconButton(
                              onPressed: () {
                                controller.changeIndexTabBottom(1);
                              },
                              icon: Icon(
                                Icons.people,
                                color: kContentColorDarkTheme,
                                size: kDefaultPadding,
                              )),
                          SizedBox(
                            width: width * 0.04,
                          ),
                          IconButton(
                              onPressed: () {
                                controller.changeIndexTabBottom(2);
                              },
                              icon: Icon(
                                Icons.call,
                                color: kContentColorDarkTheme,
                                size: kDefaultPadding,
                              )),
                          IconButton(
                              onPressed: () {
                                controller.changeIndexTabBottom(3);
                              },
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
