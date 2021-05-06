import 'package:get/get.dart';
import 'package:goandgo/Presentation/Login/login_controller.dart';
import 'package:goandgo/Presentation/My_App/app_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());
  }
}
