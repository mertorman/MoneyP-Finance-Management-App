import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moneyp/feature/home/controller/auth_controller.dart';
import 'package:moneyp/feature/home/controller/home_controller.dart';
import 'package:moneyp/feature/home/model/incomes_model.dart';
import 'package:moneyp/feature/home/model/list_item_model.dart';
import 'package:moneyp/services/firestoredb.dart';

import '../../home/model/expense_model.dart';

class StatsController extends GetxController
    with StateMixin, GetSingleTickerProviderStateMixin {
  AuthController authController = Get.find();
  HomeController homeController = Get.find();
  RxList<ListItemModel> stats = RxList([]);
  RxList<IncomesModel> statsIncomes = RxList([]);
  RxDouble incomesAmountPercent = RxDouble(0);
  RxDouble expensesAmountPercent = RxDouble(0);
  RxList statsYuzde = RxList([]);

  RxDouble incomeStatsToplam = RxDouble(0);

  RxDouble grafikToplam = RxDouble(0);
  RxDouble maxYStatusExpenses = RxDouble(60);
  RxDouble maxYStatusIncomes = RxDouble(60);
  late TabController tabController;

  @override
  void onInit() async {
    tabController = TabController(length: 2, vsync: this, initialIndex: 0);
    super.onInit();
    change(null, status: RxStatus.loading());
    stats.value = await FireStoreDb()
        .statsGetExpenses(
            authController.firebaseUser.value!.uid,
            homeController
                .wallets[homeController.currentWalletIndex.value].walletType!)
        .then((value) => value);
    statsIncomes.value = await FireStoreDb()
        .statsGetIncomes(
            authController.firebaseUser.value!.uid,
            homeController
                .wallets[homeController.currentWalletIndex.value].walletType!)
        .then((value) => value);
    await Future.delayed(Duration(milliseconds: 200));
    change(null, status: RxStatus.success());
  }

  statsYuzdeHesaplama() {
    statsYuzde.value.clear();
    grafikToplam.value = 0;
    double travelToplam = 0;
    double foodToplam = 0;
    double shoppingToplam = 0;
    double billingToplam = 0;
    double otherToplam = 0;
    for (var element in stats.value) {
      if (element.expenseType ==
          ExpenseModel.expenseItems.value[0].expenseType) {
        travelToplam = travelToplam + double.parse(element.expenseTotal!);
      } else if (element.expenseType ==
          ExpenseModel.expenseItems.value[1].expenseType) {
        foodToplam = foodToplam + double.parse(element.expenseTotal!);
      } else if (element.expenseType ==
          ExpenseModel.expenseItems.value[2].expenseType) {
        shoppingToplam = shoppingToplam + double.parse(element.expenseTotal!);
      } else if (element.expenseType ==
          ExpenseModel.expenseItems.value[3].expenseType) {
        billingToplam = billingToplam + double.parse(element.expenseTotal!);
      } else {
        otherToplam = otherToplam + double.parse(element.expenseTotal!);
      }
    }
    grafikToplam.value = grafikToplam.value +
        travelToplam +
        foodToplam +
        shoppingToplam +
        billingToplam +
        otherToplam;

    statsYuzde.value.insert(0, (travelToplam * 100) / grafikToplam.value);
    statsYuzde.value.insert(1, (foodToplam * 100) / grafikToplam.value);

    statsYuzde.value.insert(2, (shoppingToplam * 100) / grafikToplam.value);
    statsYuzde.value.insert(3, (billingToplam * 100) / grafikToplam.value);
    statsYuzde.value.insert(4, (otherToplam * 100) / grafikToplam.value);

    statsYuzde.forEach((element) {
      if (element > 50) {
        maxYStatusExpenses.value = 120;
      }
    });
  }

  statsIncomeYuzdeHesaplama() {
    incomeStatsToplam.value = 0;
    for (var element in statsIncomes.value) {
      incomeStatsToplam.value =
          incomeStatsToplam.value + double.parse(element.incomesAmount!);
    }
    double incomesAndExpensesToplam =
        grafikToplam.value + incomeStatsToplam.value;
    incomesAmountPercent.value =
        (incomeStatsToplam.value * 100) / incomesAndExpensesToplam;
    expensesAmountPercent.value =
        (grafikToplam.value * 100) / incomesAndExpensesToplam;
    if (incomesAmountPercent.value > 50 || expensesAmountPercent.value > 50) {
      maxYStatusIncomes.value = 120;
    }
  }
}
