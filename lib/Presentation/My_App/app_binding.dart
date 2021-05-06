import 'package:get/get.dart';
import 'package:goandgo/Presentation/My_App/app_controller.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AppController>(() => AppController(), fenix: true);
  }
}
