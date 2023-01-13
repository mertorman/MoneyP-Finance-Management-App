import 'package:get/get.dart';
import 'package:moneyp/feature/home/model/expense_model.dart';
import 'package:moneyp/feature/home/model/incomes_model.dart';
import 'package:moneyp/feature/home/model/list_item_model.dart';

import 'package:moneyp/feature/wallet_onboard/model/wallet_model.dart';
import 'package:moneyp/services/dovizkurlari_service.dart';
import 'package:moneyp/services/firestoredb.dart';
import 'package:moneyp/feature/home/controller/auth_controller.dart';
import 'package:moneyp/feature/home/model/user_model.dart';
import 'package:moneyp/services/model/dovizkurlari_model.dart';

class HomeController extends GetxController with StateMixin {
  //User details Rx
  Rx<HomeModel> homeModel = HomeModel().obs;
  HomeModel get homeModelValue => homeModel.value;
  set user(HomeModel value) => homeModel.value = value;

  //Pie Chart Rx

  Rx<List> expenseListYuzdeOran = Rx<List>([]);

  //Expenses list Rx
  RxList<ListItemModel> expenseList = RxList<ListItemModel>([]);
  List<ListItemModel> get expenses => expenseList.value;

  //Incomes list Rx
  RxList<IncomesModel> incomesList = RxList<IncomesModel>([]);
  List<IncomesModel> get incomes => incomesList.value;

  //Home change listview builder RxBool
  RxBool isExpensesOnTap = RxBool(true);

  RxList<WalletModel> walletList = RxList<WalletModel>([]);
  List<WalletModel> get wallets => walletList.value;

  RxInt currentWalletIndex = RxInt(0);
  RxInt currentWalletLastIndex = RxInt(0);

  RxList<int> walletsLength = RxList<int>([]);

  RxList<DovizKurlariModel> dovizKurlari = RxList<DovizKurlariModel>([]);

  RxString eurToUsd = RxString("");
  RxString usdToEur = RxString("");
  RxString eurToTl = RxString("");
  RxString usdToTl = RxString("");

  AuthController controller = Get.find<AuthController>();

  @override
  void onInit() async {
    super.onInit();

    change(null, status: RxStatus.loading());

    walletList.bindStream(FireStoreDb().walletStream(
      controller.firebaseUser.value!.uid,
    ));

    await Future.delayed(Duration(milliseconds: 500));
    ever(walletList, walletLengthCalculate);
  }

  @override
  void onReady() async {
    super.onReady();
    await getDovizKurlari();
    await getUserData();

    await listBindStream();
    change(null, status: RxStatus.success());
  }

  @override
  void onClose() {
    walletList.close();
    expenseList.close();
    incomesList.close();
  }

  listBindStream() {
    expenseList.clear();

    expenseList.bindStream(FireStoreDb().expenseStream(
        controller.firebaseUser.value!.uid,
        wallets[currentWalletIndex.value]
            .walletType!)); //Harcama listesini veritabanından anlık olarak izlemek için.

    incomesList.bindStream(FireStoreDb().incomesStream(
        controller.firebaseUser.value!.uid,
        wallets[currentWalletIndex.value].walletType!));
  }

  getUserData() async {
    user = await FireStoreDb().getUser(controller.firebaseUser.value!.uid);
    walletLengthCalculate(walletList);
  }

  getDovizKurlari() async {
    dovizKurlari.value = await DovizKurlariService().dovizKurGet();
    eurToUsd.value = (double.parse(dovizKurlari.value[0].eurKur) /
            double.parse(dovizKurlari.value[0].usdKur))
        .toStringAsFixed(2);
    usdToEur.value = (double.parse(dovizKurlari.value[0].usdKur) / double.parse(dovizKurlari.value[0].eurKur)).toStringAsFixed(2);
    eurToTl.value =
        (1 / double.parse(dovizKurlari.value[0].eurKur)).toStringAsFixed(3);
    usdToTl.value =
        (1 / double.parse(dovizKurlari.value[0].usdKur)).toStringAsFixed(3);
  }

  grafikYuzdeHesaplama() {
    expenseListYuzdeOran.value.clear();
    double grafikToplam = 0;
    double travelToplam = 0;
    double foodToplam = 0;
    double shoppingToplam = 0;
    double billingToplam = 0;
    double otherToplam = 0;
    for (var element in expenseList.value) {
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
    grafikToplam = grafikToplam +
        travelToplam +
        foodToplam +
        shoppingToplam +
        billingToplam +
        otherToplam;

    expenseListYuzdeOran.value.insert(0, (travelToplam * 100) / grafikToplam);
    expenseListYuzdeOran.value.insert(1, (foodToplam * 100) / grafikToplam);

    expenseListYuzdeOran.value.insert(2, (shoppingToplam * 100) / grafikToplam);
    expenseListYuzdeOran.value.insert(3, (billingToplam * 100) / grafikToplam);
    expenseListYuzdeOran.value.insert(4, (otherToplam * 100) / grafikToplam);
  }

  walletLengthCalculate(List<WalletModel> wallets) {
    walletsLength.clear();
    int i = 0;
    wallets.forEach((element) {
      walletsLength.add(i);
      i++;
    });
  }

  walletUpdateOnTransaction(
      String budget, String amount, String transactionType) async {
    await FireStoreDb().addTransactionWalletUpdate(
        controller.firebaseUser.value!.uid,
        wallets[currentWalletIndex.value].walletType!,
        budget,
        amount,
        transactionType);
  }

  transactionDelete(String transactionType, String transactionUid) async {
    await FireStoreDb().transactionDelete(
        controller.firebaseUser.value!.uid,
        wallets[currentWalletIndex.value].walletType!,
        transactionType,
        transactionUid);
  }
}
