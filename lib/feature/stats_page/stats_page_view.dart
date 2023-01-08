import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:moneyp/feature/home/controller/home_controller.dart';
import 'package:moneyp/feature/stats_page/components/bar_chart.dart';
import 'package:moneyp/feature/stats_page/controller/stats_controller.dart';
import 'package:rounded_expansion_tile/rounded_expansion_tile.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

import '../../product/constant/color_settings.dart';
import '../home/model/expense_model.dart';

class StatsPage extends StatefulWidget {
  const StatsPage({super.key});

  @override
  State<StatsPage> createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  StatsController statsController = Get.find();
  HomeController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return statsController.obx(
        onLoading: Scaffold(
          body: Center(
              child:
                  Lottie.asset('assets/loading.json', width: 300, height: 300)),
        ), (state) {
      DateTime currentDate = DateTime.now();
      DateTime queryDate = currentDate.subtract(Duration(days: 30));
      final formatter = DateFormat('dd MMM yyyy');
      final formatCurrentDate = formatter.format(currentDate);
      final formatqueryDateDate = formatter.format(queryDate);

      statsController.statsYuzdeHesaplama();
      statsController.statsIncomeYuzdeHesaplama();
      return Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Color(0xFFE0EAFC), Color(0xFFCFDEF3)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)),
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                icon: Icon(Icons.arrow_back_outlined),
                onPressed: () {
                  Get.back();
                },
                color: Colors.blueAccent.shade100,
              ),
              title: Text(
                'My Stats',
                style: GoogleFonts.poppins(
                  color: Colors.blue.shade300,
                  fontWeight: FontWeight.w800,
                  fontSize: 24,
                ),
              ),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    LottieBuilder.asset(
                      "assets/stats.json",
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.2,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.88,
                        height: MediaQuery.of(context).size.height * 0.052,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white.withOpacity(0.8)),
                        child: TabBar(
                          physics: NeverScrollableScrollPhysics(),
                          controller: statsController.tabController,
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
                          tabs: [
                            Tab(
                              child: Text(
                                'Expenses',
                                style: GoogleFonts.poppins(
                                    fontSize: 14.5,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            Tab(
                              child: Text(
                                'Incomes',
                                style: GoogleFonts.poppins(
                                    fontSize: 14.5,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.88,
                          height: MediaQuery.of(context).size.height * 0.44,
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.85),
                              borderRadius: BorderRadius.circular(15)),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                    '$formatqueryDateDate - $formatCurrentDate',
                                    style: GoogleFonts.poppins(
                                        color: Colors.blueGrey.shade300,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14)),
                                SizedBox(
                                  height: 13,
                                ),
                                Expanded(
                                  child: TabBarView(
                                      physics: NeverScrollableScrollPhysics(),
                                      controller: statsController.tabController,
                                      children: [
                                        BarChartWidget(
                                          barGroups: makeGroupExpenses(),
                                          statsController: statsController,
                                          getTitlesWidget: bottomTitles,
                                          text: statsController
                                              .grafikToplam.value
                                              .toStringAsFixed(2),
                                          textColor: Colors.red.shade400,
                                          homeController: homeController,
                                        ),
                                        BarChartWidget(
                                          barGroups: makeGroupIncomes(),
                                          statsController: statsController,
                                          getTitlesWidget: bottomTitlesIncomes,
                                          text: statsController
                                              .incomeStatsToplam.value
                                              .toStringAsFixed(2),
                                          textColor: Colors.green.shade400,
                                          homeController: homeController,
                                        ),
                                      ]),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.88,
                      height: MediaQuery.of(context).size.height * 0.3,
                      child: Column(
                        children: [
                          Flexible(
                            child: TabBarView(
                                physics: NeverScrollableScrollPhysics(),
                                controller: statsController.tabController,
                                children: [
                                  detailsWidget(
                                      formatqueryDateDate,
                                      formatCurrentDate,
                                      'Expense Details',
                                      Colors.red,
                                      expensesInfo(),
                                      'Expense Details',
                                      context),
                                  detailsWidget(
                                      formatqueryDateDate,
                                      formatCurrentDate,
                                      'Income Details',
                                      Colors.green,
                                      incomesInfo(),
                                      'Incomes Details',
                                      context),
                                ]),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )),
      );
    });
  }

  SingleChildScrollView detailsWidget(
      String formatqueryDateDate,
      String formatCurrentDate,
      String title,
      Color color,
      Column info,
      String detailsText,
      BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.only(top: 13),
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                borderRadius: BorderRadius.circular(15)),
            child: RoundedExpansionTile(
              onTap: () {},
              trailing: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: Colors.blue.withAlpha(80)),
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
                      margin: const EdgeInsets.only(left: 15),
                      child: Image.asset(
                        'assets/images/expense_details.png',
                        width: 55,
                        height: 55,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          '$formatqueryDateDate - $formatCurrentDate',
                          style: GoogleFonts.poppins(
                              color: Color(0xFF3b67b5),
                              fontWeight: FontWeight.w500,
                              fontSize: 14),
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
                      detailsText,
                      style: GoogleFonts.poppins(
                          color: Colors.grey.shade500, fontSize: 14),
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                          child: Text(
                              'According to your 1-month statistics information',
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.8))),
                      SizedBox(
                        height: 5,
                      ),
                      info
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.32,
            height: MediaQuery.of(context).size.height * 0.0255,
            alignment: Alignment.center,
            margin: const EdgeInsets.only(left: 16),
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 24),
            decoration: BoxDecoration(
              color: color.withOpacity(0.65),
              borderRadius: BorderRadius.circular(36),
            ),
            child: Text(
              title,
              style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  Column expensesInfo() {
    return Column(
      children: [
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              infoExpenses('Travel', '${statsController.travelToplam.value}',
                  '${homeController.wallets[homeController.currentWalletIndex.value].walletSymbol}'),
              const Icon(
                Icons.remove_outlined,
                color: Colors.red,
              ),
            ]),
        const SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            infoExpenses('Food', '${statsController.foodToplam.value}',
                '${homeController.wallets[homeController.currentWalletIndex.value].walletSymbol}'),
            const Icon(
              Icons.remove_outlined,
              color: Colors.red,
            ),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            infoExpenses('Shopping', '${statsController.shoppingToplam.value}',
                '${homeController.wallets[homeController.currentWalletIndex.value].walletSymbol}'),
            const Icon(
              Icons.remove_outlined,
              color: Colors.red,
            ),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            infoExpenses('Billing', '${statsController.billingToplam.value}',
                '${homeController.wallets[homeController.currentWalletIndex.value].walletSymbol}'),
            const Icon(
              Icons.remove_outlined,
              color: Colors.red,
            ),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            infoExpenses('Other', '${statsController.otherToplam.value}',
                '${homeController.wallets[homeController.currentWalletIndex.value].walletSymbol}'),
            const Icon(
              Icons.remove_outlined,
              color: Colors.red,
            ),
          ],
        ),
      ],
    );
  }

  Column incomesInfo() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            infoIncomes(
                'income',
                '${statsController.incomeStatsToplam.value}',
                '${homeController.wallets[homeController.currentWalletIndex.value].walletSymbol}',
                Colors.green.shade400),
            const Icon(
              Icons.add_outlined,
              color: Colors.green,
            ),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            infoIncomes(
                'expense',
                '${statsController.grafikToplam.value}',
                '${homeController.wallets[homeController.currentWalletIndex.value].walletSymbol}',
                Colors.red.shade400),
            const Icon(
              Icons.remove_outlined,
              color: Colors.red,
            ),
          ],
        ),
      ],
    );
  }

  Row infoExpenses(String category, String amount, String walletSymbol) {
    return Row(
      children: [
        Text("In the '$category' category ",
            style: GoogleFonts.poppins(fontSize: 14.5)),
        Icon(
          Icons.arrow_circle_right,
          color: Colors.blue.shade300,
          size: 24.0,
          semanticLabel: 'Text to announce in accessibility modes',
        ),
        SizedBox(
          width: 4,
        ),
        Text(
          "'$amount$walletSymbol' ",
          style:
              GoogleFonts.poppins(fontSize: 14.5, color: Colors.red.shade400),
        ),
        Text('was spent.', style: GoogleFonts.poppins(fontSize: 14.5))
      ],
    );
  }

  Row infoIncomes(
      String type, String amount, String walletSymbol, Color color) {
    return Row(
      children: [
        Text("The amount of your $type ",
            style: GoogleFonts.poppins(fontSize: 14.5)),
        Icon(
          Icons.arrow_circle_right,
          color: Colors.blue.shade300,
          size: 24.0,
          semanticLabel: 'Text to announce in accessibility modes',
        ),
        SizedBox(
          width: 4,
        ),
        Text(
          "'$amount$walletSymbol' ",
          style: GoogleFonts.poppins(fontSize: 14.5, color: color),
        ),
      ],
    );
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    final titles = <String>['Travel', 'Food', 'Shopping', 'Billing', 'Other'];

    final Widget text = Text(titles[value.toInt()],
        style: GoogleFonts.poppins(
            fontSize: 12.5,
            fontWeight: FontWeight.w500,
            color: Color(0xff7589a2)));

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16, //margin top
      child: text,
    );
  }

  Widget bottomTitlesIncomes(double value, TitleMeta meta) {
    final titles = <String>['Incomes', 'Expenses'];

    final Widget text = Text(titles[value.toInt()],
        style: GoogleFonts.poppins(
            fontSize: 12.5,
            fontWeight: FontWeight.w500,
            color: Color(0xff7589a2)));

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16, //margin top
      child: text,
    );
  }

  List<BarChartGroupData> makeGroupExpenses() {
    List<BarChartGroupData> grafikListe = [];
    int x = 0;
    statsController.statsYuzde.forEach((element) {
      grafikListe.add(BarChartGroupData(
          showingTooltipIndicators: [0],
          x: x,
          barRods: [
            BarChartRodData(
                borderRadius: BorderRadius.circular(8),
                toY: element,
                width: 40,
                color:
                    Color(int.parse(ExpenseModel.expenseItems.value[x].color!))
                        .withOpacity(0.6))
          ]));
      x++;
    });
    return grafikListe;
  }

  List<BarChartGroupData> makeGroupIncomes() {
    List<BarChartGroupData> grafikListe = [];

    grafikListe.add(BarChartGroupData(
        showingTooltipIndicators: [0],
        x: 0,
        barRods: [
          BarChartRodData(
              borderRadius: BorderRadius.circular(8),
              toY: statsController.incomesAmountPercent.value,
              width: 40,
              color: Colors.green)
        ]));
    grafikListe.add(BarChartGroupData(
        showingTooltipIndicators: [0],
        x: 1,
        barRods: [
          BarChartRodData(
              borderRadius: BorderRadius.circular(8),
              toY: statsController.expensesAmountPercent.value,
              width: 40,
              color: Colors.red)
        ]));

    return grafikListe;
  }
}
