import 'package:get/get.dart';
import 'package:goandgo/Presentation/Home/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
  }
}
