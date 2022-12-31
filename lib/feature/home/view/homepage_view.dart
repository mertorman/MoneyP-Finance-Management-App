import 'dart:math';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/services.dart';
import 'package:fluttermoji/fluttermojiCircleAvatar.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:moneyp/feature/home/components/list_item_widget.dart';
import 'package:moneyp/feature/home/model/incomes_model.dart';
import 'package:moneyp/feature/home/model/list_item_model.dart';
import 'package:moneyp/feature/profile/view/profile_page_view.dart';
import 'package:moneyp/feature/home/components/card_widget.dart';
import 'package:moneyp/feature/home/components/expense_add_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moneyp/feature/home/controller/home_controller.dart';
import 'package:moneyp/feature/home/model/expense_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:quickalert/quickalert.dart';
import 'package:sticky_grouped_list/sticky_grouped_list.dart';
import '../controller/auth_controller.dart';
import '../components/indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

int touchedIndex = -1;

List<PieChartSectionData> getGrafikIsEmptyData() {
  return List.generate(
      1,
      (index) => PieChartSectionData(
            color: Colors.blue.withOpacity(0.5),
            value: null,
            title: 'Expense not found',
            radius: 70,
            titleStyle: GoogleFonts.poppins(
                color: Colors.white, fontWeight: FontWeight.w500),
            titlePositionPercentageOffset: 0,
          ));
}

