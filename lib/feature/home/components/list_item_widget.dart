import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:moneyp/feature/home/controller/home_controller.dart';
import 'package:moneyp/feature/home/model/incomes_model.dart';
import 'package:rounded_expansion_tile/rounded_expansion_tile.dart';
import '../../../product/constant/color_settings.dart';
import '../model/list_item_model.dart';

class ListItem extends StatelessWidget {
  ListItem(
      {Key? key,
      required this.listItemType,
      required this.listItemTitle,
      required this.listItemDescription,
      required this.listItemTotal,
      required this.listItemIcon,
      required this.listItemColor,
      required this.listItemId})
      : super(key: key);
  final String listItemType;
  final String listItemTitle;
  final String listItemDescription;
  final String listItemIcon;
  final String listItemTotal;
  final String listItemColor;
  final String listItemId;

  HomeController homeController = Get.find();

  Column info(String info, String value) {
    return Column(
      children: [
        Text(
          info,
          style: GoogleFonts.poppins(
              color: ColorSettings.themeColor.shade200,
              fontSize: 14,
              fontWeight: FontWeight.w400),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          value,
          style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  static Widget expenseGetItem(BuildContext ctx, ListItemModel itemModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: ListItem(
        listItemColor: itemModel.expenseColor!,
        listItemDescription: itemModel.expenseDescription!,
        listItemIcon: itemModel.expenseIcon!,
        listItemTitle: itemModel.expenseTitle!,
        listItemTotal: itemModel.expenseTotal!,
        listItemType: itemModel.expenseType!,
        listItemId: itemModel.uid!,
      ),
    );
  }

  static Widget incomesGetItem(BuildContext ctx, IncomesModel itemModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: ListItem(
          listItemId: itemModel.uid!,
          listItemColor: itemModel.incomesColor!,
          listItemDescription: itemModel.incomesDescription!,
          listItemIcon: itemModel.incomesIcon!,
          listItemTitle: itemModel.incomesTitle!,
          listItemTotal: itemModel.incomesAmount!,
          listItemType: itemModel.type!),
    );
  }

  static Widget getGroupSeparator(ListItemModel? expenseValue,
      IncomesModel? incomesValue, BuildContext context) {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('d');
    final String today = formatter.format(now);
    final String yesterday =
        formatter.format(DateTime.now().subtract(const Duration(days: 1)));
    late String groupText;
    if (expenseValue != null) {
      groupText =
          '${expenseValue.expenseDay}.${expenseValue.expenseMonth}.${expenseValue.expenseYear}';

      if (expenseValue.expenseDay.toString() == today) {
        groupText = 'Today';
      } else if (expenseValue.expenseDay.toString() == yesterday) {
        groupText = 'Yesterday';
      }
    } else if (incomesValue != null) {
      groupText =
          '${incomesValue.incomesDay}.${incomesValue.incomesMonth}.${incomesValue.incomesYear}';

      if (incomesValue.incomesDay.toString() == today) {
        groupText = 'Today';
      } else if (incomesValue.incomesDay.toString() == yesterday) {
        groupText = 'Yesterday';
      }
    }

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.054,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            groupText,
            style: GoogleFonts.poppins(
                color: Colors.grey.shade500,
                fontWeight: FontWeight.bold,
                fontSize: 14.6),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.only(top: 13),
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.8),
              borderRadius: BorderRadius.circular(16)),
          child: RoundedExpansionTile(
            trailing: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: Colors.blue.withAlpha(200)),
              child: Material(
                borderRadius: BorderRadius.circular(24),
                type: MaterialType.transparency,
                clipBehavior: Clip.hardEdge,
                child: const Icon(
                  Icons.arrow_downward_outlined,
                  color: Color(0xFFF7F7F7),
                ),
              ),
            ),
            title: Padding(
              padding: const EdgeInsets.only(top: 7),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 20),
                    child: Image.asset(
                      listItemIcon,
                      width: 55,
                      height: 55,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        '${homeController.wallets[homeController.currentWalletIndex.value].walletSymbol}${double.parse(listItemTotal).toStringAsFixed(2).split(".")[0]}',
                        style: const TextStyle(
                            color: Color(0xFF3b67b5),
                            fontSize: 28,
                            fontWeight: FontWeight.bold),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 12, left: 0),
                        child: Text(
                            '.${double.parse(listItemTotal).toStringAsFixed(2).split(".")[1]}', //Dinamik hale getirelecek.
                            style: TextStyle(
                                color: Color(0xFF3b67b5),
                                fontSize: 16,
                                fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            children: [
              Row(
                children: [
                  const Expanded(
                    child: Divider(
                      thickness: 1,
                    ),
                  ),
                  Text(
                    '${homeController.isExpensesOnTap.value ? 'Expense' : 'Income'} Details',
                    style: TextStyle(color: Colors.grey.shade500),
                  ),
                  const Expanded(
                    child: Divider(
                      thickness: 1,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    info('Title', listItemTitle),
                    Container(
                      width: 1,
                      height: 40,
                      color: Colors.grey,
                    ),
                    info('Description', listItemDescription),
                    Container(
                      width: 1,
                      height: 40,
                      color: Colors.grey,
                    ),
                    GestureDetector(
                        onTap: () async {
                          if (homeController.isExpensesOnTap.value) {
                            String amount = (double.parse(homeController
                                        .wallets[homeController
                                            .currentWalletIndex.value]
                                        .expenseTotal!) -
                                    double.parse(listItemTotal))
                                .toStringAsFixed(2);
                            String budget = (double.parse(homeController
                                        .wallets[homeController
                                            .currentWalletIndex.value]
                                        .budget!) +
                                    double.parse(listItemTotal))
                                .toStringAsFixed(2);
                            await homeController.walletUpdateOnTransaction(
                                budget, amount, 'expenseTotal');
                            await homeController.transactionDelete(
                                'expenses', listItemId);
                          } else {
                            String amount = (double.parse(homeController
                                        .wallets[homeController
                                            .currentWalletIndex.value]
                                        .incomesTotal!) -
                                    double.parse(listItemTotal))
                                .toStringAsFixed(2);
                            String budget = (double.parse(homeController
                                        .wallets[homeController
                                            .currentWalletIndex.value]
                                        .budget!) -
                                    double.parse(listItemTotal))
                                .toStringAsFixed(2);
                            await homeController.walletUpdateOnTransaction(
                                budget, amount, 'incomesTotal');
                            await homeController.transactionDelete(
                                'incomes', listItemId);
                          }
                        },
                        child: LottieBuilder.asset(
                          'assets/delete_icon.json',
                          width: 45,
                          height: 45,
                        ))
                  ],
                ),
              )
            ],
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.275,
          height: MediaQuery.of(context).size.height * 0.0255,
          alignment: Alignment.center,
          margin: const EdgeInsets.only(left: 16),
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 24),
          decoration: BoxDecoration(
            color: Color(int.parse(listItemColor)).withOpacity(0.65),
            borderRadius: BorderRadius.circular(36),
          ),
          child: Text(
            listItemType,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500, fontSize: 14),
          ),
        ),
      ],
    );
  }
}
