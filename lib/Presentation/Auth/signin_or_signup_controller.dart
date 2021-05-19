import 'package:get/get.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:goandgo/Presentation/My_App/app_controller.dart';

class SignInOrSigUpController extends GetxController {
  final controllerApp = Get.find<AppController>();

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> loginWithFb() async {
    final LoginResult result = await FacebookAuth.instance.login();
    if (result.status == LoginStatus.success) {
      controllerApp.accessToken = result.accessToken;
      printCredentials();

      var userData = await FacebookAuth.instance.getUserData();
      userData = userData;
      Get.toNamed('/home');
    } else {
      print('status' + result.status.toString());
      print('messager' + result.message!);
    }

    // controllerApp.checking.value = false;
  }

  void printCredentials() {
    print(
      'credential' +
          controllerApp.prettyPrint(controllerApp.accessToken!.toJson()),
    );
  }
}
