import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moneyp/feature/home/components/expense_widget.dart';
import 'package:moneyp/feature/home/controller/expense_controller.dart';
import 'package:moneyp/feature/home/model/expense_model.dart';
import 'package:moneyp/feature/home/view/homepage_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickalert/quickalert.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

class ExpenseBottomSheet extends StatefulWidget {
  ExpenseBottomSheet({super.key});

  @override
  State<ExpenseBottomSheet> createState() => _ExpenseBottomSheetState();
}

class _ExpenseBottomSheetState extends State<ExpenseBottomSheet> {
  ExpenseController controller = Get.find();

  TextEditingController expenseTitle = TextEditingController();

  TextEditingController expenseDesc = TextEditingController();

  TextEditingController expenseAmount = TextEditingController();

  TextEditingController incomeTitle = TextEditingController();

  TextEditingController incomeDesc = TextEditingController();

  TextEditingController incomeAmount = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 1.25,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(14), topRight: Radius.circular(14))),
      child: Padding(
        padding: const EdgeInsets.only(left: 15, top: 15, bottom: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 400,
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white.withOpacity(0.8)),
              child: TabBar(
                controller: controller.tabController,
                indicator: RectangularIndicator(
                  color: Colors.blue.shade300,
                  topLeftRadius: 15,
                  topRightRadius: 15,
                  bottomLeftRadius: 15,
                  bottomRightRadius: 15,
                ),
                indicatorColor: Colors.transparent,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.grey,
                tabs: controller.tabs,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Divider(),
            ),
            Expanded(
              child: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  controller: controller.tabController,
                  children: [
                    ExpenseWidget(
                        controller: controller,
                        expenseTotal: expenseAmount,
                        title: expenseTitle,
                        expenseDesc: expenseDesc),
                    ExpenseWidget(
                        controller: controller,
                        expenseTotal: incomeAmount,
                        title: incomeTitle,
                        expenseDesc: incomeDesc),
                  ]),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      if (controller.tabController.index == 0) {
                        expenseAmount.clear();
                        expenseTitle.clear();
                        expenseDesc.clear();
                        controller.selectedExpense.value!.isSelected = false;
                        ExpenseModel.expenseItems.refresh();
                      } else {
                        incomeAmount.clear();
                        incomeTitle.clear();
                        incomeDesc.clear();
                      }
                    },
                    child:
                        Text('Reset', style: GoogleFonts.poppins(fontSize: 18)),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.red,
                      side: const BorderSide(color: Colors.red),
                      minimumSize: Size(MediaQuery.of(context).size.width, 50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (expenseTitle.text.length > 1 &&
                          expenseDesc.text.length > 1 &&
                          double.parse(controller.transactionAmount.value) >
                              0 &&
                          controller.tabController.index == 0 &&
                          controller.selectedExpense.value != null) {
                        await controller.addExpense(
                            expenseTitle.text,
                            expenseDesc.text,
                            controller.transactionAmount.value);

                        String amount = (double.parse(homeController
                                    .wallets[
                                        homeController.currentWalletIndex.value]
                                    .expenseTotal!) +
                                double.parse(
                                    controller.transactionAmount.value))
                            .toStringAsFixed(2);
                        String budget = (double.parse(homeController
                                    .wallets[
                                        homeController.currentWalletIndex.value]
                                    .budget!) -
                                double.parse(
                                    controller.transactionAmount.value))
                            .toStringAsFixed(2);
                        await controller.walletUpdateOnTransaction(
                            budget, amount, 'expenseTotal');

                        Get.back();
                      } else if (incomeTitle.text.length > 1 &&
                          incomeDesc.text.length > 1 &&
                          double.parse(controller.transactionAmount.value) >
                              0 &&
                          controller.tabController.index == 1) {
                        await controller.addIncome(
                            incomeTitle.text,
                            incomeDesc.text,
                            controller.transactionAmount.value);

                        String amount = (double.parse(homeController
                                    .wallets[
                                        homeController.currentWalletIndex.value]
                                    .incomesTotal!) +
                                double.parse(
                                    controller.transactionAmount.value))
                            .toStringAsFixed(2);
                        String budget = (double.parse(homeController
                                    .wallets[
                                        homeController.currentWalletIndex.value]
                                    .budget!) +
                                double.parse(
                                    controller.transactionAmount.value))
                            .toStringAsFixed(2);
                        await controller.walletUpdateOnTransaction(
                            budget, amount, 'incomesTotal');
                        Get.back();
                      } else if ((controller.tabController.index == 0) &&
                          (controller.selectedExpense.value == null ||
                              expenseTitle.text.length < 1 ||
                              expenseDesc.text.length < 1 ||
                              double.parse(
                                      controller.transactionAmount.value) ==
                                  0 ||
                              controller.transactionAmount.value == null)) {
                        QuickAlert.show(
                            context: context,
                            type: QuickAlertType.warning,
                            text:
                                'Please be sure to select an expense category and enter a title, description and amount.');
                      } else if ((controller.tabController.index == 1) &&
                          (incomeTitle.text.length < 1 ||
                              incomeDesc.text.length < 1 ||
                              double.parse(
                                      controller.transactionAmount.value) ==
                                  0 ||
                              controller.transactionAmount.value == null)) {
                        QuickAlert.show(
                            context: context,
                            type: QuickAlertType.warning,
                            text:
                                'Please be sure to enter the amount, title and description of your income.');
                      }
                    },
                    child:
                        Text('Save', style: GoogleFonts.poppins(fontSize: 18)),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                        minimumSize:
                            Size(MediaQuery.of(context).size.width, 60),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class category_widget extends StatelessWidget {
  category_widget(
      {Key? key,
      required this.title,
      required this.imageUrl,
      required this.containerColor,
      required this.isSelected})
      : super(key: key);

  final String imageUrl;
  final String title;
  final Color containerColor;
  bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          width: isSelected
              ? MediaQuery.of(context).size.width * 0.20
              : MediaQuery.of(context).size.width * 0.18,
          height: isSelected
              ? MediaQuery.of(context).size.height * 0.15
              : MediaQuery.of(context).size.height * 0.095,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: containerColor.withOpacity(0.33),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                imageUrl,
                width: 25,
                height: 25,
              ),
              Text(
                title,
                style: TextStyle(
                    color: containerColor,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 30,
        )
      ],
    );
  }
}
