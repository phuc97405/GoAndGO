import 'package:get/get_instance/get_instance.dart';
import 'package:get/state_manager.dart';
import 'package:goandgo/Presentation/Home/SearchAdress/search_adress_controller.dart';

class SearchAdressBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchAdressController>(() => SearchAdressController());
  }
}
