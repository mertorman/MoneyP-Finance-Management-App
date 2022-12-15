import 'package:get/get.dart';
import 'package:moneyp/feature/home/model/expense_model.dart';
import 'package:moneyp/feature/home/model/incomes_model.dart';
import 'package:moneyp/feature/home/model/list_item_model.dart';
import 'package:moneyp/feature/wallet_onboard/model/wallet_model.dart';
import 'package:moneyp/services/firestoredb.dart';
import 'package:moneyp/feature/home/controller/auth_controller.dart';
import 'package:moneyp/feature/home/model/user_model.dart';

class HomeController extends GetxController with StateMixin {
  //User details Rx
  Rx<HomeModel> homeModel = HomeModel().obs;
  HomeModel get homeModelValue => homeModel.value;
  set user(HomeModel value) => homeModel.value = value;

  //Pie Chart Rx
  Rx<int> grafikToplam = Rx<int>(0);
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

  AuthController controller = Get.find<AuthController>();

  @override
  void onInit() async {
    super.onInit();
    change(null, status: RxStatus.loading());
    expenseList = RxList<ListItemModel>([]);
    walletList.bindStream(
        FireStoreDb().walletStream(controller.firebaseUser.value!.uid));
    await Future.delayed(const Duration(seconds: 1));

    expenseList = RxList<ListItemModel>([]);
    expenseList.bindStream(FireStoreDb().expenseStream(
        controller.firebaseUser.value!.uid,
        wallets[currentWalletIndex.value]
            .walletType!)); //Harcama listesini veritabanından anlık olarak izlemek için.

    incomesList.bindStream(
        FireStoreDb().incomesStream(controller.firebaseUser.value!.uid));

    getUserData();
    ever(walletList, walletLengthCalculate);
  }

  getUserData() async {
    user = await FireStoreDb().getUser(controller.firebaseUser.value!.uid);
    do {
      if (expenseList.value.isNotEmpty) {
        grafikYuzdeHesaplama();
        walletLengthCalculate(walletList);
        change(null, status: RxStatus.success());
      }
    } while (expenseList.value.isEmpty);
  }

  grafikYuzdeHesaplama() {
    expenseListYuzdeOran.value.clear();
    grafikToplam.value = 0;
    int travelToplam = 0;
    int foodToplam = 0;
    int shoppingToplam = 0;
    int billingToplam = 0;
    int otherToplam = 0;
    for (var element in expenseList.value) {
      if (element.expenseType == ExpenseModel.expenseItems.value[0].expenseType) {
        travelToplam = travelToplam + int.parse(element.expenseTotal!);
      } else if (element.expenseType ==
          ExpenseModel.expenseItems.value[1].expenseType) {
        foodToplam = foodToplam + int.parse(element.expenseTotal!);
      } else if (element.expenseType ==
          ExpenseModel.expenseItems.value[2].expenseType) {
        shoppingToplam = shoppingToplam + int.parse(element.expenseTotal!);
      } else if (element.expenseType ==
          ExpenseModel.expenseItems.value[3].expenseType) {
        billingToplam = billingToplam + int.parse(element.expenseTotal!);
      } else {
        otherToplam = otherToplam + int.parse(element.expenseTotal!);
      }
    }
    grafikToplam.value = grafikToplam.value +
        travelToplam +
        foodToplam +
        shoppingToplam +
        billingToplam +
        otherToplam;

    expenseListYuzdeOran.value
        .insert(0, (travelToplam * 100) / grafikToplam.value);
    expenseListYuzdeOran.value
        .insert(1, (foodToplam * 100) / grafikToplam.value);

    expenseListYuzdeOran.value
        .insert(2, (shoppingToplam * 100) / grafikToplam.value);
    expenseListYuzdeOran.value
        .insert(3, (billingToplam * 100) / grafikToplam.value);
    expenseListYuzdeOran.value
        .insert(4, (otherToplam * 100) / grafikToplam.value);
  }

  walletLengthCalculate(List<WalletModel> wallets) {
    walletsLength.clear();
    int i = 0;
    wallets.forEach((element) {
      walletsLength.add(i);
      i++;
    });
  }
}
