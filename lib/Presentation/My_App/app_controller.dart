import 'dart:convert';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:location/location.dart' as loc;

class AppController extends GetxController {
  Map<String, dynamic>? userData;
  AccessToken? accessToken;
  RxBool checking = true.obs;
  loc.Location locationR = loc.Location();
  RxString? temp = ''.obs;

  @override
  void onInit() {
    permission();
    checkIfIsLogged();
    // boolLocationDevice();
    super.onInit();
  }

  String prettyPrint(Map json) {
    JsonEncoder encoder = new JsonEncoder.withIndent('  ');
    String pretty = encoder.convert(json);
    return pretty;
  }

  isLogin() {
    if (checking.value) {
      Get.toNamed('/home');
    }
  }

  Future<void> logOut() async {
    await FacebookAuth.instance.logOut();
    accessToken = null;
    userData = null;
    Get.toNamed('/auth');
  }

  // Future boolLocationDevice() async {
  //   if (!await locationR.serviceEnabled()) {
  //     locationR.requestService();
  //   }
  // }

  Future<void> checkIfIsLogged() async {
    var accessToken = await FacebookAuth.instance.accessToken;
    checking.value = false;
    if (accessToken != null) {
      print("is Logged:::: ${prettyPrint(accessToken.toJson())}");
      var userData = await FacebookAuth.instance.getUserData();
      print('dataaaa: $userData');
      accessToken = accessToken;
      userData = userData;
      Get.toNamed('/home');
    }
  }

  Future permission() async {
    if (await Permission.contacts.request().isGranted) {}
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
    ].request();
    print('permission location:  ${statuses[Permission.location]}');
  }
}
