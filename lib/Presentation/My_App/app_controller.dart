import 'dart:convert';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';

class AppController extends GetxController {
  final controllerApp = Get.find<AppController>();
  Map<String, dynamic> userData;
  AccessToken accessToken;
  bool checking = true;
  @override
  void onInit() {
    // checkIfIsLogged();
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
  }

  Future<void> checkIfIsLogged() async {
    var accessToken = await FacebookAuth.instance.accessToken;
    checking = false;
    if (accessToken != null) {
      print("is Logged:::: ${controllerApp.prettyPrint(accessToken.toJson())}");
      var userData = await FacebookAuth.instance.getUserData();
      print('dataaaa: $userData');
      print(userData['name']);
      accessToken = accessToken;
      userData = userData;
      // Get.toNamed('/home');
    }
  }
}
