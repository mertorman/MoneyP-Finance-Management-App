import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moneyp/feature/home/controller/home_controller.dart';
import 'package:moneyp/feature/stats_page/controller/stats_controller.dart';

class BarChartWidget extends StatelessWidget {
  BarChartWidget(
      {super.key,
      required this.barGroups,
      required this.statsController,
      required this.getTitlesWidget,
      required this.textColor,
      required this.text,
      required this.homeController
      });
  List<BarChartGroupData>? barGroups;
  StatsController statsController;
  Widget Function(double, TitleMeta)? getTitlesWidget;
  Color textColor;
  String text;
  HomeController homeController;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
       Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(homeController.wallets[homeController.currentWalletIndex.value].walletSymbol!,style: TextStyle(
    color: textColor, fontSize: 22, fontWeight: FontWeight.bold),),
          Padding(
            padding: const EdgeInsets.only(top: 7),
            child: Text(
                '$text',
                style: GoogleFonts.daysOne(fontSize: 25, color: textColor)),
          ),
        ],
       ),
         
        
        SizedBox(
          height: 10,
        ),
        Expanded(
          child: Obx(
            () => BarChart(
              BarChartData(
                maxY: statsController.tabController.index == 0 ? statsController.maxYStatusExpenses.value : statsController.maxYStatusIncomes.value,
                minY: 0,
                groupsSpace: 10,
                barTouchData: BarTouchData(
                  enabled: true,
                  touchTooltipData: BarTouchTooltipData(
                    tooltipBgColor: Colors.blue.shade200,
                    getTooltipItem: (
                      BarChartGroupData group,
                      int groupIndex,
                      BarChartRodData rod,
                      int rodIndex,
                    ) {
                      return BarTooltipItem(
                          '%${rod.toY.round().toString()}',
                          GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold));
                    },
                  ),
                ),
                titlesData: FlTitlesData(
                    show: true,
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: AxisTitles(
                        drawBehindEverything: true,
                        sideTitles: SideTitles(
                          showTitles: false,
                        )),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: getTitlesWidget,
                        reservedSize: 42,
                      ),
                    ),
                    leftTitles:
                        AxisTitles(sideTitles: SideTitles(showTitles: false))),
                borderData: FlBorderData(
                  show: false,
                ),
                barGroups: barGroups,
                gridData: FlGridData(show: false),
              ),
            ),
          ),
        ),

      ],
    );
  }
  
}


