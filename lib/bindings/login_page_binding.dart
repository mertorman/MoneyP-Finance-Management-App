import 'package:get/get.dart';
import 'package:moneyp/feature/home/controller/auth_controller.dart';

class LoginPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController(), permanent: true);
  }
}
