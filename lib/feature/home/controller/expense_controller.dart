import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moneyp/feature/home/controller/auth_controller.dart';
import 'package:moneyp/feature/home/controller/home_controller.dart';
import 'package:moneyp/feature/home/model/expense_model.dart';
import '../../../services/firestoredb.dart';

class ExpenseController extends GetxController
    with GetSingleTickerProviderStateMixin {
  AuthController authController = Get.find();
  Rx<ExpenseModel?> selectedExpense = Rx<ExpenseModel?>(null);

  Rx<List> secilenWidget = Rx<List>([]);

  HomeController homeController = Get.find();

  late TabController tabController;

  final List<Tab> tabs = <Tab>[
    Tab(
      child: Text(
        'Expense Add',
        style: GoogleFonts.poppins(fontSize: 14.8, fontWeight: FontWeight.w400),
      ),
    ),
    Tab(
      text: 'Income Add',
    ),
  ];

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
  }

  @override

  void onClose() {

    tabController.dispose();

    super.onClose();

  }

  addExpense(String title, String desc, String total) async {
    await FireStoreDb().addExpense(
        authController.firebaseUser.value!.uid,
        secilenWidget.value[0],
        title,
        desc,
        total,
        secilenWidget.value[1],
        secilenWidget.value[2],
        homeController
            .wallets[homeController.currentWalletIndex.value].walletType!);
  }

  expenseSec(int index) {
    secilenWidget.value.clear();
    secilenWidget.value.add(
      ExpenseModel.expenseItems.value[index].expenseType,
    );
    secilenWidget.value.add(
      ExpenseModel.expenseItems.value[index].imagePath2,
    );
    secilenWidget.value.add(
      ExpenseModel.expenseItems.value[index].color.toString(),
    );
  }
}
