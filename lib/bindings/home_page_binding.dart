import 'package:get/get.dart';
import 'package:moneyp/feature/home/controller/expense_controller.dart';

import 'package:moneyp/feature/home/controller/home_controller.dart';

class HomePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
    Get.lazyPut(() => ExpenseController());
  }
}
