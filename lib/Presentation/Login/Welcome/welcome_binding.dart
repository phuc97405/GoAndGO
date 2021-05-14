import 'package:get/get_instance/get_instance.dart';
import 'package:get/state_manager.dart';
import 'package:goandgo/Presentation/Login/Welcome/welcome_controller.dart';

class WelcomeBingding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WelcomeController>(() => WelcomeController());
  }
}
