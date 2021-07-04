import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class AppController extends GetxController {
  Map<String, dynamic>? userData;
  AccessToken? accessToken;
  RxBool checking = true.obs;
  RxString? nameStatus = ''.obs;
  RxString? imageUrl = ''.obs;
  RxString? long = ''.obs;
  RxString? lat = ''.obs;
  RxInt? temp = 0.obs;

  @override
  void onInit() async {
    await permission();
    // checkIfIsLogged();
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

  Future<void> checkIfIsLogged() async {
    var accessToken = await FacebookAuth.instance.accessToken;
    checking.value = false;
    if (accessToken != null) {
      print("is Logged:::: ${prettyPrint(accessToken.toJson())}");
      var userData = await FacebookAuth.instance.getUserData();
      print('UserData : $userData');
      accessToken = accessToken;
      userData = userData;
      var array = userData['name'].toString().split(' ');
      nameStatus!.value = array[array.length - 1].trim();
      imageUrl!.value = userData['picture']['data']['url'].toString();
      print('urllll: $imageUrl');
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
