import 'package:get/get_instance/get_instance.dart';
import 'package:get/state_manager.dart';
import 'package:goandgo/Presentation/Auth/Welcome/welcome_controller.dart';

class WelcomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WelcomeController>(() => WelcomeController());
  }
}
