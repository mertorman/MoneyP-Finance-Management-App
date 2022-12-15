import 'package:get/get.dart';
import 'package:moneyp/feature/wallet_onboard/controller/wallet_controller.dart';

class WalletHomepageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WalletController());
  }
}
