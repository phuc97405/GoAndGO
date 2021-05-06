import 'package:get/get.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:goandgo/Presentation/My_App/app_controller.dart';

class LoginController extends GetxController {
  final controllerApp = Get.find<AppController>();

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> login() async {
    final LoginResult result = await FacebookAuth.instance.login();

    if (result.status == LoginStatus.success) {
      controllerApp.accessToken = result.accessToken;
      printCredentials();

      var userData = await FacebookAuth.instance.getUserData();
      userData = userData;
    } else {
      print(result.status);
      print(result.message);
    }

    controllerApp.checking = false;
  }

  void printCredentials() {
    print(
      controllerApp.prettyPrint(controllerApp.accessToken.toJson()),
    );
  }
}
