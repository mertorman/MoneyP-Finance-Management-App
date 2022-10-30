import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:moneyp/feature/home/components/card_widget.dart';
import 'package:moneyp/feature/home/components/expense_add_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moneyp/feature/home/model/category_widget_model.dart';
import 'package:moneyp/feature/home/model/list_item_model.dart';
import 'package:rounded_expansion_tile/rounded_expansion_tile.dart';
import 'package:fl_chart/fl_chart.dart';

import '../components/indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

int touchedIndex = -1;
List<PieChartSectionData> showingSections() {
  return List.generate(5, (i) {
    final isTouched = i == touchedIndex;
    final opacity = isTouched ? 1.0 : 0.6;

    const color0 = Color(0xff0293ee);
    const color1 = Color(0xfff8b250);
    const color2 = Color(0xff845bef);
    const color3 = Color(0xff13d38e);

    switch (i) {
      case 0:
        return PieChartSectionData(
          color: CategoryWidgetModel.categoryWidgetModels[0].containerColor
              .withOpacity(opacity),
          value: 25,
          title: '',
          radius: 80,
          titleStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xff044d7c),
          ),
          titlePositionPercentageOffset: 0.55,
          borderSide: isTouched
              ? BorderSide(
                  color: CategoryWidgetModel
                      .categoryWidgetModels[0].containerColor,
                  width: 6)
              : BorderSide(color: color0.withOpacity(0)),
        );
      case 1:
        return PieChartSectionData(
          color: CategoryWidgetModel.categoryWidgetModels[1].containerColor
              .withOpacity(opacity),
          value: 25,
          title: '',
          radius: 65,
          titleStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xff90672d),
          ),
          titlePositionPercentageOffset: 0.55,
          borderSide: isTouched
              ? BorderSide(color: color1, width: 6)
              : BorderSide(color: color2.withOpacity(0)),
        );
      case 2:
        return PieChartSectionData(
          color: CategoryWidgetModel.categoryWidgetModels[2].containerColor
              .withOpacity(opacity),
          value: 25,
          title: '',
          radius: 75,
          titleStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xff4c3788),
          ),
          titlePositionPercentageOffset: 0.6,
          borderSide: isTouched
              ? BorderSide(color: Colors.red, width: 6)
              : BorderSide(color: color2.withOpacity(0)),
        );
      case 3:
        return PieChartSectionData(
          color: CategoryWidgetModel.categoryWidgetModels[3].containerColor
              .withOpacity(opacity),
          value: 25,
          title: '',
          radius: 65,
          titleStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xff0c7f55),
          ),
          borderSide: isTouched
              ? BorderSide(color: Colors.red, width: 6)
              : BorderSide(color: color2.withOpacity(0)),
        );
      case 4:
        return PieChartSectionData(
          color: CategoryWidgetModel.categoryWidgetModels[4].containerColor
              .withOpacity(opacity),
          value: 25,
          title: '',
          radius: 75,
          titleStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xff0c7f55),
          ),
          borderSide: isTouched
              ? BorderSide(color: Colors.red, width: 6)
              : BorderSide(color: color2.withOpacity(0)),
        );
      default:
        throw Error();
    }
  });
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.show_chart,
              ),
              onPressed: () {},
            ),
            SizedBox(width: 48.0),
            IconButton(
              icon: Icon(
                Icons.filter_list,
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        child: Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              context: context,
              builder: (ctx) => ExpenseBottomSheet());
        },
      ),
      drawer: const Drawer(),
      backgroundColor: Colors.white,
      appBar: AppBar(
        systemOverlayStyle:
            SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.blue),
        toolbarHeight: 80,
        centerTitle: true,
        titleTextStyle: Theme.of(context).textTheme.headlineMedium,
        backgroundColor: Colors.blue,
        leading: Padding(
          padding: const EdgeInsets.all(20),
          child: Builder(
            builder: (context) => IconButton(
              icon: const Icon(
                Icons.menu_outlined,
                color: Colors.white,
              ),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
        ),
        elevation: 0,
        title: Text('MoneyP',
            style: GoogleFonts.pacifico(
                textStyle: TextStyle(
                    color: Colors.white.withOpacity(0.90),
                    fontSize: 30,
                    letterSpacing: 2,
                    fontWeight: FontWeight.w500))),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Material(
                  elevation: 15,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.20,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                    ),
                  ),
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.waving_hand_outlined, color: Colors.white),
                          Text(
                            ' Hello Mert',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          MaterialButton(
                            onPressed: () {
                              FirebaseAuth.instance.signOut();
                            },
                            color: Colors.deepPurple,
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        '₺5.400',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 42,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 23,
                    ),
                    TopCardWidget()
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: AspectRatio(
                          aspectRatio: 1.2,
                          child: PieChart(
                            PieChartData(
                                pieTouchData: PieTouchData(
                                  touchCallback:
                                      (FlTouchEvent event, pieTouchResponse) {
                                    setState(() {
                                      if (!event.isInterestedForInteractions ||
                                          pieTouchResponse == null ||
                                          pieTouchResponse.touchedSection ==
                                              null) {
                                        touchedIndex = -1;
                                        return;
                                      }
                                      touchedIndex = pieTouchResponse
                                          .touchedSection!.touchedSectionIndex;
                                    });
                                  },
                                ),
                                startDegreeOffset: 180,
                                borderData: FlBorderData(
                                  show: false,
                                ),
                                sectionsSpace: 1,
                                centerSpaceRadius: 0,
                                sections: showingSections()),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Indicator(
                                color: CategoryWidgetModel
                                    .categoryWidgetModels[0].containerColor,
                                text: 'Travel',
                                isSquare: false,
                                size: touchedIndex == 0 ? 18 : 16,
                                textColor: touchedIndex == 0
                                    ? Colors.black
                                    : Colors.grey,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Indicator(
                                color: CategoryWidgetModel
                                    .categoryWidgetModels[1].containerColor,
                                text: 'Food',
                                isSquare: false,
                                size: touchedIndex == 1 ? 18 : 16,
                                textColor: touchedIndex == 1
                                    ? Colors.black
                                    : Colors.grey,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Indicator(
                                color: CategoryWidgetModel
                                    .categoryWidgetModels[2].containerColor,
                                text: 'Shopping',
                                isSquare: false,
                                size: touchedIndex == 2 ? 18 : 16,
                                textColor: touchedIndex == 2
                                    ? Colors.black
                                    : Colors.grey,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Indicator(
                                color: CategoryWidgetModel
                                    .categoryWidgetModels[3].containerColor,
                                text: 'Billing',
                                isSquare: false,
                                size: touchedIndex == 3 ? 18 : 16,
                                textColor: touchedIndex == 3
                                    ? Colors.black
                                    : Colors.grey,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Indicator(
                            color: CategoryWidgetModel
                                .categoryWidgetModels[4].containerColor,
                            text: 'Other',
                            isSquare: false,
                            size: touchedIndex == 4 ? 18 : 16,
                            textColor:
                                touchedIndex == 4 ? Colors.black : Colors.grey,
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Expenses",
                          style: GoogleFonts.daysOne(
                            textStyle: const TextStyle(
                                color: Color(0xFF40565a),
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ))
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: ListItemModel.models.length,
                      itemBuilder: (context, index) {
                        return ListItem(
                            expenseTitle:
                                ListItemModel.models[index].expenseTitle,
                            expenseDescription:
                                ListItemModel.models[index].expenseDescription,
                            expenseTotal:
                                ListItemModel.models[index].expenseTotal,
                            expenseIcon:
                                ListItemModel.models[index].expenseIcon);
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  const ListItem(
      {Key? key,
      required this.expenseTitle,
      required this.expenseDescription,
      required this.expenseTotal,
      required this.expenseIcon})
      : super(key: key);

  final expenseTitle;
  final expenseDescription;
  final Icon expenseIcon;
  final expenseTotal;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4),
      height: 100,
      child: RoundedExpansionTile(
        enabled: false,
        trailing: IconButton(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          hoverColor: Colors.transparent,
          icon: Icon(
            Icons.edit,
            color: Colors.black,
          ),
          onPressed: () {},
        ),
        leading: expenseIcon,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    expenseTitle,
                    style: Theme.of(context).textTheme.subtitle2?.copyWith(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    expenseDescription,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1
                        ?.copyWith(color: Colors.grey.shade600, fontSize: 14),
                  ),
                  Text(
                    expenseTotal + " ",
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1
                        ?.copyWith(color: Colors.black, fontSize: 14),
                  ),
                ],
              ),
            ),
          ],
        ),
        children: [],
      ),
    );
  }
}
/*
class CardWidget extends StatelessWidget {
  const CardWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      color: Colors.indigoAccent.shade200,
      child: Container(
        width: 140,
        height: 165,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'VISA',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 35,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('₺',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w500)),
                  Padding(
                    padding: const EdgeInsets.only(top: 7),
                    child: Text('600',
                        style: GoogleFonts.daysOne(
                            textStyle: const TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.w500))),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}*/

