import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:moneyp/feature/home/controller/auth_controller.dart';
import 'package:moneyp/feature/home/controller/home_controller.dart';
import 'package:moneyp/feature/wallet_onboard/controller/wallet_controller.dart';
import 'package:moneyp/feature/wallet_onboard/model/wallet_model.dart';

class WalletsPage extends StatefulWidget {
  const WalletsPage({super.key});

  @override
  State<WalletsPage> createState() => _WalletsPageState();
}

class _WalletsPageState extends State<WalletsPage> {
  WalletController walletController = Get.find();
  HomeController homeController = Get.find();
  AuthController authController = Get.find();
  final List<TextEditingController> _controllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController()
  ];
  @override
  void dispose() {
    for (TextEditingController c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  int value = 0;
  @override
  Widget build(BuildContext context) {
  
    return walletController.obx(
        onLoading: Scaffold(
          body: Center(
              child: Lottie.asset('assets/loading.json',
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: MediaQuery.of(context).size.height * 0.5)),
        ), (state) {
      return Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
            Color(0xFFE0EAFC),
            Color(0xFFCFDEF3),
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          child: Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.transparent,
              body: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Lottie.asset('assets/onboard_wallet.json',
                        alignment: Alignment.topCenter,
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.30),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              "My Wallets",
                              style: TextStyle(
                                  fontFamily: 'Rubik',
                                  letterSpacing: 1.3,
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueAccent.shade100),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'You can open and close your wallets and update their budgets whenever you want. (You must have at least 1 open wallet)',
                            style: TextStyle(
                                color: Colors.grey.shade500,
                                fontSize: 16,
                                letterSpacing: 1.5),
                          ),
                        ],
                      ),
                    ),
                    Obx(
                      () => ListView.builder(
                        shrinkWrap: true,
                        itemCount: walletController.wallets.length,
                        itemBuilder: (context, index) {
                          if (value < walletController.wallets.length) {
                            homeController.wallets.forEach((elementCurrent) {
                              int index1 = 0;
                              walletController.wallets.forEach((element) {
                                if (elementCurrent.walletSymbol ==
                                    element.walletSymbol) {
                                  element.enabled = true;
                                  _controllers[index1].text =
                                      elementCurrent.budget!;
                                }
                                index1++;
                              });
                            });

                            value++;
                          }

                          return Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 25),
                              child: Stack(
                                children: [
                                  AnimatedOpacity(
                                    duration: const Duration(milliseconds: 300),
                                    opacity:
                                        walletController.wallets[index].enabled!
                                            ? 0.9
                                            : 0.65,
                                    child: Container(
                                      margin: EdgeInsets.only(top: 13),
                                      width: MediaQuery.of(context).size.width *
                                          0.85,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.09,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        color: Colors.white,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(),
                                            Container(
                                                width: 40,
                                                height: 40,
                                                child: Image.asset(
                                                    walletController
                                                        .wallets[index].icon!)),
                                            SizedBox(
                                              width: 130,
                                              height: 45,
                                              child: TextField(
                                                controller: _controllers[index],
                                                textAlign: TextAlign.center,
                                                keyboardType:
                                                    TextInputType.number,
                                                decoration: InputDecoration(
                                                    labelText: 'Enter Budget',
                                                    alignLabelWithHint: true,
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 10),
                                                    hintText: walletController
                                                        .wallets[index]
                                                        .walletSymbol,
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(32))),
                                              ),
                                            ),
                                            FlutterSwitch(
                                              width: 73,
                                              height: 30,
                                              valueFontSize: 12.0,
                                              toggleSize: 20.0,
                                              value: walletController
                                                  .wallets[index].enabled!,
                                              borderRadius: 30.0,
                                              padding: 3.0,
                                              showOnOff: true,
                                              activeText: 'Disable',
                                              inactiveText: 'Enable',
                                              inactiveColor:
                                                  Colors.grey.withOpacity(0.4),
                                              onToggle: (value) {
                                                setState(() {
                                                  //Kullanılan kütüphane gereği setState yapmak zorunlu olduğundan GetX kullanılamıyor.

                                                  walletController
                                                      .wallets[index]
                                                      .enabled = value;
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.275,
                                    height: MediaQuery.of(context).size.height *
                                        0.0255,
                                    alignment: Alignment.center,
                                    margin: const EdgeInsets.only(left: 16),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4, horizontal: 24),
                                    decoration: BoxDecoration(
                                      color: walletController
                                          .wallets[index].walletColor!
                                          .withOpacity(0.65),
                                      borderRadius: BorderRadius.circular(36),
                                    ),
                                    child: Text(
                                      walletController
                                          .wallets[index].walletType!,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Center(
                      child: ElevatedButton(
                        onPressed: () async {
                          homeController.currentWalletIndex.value = 0;
                          homeController.currentWalletLastIndex.value = 0;

                          walletController.change(null,
                              status: RxStatus.loading());

                          walletController.selectedUpdateWallets.clear();

                          walletController.updateWalletsTextField(_controllers);

                          await walletController.walletUpdate(
                              authController.firebaseUser.value!.uid,
                              walletController.selectedUpdateWallets);

                          walletController.change(null,
                              status: RxStatus.success());
                          print(homeController.currentWalletIndex.value);
                          Get.back();
                        },
                        child: const Text(
                          'Save',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Colors.blueAccent.shade100.withOpacity(0.6),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(32)),
                            minimumSize: Size(
                                MediaQuery.of(context).size.width * 0.8,
                                MediaQuery.of(context).size.height * 0.05)),
                      ),
                    ),
                    const SizedBox()
                  ])));
    });
  }
}
