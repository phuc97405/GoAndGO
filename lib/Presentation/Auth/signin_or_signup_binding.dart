import 'package:get/get.dart';
import 'package:goandgo/Presentation/Auth/signin_or_signup_controller.dart';
import 'package:goandgo/Presentation/My_App/app_controller.dart';

class SignInOrSignUpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignInOrSigUpController>(() => SignInOrSigUpController());
  }
}
