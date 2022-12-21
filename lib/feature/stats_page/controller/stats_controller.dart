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


//------------Incomes,Expenses Toplam
  RxDouble incomeStatsToplam = RxDouble(0);
  RxDouble grafikToplam = RxDouble(0);

  RxDouble maxYStatusExpenses = RxDouble(60);
  RxDouble maxYStatusIncomes = RxDouble(60);
  late TabController tabController;

  //-------------Category Total--------------
  RxDouble travelToplam = RxDouble(0);
  RxDouble foodToplam = RxDouble(0);
  RxDouble shoppingToplam = RxDouble(0);
  RxDouble billingToplam = RxDouble(0);
  RxDouble otherToplam = RxDouble(0);

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
    travelToplam.value = 0;
    foodToplam.value = 0;
    shoppingToplam.value = 0;
    billingToplam.value = 0;
    otherToplam.value = 0;
    for (var element in stats.value) {
      if (element.expenseType ==
          ExpenseModel.expenseItems.value[0].expenseType) {
        travelToplam.value =
            travelToplam.value + double.parse(element.expenseTotal!);
      } else if (element.expenseType ==
          ExpenseModel.expenseItems.value[1].expenseType) {
        foodToplam.value =
            foodToplam.value + double.parse(element.expenseTotal!);
      } else if (element.expenseType ==
          ExpenseModel.expenseItems.value[2].expenseType) {
        shoppingToplam.value =
            shoppingToplam.value + double.parse(element.expenseTotal!);
      } else if (element.expenseType ==
          ExpenseModel.expenseItems.value[3].expenseType) {
        billingToplam.value =
            billingToplam.value + double.parse(element.expenseTotal!);
      } else {
        otherToplam.value =
            otherToplam.value + double.parse(element.expenseTotal!);
      }
    }
    grafikToplam.value = grafikToplam.value +
        travelToplam.value +
        foodToplam.value +
        shoppingToplam.value +
        billingToplam.value +
        otherToplam.value;

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
