import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:moneyp/feature/home/controller/home_controller.dart';
import 'package:moneyp/feature/stats_page/components/bar_chart.dart';
import 'package:moneyp/feature/stats_page/controller/stats_controller.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

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
            
            body: SingleChildScrollView(
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    
                    children: [
                      LottieBuilder.asset(
                        "assets/stats.json",
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.20,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Container(
                          width: 400,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white.withOpacity(0.8)),
                          child: TabBar(
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
                            tabs: const [
                              Tab(
                                text: 'Expenses',
                              ),
                              Tab(
                                text: 'Incomes',
                              ),
                            ],
                          ),
                        ),
                      ),
                     const  SizedBox(
                        height: 20,
                      ),
                      Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.85,
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
                                    style: TextStyle(
                                        color: Colors.blueGrey.shade300,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.5),
                                  ),
                                  SizedBox(
                                    height: 13,
                                  ),
                                  Expanded(
                                    child: TabBarView(
                                        controller:
                                            statsController.tabController,
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
                  ],
                  ),
                ),
              ),
            )),
      );
    });
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
