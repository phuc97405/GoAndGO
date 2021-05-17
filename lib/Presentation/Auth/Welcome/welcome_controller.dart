import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/state_manager.dart';
import 'package:get/get.dart';
import 'package:goandgo/Presentation/My_App/app_controller.dart';

class WelcomeController extends GetxController {
  final controllerApp = Get.find<AppController>();
  @override
  void onInit() {
    isLogin();
    super.onInit();
  }

  isLogin() {
    if (controllerApp.checking.value) {
      Get.toNamed('/home');
    }
  }
}
