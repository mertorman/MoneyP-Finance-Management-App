import 'package:get/get.dart';
import 'package:moneyp/feature/stats_page/controller/stats_controller.dart';

class StatsPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => StatsController());
  }
}
