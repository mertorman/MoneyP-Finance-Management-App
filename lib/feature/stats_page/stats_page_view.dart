import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

class StatsPage extends StatefulWidget {
  const StatsPage({super.key});

  @override
  State<StatsPage> createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  final Color leftBarColor = const Color(0xff53fdd7);
  final Color rightBarColor = const Color(0xffff5182);
  final double width = 25;

  late List<BarChartGroupData> rawBarGroups;
  late List<BarChartGroupData> showingBarGroups;
  int touchedGroupIndex = -1;
  @override
  void initState() {
    super.initState();
    final barGroup1 = makeGroupData(0, 5, 12);
    final barGroup2 = makeGroupData(1, 16, 12);
    final barGroup3 = makeGroupData(2, 18, 5);
    final barGroup4 = makeGroupData(3, 20, 16);

    final items = [
      barGroup1,
      barGroup2,
      barGroup3,
      barGroup4,
    ];

    rawBarGroups = items;

    showingBarGroups = rawBarGroups;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Color(0xFFE0EAFC), Color(0xFFCFDEF3)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)),
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              centerTitle: true,
              elevation: 0,
              title: Text(
                'Stats',
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                  fontSize: 25,
                ),
              ),
              leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(Icons.chevron_left_outlined),
                color: Colors.white,
                iconSize: 40,
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Center(
                    child: Container(
                      width: 400,
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white.withOpacity(0.8)),
                      child: TabBar(
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
                            text: 'Incomes',
                          ),
                          Tab(
                            text: 'Expenses',
                          ),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        width: 400,
                        height: 400,
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(15)),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                '01 Jan 2022 - 01 Feb 2022',
                                style: TextStyle(
                                    color: Colors.blueGrey.shade300,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.5),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                '\$25.000',
                                style: TextStyle(
                                    color: Colors.green.shade300,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold),
                              ),
                              Expanded(
                                child: BarChart(
                                  BarChartData(
                                    maxY: 24,
                                    barTouchData: BarTouchData(
                                      touchTooltipData: BarTouchTooltipData(
                                        tooltipBgColor: Colors.transparent,
                                        getTooltipItem: (a, b, c, d) => null,
                                      ),
                                    ),
                                    titlesData: FlTitlesData(
                                      show: true,
                                      rightTitles: AxisTitles(
                                        sideTitles:
                                            SideTitles(showTitles: false),
                                      ),
                                      topTitles: AxisTitles(
                                        sideTitles:
                                            SideTitles(showTitles: false),
                                      ),
                                      bottomTitles: AxisTitles(
                                        sideTitles: SideTitles(
                                          showTitles: true,
                                          getTitlesWidget: bottomTitles,
                                          reservedSize: 42,
                                        ),
                                      ),
                                      leftTitles: AxisTitles(
                                        sideTitles: SideTitles(
                                          showTitles: true,
                                          reservedSize: 28,
                                          interval: 1,
                                          getTitlesWidget: leftTitles,
                                        ),
                                      ),
                                    ),
                                    borderData: FlBorderData(
                                      show: false,
                                    ),
                                    barGroups: showingBarGroups,
                                    gridData: FlGridData(show: false),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Container(
                        width: 100,
                        height: 200,
                        color: Colors.white.withOpacity(0.9),
                      )),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                          child: Container(
                        width: 100,
                        height: 200,
                        color: Colors.white.withOpacity(0.9),
                      ))
                    ],
                  ),
                  SizedBox(),
                ],
              ),
            )),
      ),
    );
  }

  Widget leftTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff7589a2),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    if (value == 0) {
      text = '1K';
    } else if (value == 10) {
      text = '5K';
    } else if (value == 19) {
      text = '10K';
    } else {
      return Container();
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 0,
      child: Text(text, style: style),
    );
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    final titles = <String>['1. Week', '2. Week', '3. Week', '4. Week'];

    final Widget text = Text(
      titles[value.toInt()],
      style: const TextStyle(
        color: Color(0xff7589a2),
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16, //margin top
      child: text,
    );
  }

  BarChartGroupData makeGroupData(int x, double y1, double y2) {
    return BarChartGroupData(
      barsSpace: 4,
      x: x,
      barRods: [
        BarChartRodData(
          toY: y1,
          color: leftBarColor,
          width: width,
        ),
      ],
    );
  }
}
