import 'package:get/get.dart';
import 'package:moneyp/feature/wallet_onboard/controller/wallet_controller.dart';

class WalletOnboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(WalletController());
  }
}
