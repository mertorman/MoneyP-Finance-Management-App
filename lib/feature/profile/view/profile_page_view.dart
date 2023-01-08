import 'dart:math';

import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:fluttermoji/fluttermoji.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:moneyp/feature/home/controller/auth_controller.dart';
import 'package:moneyp/feature/home/controller/home_controller.dart';
import 'package:moneyp/feature/profile/view/profile_image.dart';
import 'package:quickalert/quickalert.dart';
import '../../../product/constant/color_settings.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  Column info(String info, String value) {
    return Column(
      children: [
        Text(
          info,
          style: GoogleFonts.poppins(
              color: ColorSettings.themeColor.shade200,
              fontWeight: FontWeight.w500),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          value,
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  HomeController homeController = Get.find();

  AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    nameController.text = homeController.homeModel.value.name!;
    emailController.text = homeController.homeModel.value.email!;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.chevron_left),
              color: Colors.white,
              iconSize: 40),
          centerTitle: true,
          title: Text(
            'Profile',
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: 24,
            ),
          ),
          backgroundColor: Colors.blue,
          elevation: 0,
        ),
        backgroundColor: Colors.grey.shade200,
        body: Stack(fit: StackFit.expand, children: [
          FractionallySizedBox(
            alignment: Alignment.topCenter,
            heightFactor: 0.3,
            child: Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(0)),
                  color: Colors.blue),
              child: Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Text('MoneyP',
                      style: GoogleFonts.pacifico(
                          textStyle: TextStyle(
                              color: Colors.white.withOpacity(0.4),
                              fontSize: 30,
                              letterSpacing: 50,
                              fontWeight: FontWeight.w500))),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12, right: 12,bottom: 40),
            child: FractionallySizedBox(
              alignment: Alignment.bottomCenter,
              heightFactor: 0.8,
              child: Card(
                color: Colors.white,
                elevation: 3,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Spacer(
                      flex: 2,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          homeController.homeModel.value.name!,
                          style: GoogleFonts.poppins(
                              fontSize: 26, fontWeight: FontWeight.w600),
                        ),
                        GetBuilder(
                          builder: (HomeController controller) {
                            return Text(
                              controller.homeModel.value.email!,
                              style: GoogleFonts.poppins(fontSize: 18),
                            );
                          },
                        ),
                      ],
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Obx(
                        () => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            info('Total Expenses',
                                homeController.expenseList.length.toString()),
                            Container(
                              width: 1,
                              height: 40,
                              color: Colors.grey,
                            ),
                            info('Total Incomes',
                                homeController.incomesList.length.toString()),
                            Container(
                              width: 1,
                              height: 40,
                              color: Colors.grey,
                            ),
                            info('Active Wallets',
                                homeController.walletList.length.toString()),
                          ],
                        ),
                      ),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        const Expanded(child: Divider(thickness: 1)),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'View Profile',
                          style: GoogleFonts.poppins(
                              fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        const Expanded(child: Divider(thickness: 1)),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 10, right: 18, top: 10, bottom: 10),
                      child: Form(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width * 0.9,
                              height: MediaQuery.of(context).size.height * 0.07,
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 245, 245, 245),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 18, top: 10, bottom: 10),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Icon(LineAwesomeIcons.user,
                                            color: Colors.grey),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                            child: TextField(
                                          controller: nameController,
                                          enabled: false,
                                          onTap: () {
                                            nameController.clear();
                                          },
                                          style: GoogleFonts.poppins(),
                                          decoration: InputDecoration.collapsed(
                                            hintText: 'Full Name',
                                            border: InputBorder.none,
                                          ),
                                        )),
                                      ]))),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width * 0.9,
                              height: MediaQuery.of(context).size.height * 0.07,
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 245, 245, 245),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 18, top: 10, bottom: 10),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Icon(LineAwesomeIcons.envelope_1,
                                            color: Colors.grey),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                            child: TextField(
                                          controller: emailController,
                                          style: GoogleFonts.poppins(),
                                          enabled: false,
                                          decoration: InputDecoration.collapsed(
                                            hintText: 'E-Mail',
                                            border: InputBorder.none,
                                          ),
                                        )),
                                      ]))),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      )),
                    ),
                    Spacer(),
                    AnimatedToggleSwitch<int>.rolling(
                      innerColor: Colors.transparent,
                      borderColor: Colors.transparent,
                      iconOpacity: 1.0,
                      current: 4,
                      values: [0, 1, 2, 3, 4],
                      iconBuilder: rollingIconBuilder,
                      indicatorColor: Colors.transparent,
                      height: 40,
                    ),
                    const Spacer(
                      flex: 2,
                    ),
                  ],
                ),
              ),
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeIn,
            child: FractionallySizedBox(
              heightFactor: 0.73,
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.height * 0.13,
                        height: MediaQuery.of(context).size.width * 0.26,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [Color(0xFFdfe9f3), Color(0xFFffffff)],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter),
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: Colors.blue.shade300, width: 5)),
                        child: FluttermojiCircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 55,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.078,
                          height: MediaQuery.of(context).size.height * 0.04,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.blue.shade200),
                          child: IconButton(
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return const ProfileImage();
                                  },
                                );
                              },
                              icon: Icon(
                                LineAwesomeIcons.alternate_pencil,
                              )),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ]));
  }

  Widget rollingIconBuilder(int value, Size iconSize, bool foreground) {
    List<String> icons = [];
    icons.add(
      'assets/images/moneyicons/lira.png',
    );

    icons.add(
      'assets/images/moneyicons/dollar.png',
    );
    icons.add(
      'assets/images/moneyicons/euro.png',
    );
    icons.add(
      'assets/images/moneyicons/lira.png',
    );

    icons.add(
      'assets/images/moneyicons/lira.png',
    );

    List<Color> renkler = [
      Colors.transparent,
      Colors.grey,
      Colors.grey,
      Colors.grey,
      Colors.transparent
    ];
    homeController.wallets.forEach((element) {
      if (element.walletType == 'Dollar Wallet') {
        renkler[1] = Colors.green;
      } else if (element.walletType == 'Euro Wallet') {
        renkler[2] = Colors.green;
      } else if (element.walletType == 'Lira Wallet') {
        renkler[3] = Colors.green;
      }
    });

    return ImageIcon(
      AssetImage(icons[value]),
      color: renkler[value],
      size: iconSize.shortestSide,
    );
  }
}
