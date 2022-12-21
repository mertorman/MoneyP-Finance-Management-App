import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moneyp/feature/home/controller/auth_controller.dart';
import 'package:moneyp/feature/home/controller/home_controller.dart';
import 'package:moneyp/services/firestoredb.dart';

import '../model/wallet_model.dart';

class WalletController extends GetxController with StateMixin {
  RxList<Map<dynamic, dynamic>> selectedWallets =
      RxList<Map<dynamic, dynamic>>();
  RxList<Map<dynamic, dynamic>> selectedUpdateWallets =
      RxList<Map<dynamic, dynamic>>();

  @override
  void onInit() {
    super.onInit();
    change(null, status: RxStatus.success());
  }

  RxList<WalletModel> walletList = RxList<WalletModel>([
    WalletModel(
        budget: '0',
        expenseTotal: '0',
        incomesTotal: '0',
        walletSymbol: '₺',
        enabled: false,
        icon: 'assets/images/moneyicons/lira_onboard.png',
        walletType: 'Lira Wallet',
        walletTypeName: 'lira',
        walletColor: Colors.red),
    WalletModel(
        budget: '0',
        expenseTotal: '0',
        incomesTotal: '0',
        walletSymbol: '\$',
        enabled: false,
        icon: 'assets/images/moneyicons/dollar_onboard.png',
        walletType: 'Dollar Wallet',
        walletTypeName: 'dollar',
        walletColor: Colors.green),
    WalletModel(
        budget: '0',
        expenseTotal: '0',
        incomesTotal: '0',
        walletSymbol: '€',
        enabled: false,
        icon: 'assets/images/moneyicons/euro_onboard.png',
        walletType: 'Euro Wallet',
        walletTypeName: 'euro',
        walletColor: Colors.orange)
  ]);

  List<WalletModel> get wallets => walletList.value;

  List<Map<dynamic, dynamic>> selectedWallet(
      List<TextEditingController> controllers) {
    int i = 0;
    for (var element in wallets) {
          selectedWallets.value.add({
          'walletType': element.walletType!,
          'enabled': element.enabled!,
          'budget': controllers[i].text,
          'expenseTotal': element.expenseTotal!,
          'incomesTotal': element.incomesTotal!,
          'walletSymbol': element.walletSymbol!,
          'walletTypeName': element.walletTypeName!
        });
     
      i++;
    }
    return selectedWallets.value;
  }

  List<Map<dynamic, dynamic>> updateWalletsTextField(
      List<TextEditingController> controllers) {
    int i = 0;

    for (var element in wallets) {
      selectedUpdateWallets.value.add({
        'enabled': element.enabled!,
        'budget': controllers[i].text,
        'walletType': element.walletType!,
      });

      i++;
    }
    return selectedUpdateWallets.value;
  }

  addWallets(String uid, List<Map<dynamic, dynamic>> walletDetails) {
    FireStoreDb().createWallet(uid, walletDetails);
  }

  walletUpdate(
      String uid, List<Map<dynamic, dynamic>> walletUpdateDetails) async {
    HomeController homeController = Get.find();
      homeController.currentWalletIndex.value =
                             0;
    await FireStoreDb().walletUpdate(uid, walletUpdateDetails);
  }
}
