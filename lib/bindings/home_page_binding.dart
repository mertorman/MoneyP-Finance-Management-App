import 'package:get/get.dart';
import 'package:moneyp/feature/home/controller/expense_controller.dart';

import 'package:moneyp/feature/home/controller/home_controller.dart';

class HomePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController(), fenix: true);
    Get.lazyPut(() => ExpenseController());
  }
}
