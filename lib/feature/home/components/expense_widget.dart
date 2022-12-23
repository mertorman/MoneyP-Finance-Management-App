import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moneyp/feature/home/components/expense_add_widget.dart';
import 'package:moneyp/feature/home/controller/expense_controller.dart';
import 'package:moneyp/feature/home/view/homepage_view.dart';

import '../model/expense_model.dart';

class ExpenseWidget extends StatelessWidget {
  ExpenseWidget(
      {super.key,
      required this.controller,
      required this.expenseTotal,
      required this.title,
      required this.expenseDesc});
  ExpenseController controller;
  TextEditingController expenseTotal;
  TextEditingController title;
  TextEditingController expenseDesc;

  List<String> items = ['EUR', 'USD', 'TL'];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 20),
          child: Container(
              height: controller.tabController.index == 0
                  ? MediaQuery.of(context).size.height * 0.1
                  : MediaQuery.of(context).size.height * 0.17,
              child: controller.tabController.index == 0
                  ? ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: ExpenseModel.expenseItems.length,
                      itemBuilder: (context, index) {
                        return Obx(
                          () => GestureDetector(
                            onTap: () {
                              controller.expenseSec(index);

                              if (controller.selectedExpense.value != null) {
                                controller.selectedExpense.value!.isSelected =
                                    false;
                              }
                              ExpenseModel.expenseItems[index].isSelected =
                                  !ExpenseModel.expenseItems[index].isSelected!;

                              controller.selectedExpense.value =
                                  ExpenseModel.expenseItems[index];

                              ExpenseModel.expenseItems.refresh();
                            },
                            child: category_widget(
                              isSelected:
                                  ExpenseModel.expenseItems[index].isSelected!,
                              title:
                                  ExpenseModel.expenseItems[index].expenseType!,
                              imageUrl:
                                  ExpenseModel.expenseItems[index].imagePath!,
                              containerColor: Color(int.parse(
                                  ExpenseModel.expenseItems[index].color!)),
                            ),
                          ),
                        );
                      })
                  : Image(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.17,
                      image: Svg("assets/images/income_money.svg"))),
        ),
        const SizedBox(
          height: 8,
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.07,
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 245, 245, 245),
              borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 10, right: 18, top: 10, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(() => Icon(
                      controller.selectedItemDropDown!.value == 'EUR'
                          ? FontAwesome5.euro_sign
                          : controller.selectedItemDropDown!.value == 'USD'
                              ? FontAwesome5.dollar_sign
                              : FontAwesome5.lira_sign,
                      color: Colors.grey,
                      size: 21.5,
                    )),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.always,
                    inputFormatters: <TextInputFormatter>[
                      LengthLimitingTextInputFormatter(9),
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    validator: (value) {
                      if ((value != "" &&
                          homeController
                                  .wallets[
                                      homeController.currentWalletIndex.value]
                                  .walletSymbol! ==
                              '€')) {
                        double deger = double.parse(value.toString());
                        if (controller.selectedItemDropDown!.value == 'EUR') {
                          controller.transactionAmount.value = value!;
                          return null;
                        } else if (controller.selectedItemDropDown!.value ==
                            'USD') {
                          controller.transactionAmount.value = (deger *
                                  double.parse(homeController.usdToEur.value))
                              .toStringAsFixed(2);
                        
                          return '1\$ = ${homeController.usdToEur.value}€ => ${controller.transactionAmount.value}€';
                        } else if (controller.selectedItemDropDown!.value ==
                            'TL') {
                          controller.transactionAmount.value = (deger *
                                  double.parse(homeController.eurToTl.value))
                              .toStringAsFixed(2);
                          return '1₺ = ${homeController.eurToTl.value}€ => ${controller.transactionAmount.value}€';
                        }
                      }
                      if ((value != "" &&
                          homeController
                                  .wallets[
                                      homeController.currentWalletIndex.value]
                                  .walletSymbol! ==
                              '\$')) {
                        double deger = double.parse(value.toString());
                        if (controller.selectedItemDropDown!.value == 'USD') {
                          controller.transactionAmount.value = value!;
                          return null;
                        } else if (controller.selectedItemDropDown!.value ==
                            'EUR') {
                          controller.transactionAmount.value = (deger *
                                  double.parse(homeController.eurToUsd.value))
                              .toStringAsFixed(2);
                          return '1€ = ${homeController.eurToUsd.value}\$ => ${controller.transactionAmount.value}\$';
                        } else if (controller.selectedItemDropDown!.value ==
                            'TL') {
                          controller.transactionAmount.value = (deger *
                                  double.parse(homeController.usdToTl.value))
                              .toStringAsFixed(2);
                          return '1₺ = ${homeController.usdToTl.value}\$ => ${controller.transactionAmount.value}\$';
                        }
                      }
                      if ((value != "" &&
                          homeController
                                  .wallets[
                                      homeController.currentWalletIndex.value]
                                  .walletSymbol! ==
                              '₺')) {
                        double deger = double.parse(value.toString());
                        if (controller.selectedItemDropDown!.value == 'TL') {
                          controller.transactionAmount.value = value!;
                          return null;
                        } else if (controller.selectedItemDropDown!.value ==
                            'USD') {
                          controller.transactionAmount.value = (deger *
                                  double.parse(homeController
                                      .dovizKurlari.value[0].usdKur))
                              .toStringAsFixed(2);
                          return '1\$ = ${(double.parse(homeController.dovizKurlari.value[0].usdKur).toStringAsFixed(2))}₺ => ${controller.transactionAmount.value}₺';
                        } else if (controller.selectedItemDropDown!.value ==
                            'EUR') {
                          controller.transactionAmount.value = (deger *
                                  double.parse(homeController
                                      .dovizKurlari.value[0].eurKur))
                              .toStringAsFixed(2);
                          return '1€ = ${(double.parse(homeController.dovizKurlari.value[0].eurKur).toStringAsFixed(2))}₺ => ${controller.transactionAmount.value}₺';
                        }
                      }
                    },
                    controller: expenseTotal,
                    keyboardType: TextInputType.number,
                    style: GoogleFonts.poppins(),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(
                          top: 5, bottom: 5, left: 10, right: 10),
                      errorMaxLines: 2,
                      errorStyle:
                          GoogleFonts.poppins(color: Colors.blue, fontSize: 13),
                      hintText: controller.tabController.index == 0
                          ? "Enter expense amount"
                          : "Enter income amount",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const VerticalDivider(color: Colors.blue),
                Obx(
                  () => DropdownButton(
                    value: controller.selectedItemDropDown!.value,
                    iconDisabledColor: Colors.blue,
                    items: items
                        .map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(item,
                                style: TextStyle(
                                  color: Colors.blue,
                                ))))
                        .toList(),
                    onChanged: (value) {
                      controller.selectedItemDropDown!.value = value.toString();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.07,
          decoration: BoxDecoration(
              color: Color.fromARGB(228, 245, 245, 245),
              borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 10, right: 18, top: 10, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(Icons.title, color: Colors.grey),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: TextField(
                  controller: title,
                  style: GoogleFonts.poppins(),
                  decoration: InputDecoration.collapsed(
                    hintText: controller.tabController.index == 0
                        ? "Enter expense title"
                        : "Enter income title",
                    border: InputBorder.none,
                  ),
                )),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.13,
          decoration: BoxDecoration(
              color: Color.fromARGB(228, 245, 245, 245),
              borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: EdgeInsets.only(right: 15, left: 15, top: 10, bottom: 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextField(
                  controller: expenseDesc,
                  maxLines: 4,
                  keyboardType: TextInputType.multiline,
                  style: GoogleFonts.poppins(),
                  decoration: InputDecoration.collapsed(
                    hintText: controller.tabController.index == 0
                        ? "Enter expense description"
                        : "Enter income description",
                    border: InputBorder.none,
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