List<PieChartSectionData>? getGrafikData() {
  homeController.grafikYuzdeHesaplama();
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
          color: Color(int.parse(ExpenseModel.expenseItems.value[0].color!))
              .withOpacity(opacity),
          value: (homeController.expenseListYuzdeOran.value[0]) ?? 0,
          title:
              '%${(homeController.expenseListYuzdeOran.value[0].toDouble().round()).toString()}',
          radius: 80,
          titleStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          titlePositionPercentageOffset: 0.55,
          borderSide: isTouched
              ? BorderSide(
                  color: Color(
                      int.parse(ExpenseModel.expenseItems.value[0].color!)),
                  width: 6)
              : BorderSide(color: color0.withOpacity(0)),
        );
      case 1:
        return PieChartSectionData(
          color: Color(int.parse(ExpenseModel.expenseItems.value[1].color!))
              .withOpacity(opacity),
          value: (homeController.expenseListYuzdeOran.value[1]) ?? 25,
          title:
              '%${(homeController.expenseListYuzdeOran.value[1].toDouble().round()).toString()}',
          radius: 65,
          titleStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          titlePositionPercentageOffset: 0.55,
          borderSide: isTouched
              ? BorderSide(color: color1, width: 6)
              : BorderSide(color: color2.withOpacity(0)),
        );
      case 2:
        return PieChartSectionData(
          color: Color(int.parse(ExpenseModel.expenseItems.value[2].color!))
              .withOpacity(opacity),
          value: homeController.expenseListYuzdeOran.value[2] ?? 25,
          title:
              '%${(homeController.expenseListYuzdeOran.value[2].toDouble().round()).toString()}',
          radius: 75,
          titleStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          titlePositionPercentageOffset: 0.6,
          borderSide: isTouched
              ? BorderSide(color: Colors.red, width: 6)
              : BorderSide(color: color2.withOpacity(0)),
        );
      case 3:
        return PieChartSectionData(
          color: Color(int.parse(ExpenseModel.expenseItems.value[3].color!))
              .withOpacity(opacity),
          value: homeController.expenseListYuzdeOran.value[3] ?? 25,
          title:
              '%${(homeController.expenseListYuzdeOran.value[3].toDouble().round()).toString()}',
          radius: 65,
          titleStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          borderSide: isTouched
              ? BorderSide(color: Colors.red, width: 6)
              : BorderSide(color: color2.withOpacity(0)),
        );
      case 4:
        return PieChartSectionData(
          color: Color(int.parse(ExpenseModel.expenseItems.value[4].color!))
              .withOpacity(opacity),
          value: homeController.expenseListYuzdeOran.value[4] ?? 25,
          title:
              '%${(homeController.expenseListYuzdeOran.value[4].toDouble().round()).toString()}',
          radius: 75,
          titleStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
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

double value = 0;
AuthController authController = Get.find<AuthController>();
HomeController homeController = Get.find();

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return homeController.obx(
        onLoading: Scaffold(
          body: Center(
              child:
                  Lottie.asset('assets/loading.json', width: 300, height: 300)),
        ), (state) {
      return Stack(
        children: [
          Scaffold(
            backgroundColor: Colors.blue,
            body: Padding(
              padding: const EdgeInsets.all(20),
              child: SafeArea(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.38,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DrawerHeader(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.height * 0.13,
                              height: MediaQuery.of(context).size.width * 0.215,
                              decoration: BoxDecoration(
                                  color: Colors.white70,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: Colors.blue.shade300, width: 5)),
                              child: FluttermojiCircleAvatar(
                                backgroundColor: Colors.transparent,
                                radius: 45,
                              ),
                            ),
                            Obx(
                              () {
                                return Text(
                                  '${homeController.homeModelValue.name}',
                                  style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView(
                          children: [
                            ListTile(
                              onTap: () {
                                setState(() {
                                  value = 0;
                                });
                              },
                              leading: Icon(
                                Icons.home,
                                color: Colors.white,
                              ),
                              title: Text(
                                'Home',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 17),
                              ),
                            ),
                            ListTile(
                              onTap: () {
                                Get.to(() => ProfilePage(),
                                    transition: Transition.circularReveal,
                                    duration: Duration(milliseconds: 1500));
                              },
                              leading: const Icon(
                                Icons.person,
                                color: Colors.white,
                              ),
                              title: const Text(
                                'Profile',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 17),
                              ),
                            ),
                            ListTile(
                              onTap: () {
                                Get.toNamed('/wallets');
                              },
                              leading: Icon(
                                Icons.account_balance_wallet_outlined,
                                color: Colors.white,
                              ),
                              title: Text(
                                'My Wallets',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 17),
                              ),
                            ),
                            ListTile(
                              onTap: () {
                                Get.toNamed('/stats');
                              },
                              leading: Icon(
                                Icons.query_stats_outlined,
                                color: Colors.white,
                              ),
                              title: Text(
                                'Stats',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 17),
                              ),
                            ),
                            ListTile(
                              onTap: () async {
                                authController.logOut();
                              },
                              leading: const Icon(
                                Icons.logout,
                                color: Colors.white,
                              ),
                              title: const Text(
                                'Log out',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 17),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          TweenAnimationBuilder(
            tween: Tween<double>(begin: 0, end: value),
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInExpo,
            builder: (_, double val, __) {
              return Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..setEntry(0, 3, 200 * val)
                  ..rotateY((pi / 6) * val),
                child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Color(0xFFdfe9f3), Color(0xFFffffff)],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter)),
                  child: Scaffold(
                    resizeToAvoidBottomInset: false,
                    backgroundColor: Colors.transparent,
                    extendBody: false,
                    bottomNavigationBar: BottomAppBar(
                      shape: CircularNotchedRectangle(),
                      notchMargin: 8.0,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          IconButton(
                            icon: Icon(Icons.account_balance_wallet_outlined),
                            onPressed: () {
                              Get.toNamed('/wallets');
                            },
                          ),
                          const SizedBox(width: 48.0),
                          IconButton(
                            icon: const Icon(
                              Icons.query_stats_outlined,
                            ),
                            onPressed: () {
                              Get.toNamed('/stats');
                            },
                          ),
                        ],
                      ),
                    ),
                    floatingActionButtonLocation:
                        FloatingActionButtonLocation.centerDocked,
                    floatingActionButton: FloatingActionButton(
                      backgroundColor: Colors.blue,
                      child: Icon(Icons.add),
                      onPressed: () async {
                        showModalBottomSheet(
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                context: context,
                                builder: (ctx) => ExpenseBottomSheet())
                            .whenComplete(() async {
                          await Future.delayed(const Duration(seconds: 1));
                          setState(() {
                            touchedIndex = -1;
                          });
                        });
                      },
                    ),
                    appBar: AppBar(
                      systemOverlayStyle: SystemUiOverlayStyle.light
                          .copyWith(statusBarColor: Colors.blue),
                      toolbarHeight: 80,
                      centerTitle: true,
                      titleTextStyle:
                          Theme.of(context).textTheme.headlineMedium,
                      backgroundColor: Colors.blue,
                      leading: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Builder(
                          builder: (context) => IconButton(
                            icon: const Icon(
                              Icons.menu_outlined,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              setState(() {
                                value == 0 ? value = 1 : value = 0;
                              });
                            },
                          ),
                        ),
                      ),
                      actions: [
                        Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: Obx(
                            () => Row(
                              children: [
                                AnimatedToggleSwitch<int>.rolling(
                                  innerColor: Colors.transparent,
                                  borderColor: Colors.transparent,
                                  iconOpacity: 0.3,
                                  current: homeController
                                      .currentWalletLastIndex.value,
                                  values: homeController.walletsLength,
                                  onChanged: (i) async {
                                    int lastIndex = homeController
                                        .currentWalletLastIndex.value;

                                    homeController
                                        .currentWalletLastIndex.value = i;
                                    QuickAlert.show(
                                      context: context,
                                      width: MediaQuery.of(context).size.width *
                                          0.75,
                                      type: QuickAlertType.confirm,
                                      text:
                                          "Do you want to go '${homeController.wallets[homeController.currentWalletLastIndex.value].walletType}' account?",
                                      confirmBtnText: 'Yes',
                                      cancelBtnText: 'No',
                                      confirmBtnColor: Colors.green.shade400,
                                      onConfirmBtnTap: () {
                                        homeController
                                            .currentWalletIndex.value = i;
                                        homeController.listBindStream();
                                        Get.back();
                                      },
                                      onCancelBtnTap: () {
                                        homeController.currentWalletLastIndex
                                            .value = lastIndex;
                                        Get.back();
                                      },
                                    );
                                  },
                                  iconBuilder: rollingIconBuilder,
                                  indicatorColor: Colors.green.withOpacity(0.8),
                                  height: 40,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
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
                                  height:
                                      MediaQuery.of(context).size.height * 0.20,
                                  decoration: const BoxDecoration(
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                              Column(
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Align(
                                    alignment: Alignment.center,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(Icons.waving_hand_outlined,
                                            color: Colors.white),
                                        Obx(
                                          () {
                                            return Text(
                                              'Hello ${homeController.homeModelValue.name}',
                                              style: GoogleFonts.poppins(
                                                  color: Colors.white,
                                                  fontSize: 18),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Align(
                                    alignment: Alignment.center,
                                    child: Obx(
                                      () => Text(
                                        homeController
                                                .wallets[homeController
                                                    .currentWalletIndex.value]
                                                .walletSymbol! +
                                            double.parse(homeController
                                                    .wallets[homeController
                                                        .currentWalletIndex
                                                        .value]
                                                    .budget!)
                                                .toStringAsFixed(0),
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 42,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 23,
                                  ),
                                  const TopCardWidget()
                                ],
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: AspectRatio(
                                        aspectRatio: 1,
                                        child: Obx(
                                          () => PieChart(
                                            PieChartData(
                                                startDegreeOffset: 180,
                                                borderData: FlBorderData(
                                                  show: false,
                                                ),
                                                sectionsSpace: 1,
                                                centerSpaceRadius: 0,
                                                sections: homeController
                                                        .expenses.isEmpty
                                                    ? getGrafikIsEmptyData()
                                                    : getGrafikData()),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 70,
                                    ),
                                    Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Indicator(
                                              color: Color(int.parse(
                                                  ExpenseModel.expenseItems
                                                      .value[0].color!)),
                                              text: 'Travel',
                                              isSquare: false,
                                              size: touchedIndex == 0 ? 18 : 16,
                                              textColor: touchedIndex == 0
                                                  ? Colors.black
                                                  : Colors.grey,
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Indicator(
                                              color: Color(int.parse(
                                                  ExpenseModel.expenseItems
                                                      .value[1].color!)),
                                              text: 'Food',
                                              isSquare: false,
                                              size: touchedIndex == 1 ? 18 : 16,
                                              textColor: touchedIndex == 1
                                                  ? Colors.black
                                                  : Colors.grey,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Indicator(
                                              color: Color(int.parse(
                                                  ExpenseModel.expenseItems
                                                      .value[2].color!)),
                                              text: 'Shopping',
                                              isSquare: false,
                                              size: touchedIndex == 2 ? 18 : 16,
                                              textColor: touchedIndex == 2
                                                  ? Colors.black
                                                  : Colors.grey,
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Indicator(
                                              color: Color(int.parse(
                                                  ExpenseModel.expenseItems
                                                      .value[3].color!)),
                                              text: 'Billing',
                                              isSquare: false,
                                              size: touchedIndex == 3 ? 18 : 16,
                                              textColor: touchedIndex == 3
                                                  ? Colors.black
                                                  : Colors.grey,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Indicator(
                                          color: Color(int.parse(ExpenseModel
                                              .expenseItems.value[4].color!)),
                                          text: 'Other',
                                          isSquare: false,
                                          size: touchedIndex == 4 ? 18 : 16,
                                          textColor: touchedIndex == 4
                                              ? Colors.black
                                              : Colors.grey,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        homeController.isExpensesOnTap.value =
                                            true;
                                      },
                                      child: Obx(
                                        () => Row(
                                          children: [
                                            AnimatedOpacity(
                                                opacity: homeController
                                                        .isExpensesOnTap.value
                                                    ? 1
                                                    : 0,
                                                duration:
                                                    Duration(milliseconds: 500),
                                                child: Icon(
                                                    color: Colors.grey,
                                                    size: 17.5,
                                                    Icons
                                                        .arrow_forward_rounded)),
                                            Text("Expenses",
                                                style: GoogleFonts.daysOne(
                                                  textStyle: TextStyle(
                                                      color: homeController
                                                              .isExpensesOnTap
                                                              .value
                                                          ? Colors.red.shade300
                                                          : Colors.red.shade300
                                                              .withOpacity(
                                                                  0.45),
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                )),
                                          ],
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        homeController.isExpensesOnTap.value =
                                            false;
                                      },
                                      child: Obx(
                                        () => Row(
                                          children: [
                                            Text("Incomes",
                                                style: GoogleFonts.daysOne(
                                                  textStyle: TextStyle(
                                                      color: homeController
                                                              .isExpensesOnTap
                                                              .value
                                                          ? Colors
                                                              .green.shade300
                                                              .withOpacity(0.45)
                                                          : Colors
                                                              .green.shade300,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                )),
                                            AnimatedOpacity(
                                                opacity: homeController
                                                        .isExpensesOnTap.value
                                                    ? 0
                                                    : 1,
                                                duration: const Duration(
                                                    milliseconds: 500),
                                                child: const Icon(
                                                  Icons.arrow_back_outlined,
                                                  color: Colors.grey,
                                                  size: 17.5,
                                                )),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Obx(
                                  () {
                                    return homeController.isExpensesOnTap.value
                                        ? homeController.expenses.isEmpty
                                            ? LottieBuilder.asset(
                                                'assets/no_data.json',
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.25,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                              )
                                            : StickyGroupedListView<ListItemModel, DateTime>(
                                                stickyHeaderBackgroundColor:
                                                    Colors.transparent,
                                                elements:
                                                    homeController.expenses,
                                                addAutomaticKeepAlives: true,
                                                scrollDirection: Axis.vertical,
                                                groupSeparatorBuilder: (value) =>
                                                    ListItem.getGroupSeparator(
                                                        value, null, context),
                                                shrinkWrap: true,
                                                groupBy: (element) => DateTime(
                                                    element.expenseYear!,
                                                    element.expenseMonth!,
                                                    element.expenseDay!),
                                                order:
                                                    StickyGroupedListOrder.ASC,
                                                groupComparator: (DateTime value1,
                                                        DateTime value2) =>
                                                    value2.compareTo(value1),
                                                itemBuilder:
                                                    ListItem.expenseGetItem)
                                        : homeController.incomes.isEmpty
                                            ? LottieBuilder.asset(
                                                'assets/no_data.json',
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.25,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                              )
                                            : StickyGroupedListView<IncomesModel, DateTime>(
                                                stickyHeaderBackgroundColor: Colors.transparent,
                                                elements: homeController.incomes,
                                                addAutomaticKeepAlives: true,
                                                scrollDirection: Axis.vertical,
                                                groupSeparatorBuilder: (value) => ListItem.getGroupSeparator(null, value, context),
                                                shrinkWrap: true,
                                                groupBy: (element) => DateTime(element.incomesYear!, element.incomesMonth!, element.incomesDay!),
                                                order: StickyGroupedListOrder.ASC,
                                                groupComparator: (DateTime value1, DateTime value2) => value2.compareTo(value1),
                                                itemBuilder: ListItem.incomesGetItem);
                                  },
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          GestureDetector(
            onHorizontalDragUpdate: (details) {
              if (details.delta.dx > 0) {
                setState(() {
                  value = 1;
                });
              } else {
                setState(() {
                  value = 0;
                });
              }
            },
          ),
        ],
      );
    });
  }

  Widget rollingIconBuilder(int value, Size iconSize, bool foreground) {
    List<String> icons = [];

    homeController.wallets.forEach((element) {
      icons.add(
        'assets/images/moneyicons/${element.walletTypeName}.png',
      );
    });

    return ImageIcon(
      AssetImage(icons[value]),
      size: iconSize.shortestSide,
    );
  }
}
