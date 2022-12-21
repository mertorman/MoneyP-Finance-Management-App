import 'package:get/get.dart';
import 'package:moneyp/feature/home/controller/auth_controller.dart';

import '../feature/wallet_onboard/controller/wallet_controller.dart';

class LoginPageBinding extends Bindings {
  @override
  void dependencies() {
  Get.put(AuthController(), permanent: true);
 }
}
