import 'package:get/get.dart';
import 'package:moneyp/feature/home/controller/auth_controller.dart';
import 'package:moneyp/feature/home/model/expense_model.dart';
import '../../../services/firestoredb.dart';

class ExpenseController extends GetxController {
  AuthController authController = Get.find();

  Rx<List> secilenWidget = Rx<List>([]);
  static RxBool onTap = false.obs;
  RxInt lastIndex = 0.obs;
  RxInt indexCount = 0.obs;
  RxInt onTapIndex = 0.obs;

  addExpense(String title, String desc, String total) async {
    await FireStoreDb().addExpense(
        authController.firebaseUser.value!.uid,
        secilenWidget.value[0],
        title,
        desc,
        total,
        secilenWidget.value[1],
        secilenWidget.value[2]);
  }

  expenseSec(int index) {
    // if (indexCount.value == 0) {
    //  lastIndex.value = index;
    // expenseItems.value[index][3] = 120.0;
    //expenseItems.value[index][3] = true;
    // } else {
    // expenseItems.value[lastIndex.value][3] = false;
    // expenseItems.value[index][3] = true;
    // expenseItems.value[lastIndex.value][3] = 90.0;
    // expenseItems.value[index][3] = 120.0;
    //    lastIndex.value = index;
    // }
    //  indexCount.value = indexCount.value + 1;
    secilenWidget.value.clear();
    secilenWidget.value.add(
      ExpenseModel.expenseItems[index][0],
    );
    secilenWidget.value.add(
      ExpenseModel.expenseItems[index][3],
    );
    secilenWidget.value.add(
      ExpenseModel.expenseItems[index][2].toString(),
    );
  }
}
