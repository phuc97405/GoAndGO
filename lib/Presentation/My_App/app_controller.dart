import 'dart:convert';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class AppController extends GetxController {
  Map<String, dynamic>? userData;
  AccessToken? accessToken;
  RxBool checking = true.obs;
  @override
  void onInit() {
    permission();
    checkIfIsLogged();

    super.onInit();
  }

  String prettyPrint(Map json) {
    JsonEncoder encoder = new JsonEncoder.withIndent('  ');
    String pretty = encoder.convert(json);
    return pretty;
  }

  Future<void> logOut() async {
    await FacebookAuth.instance.logOut();
    accessToken = null;
    userData = null;
    Get.toNamed('/auth');
  }

  Future<void> checkIfIsLogged() async {
    var accessToken = await FacebookAuth.instance.accessToken;
    checking.value = false;
    if (accessToken != null) {
      print("is Logged:::: ${prettyPrint(accessToken.toJson())}");
      var userData = await FacebookAuth.instance.getUserData();
      print('dataaaa: $userData');
      accessToken = accessToken;
      userData = userData;
    }
  }

  permission() async {
    if (await Permission.contacts.request().isGranted) {}

    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
      Permission.locationWhenInUse,
    ].request();
    print(statuses[Permission.location]);
  }
}
