import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:moneyp/feature/home/controller/auth_controller.dart';
import 'package:moneyp/feature/home/controller/home_controller.dart';
import 'package:moneyp/feature/wallet_onboard/controller/wallet_controller.dart';
import 'package:moneyp/feature/wallet_onboard/model/wallet_model.dart';
import 'package:moneyp/product/constant/color_settings.dart';
import 'package:quickalert/quickalert.dart';

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

  late int enabledWalletAmount2;

  enabledWalletAmount() {
    enabledWalletAmount2 = homeController.wallets.length;
  }

  @override
  void initState() {
    enabledWalletAmount();
    print(enabledWalletAmount2);
    super.initState();
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
            Color.fromARGB(255, 255, 255, 255),
            Color.fromARGB(246, 211, 226, 247),
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
                              style: GoogleFonts.poppins(
                                  fontSize: 34,
                                  fontWeight: FontWeight.w700,
                                  color: ColorSettings.themeColor.shade200),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'You can open and close your wallets and update their budgets whenever you want. (You must have at least 1 open wallet)',
                            style: GoogleFonts.poppins(
                              color: Colors.grey.shade500,
                              fontSize: 16,
                            ),
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
                                                    labelText: 'Enter budget',
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
                                                                .circular(10))),
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
                                              inactiveColor: Color.fromARGB(
                                                      255, 134, 134, 134)
                                                  .withOpacity(0.8),
                                              onToggle: (value) {
                                                setState(() {
                                                  //Kullanılan kütüphane gereği setState yapmak zorunlu olduğundan GetX kullanılamıyor.

                                                  walletController
                                                      .wallets[index]
                                                      .enabled = value;
                                                
                                                  if (value) {
                                                    enabledWalletAmount2 =
                                                        enabledWalletAmount2 +
                                                            1;
                                                  } else {
                                                    enabledWalletAmount2 =
                                                        enabledWalletAmount2 -
                                                            1;
                                                  }
                                                    
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
                                      borderRadius: BorderRadius.circular(10),
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
                          if (enabledWalletAmount2 != 0) {
                            homeController.currentWalletIndex.value = 0;
                            homeController.currentWalletLastIndex.value = 0;

                            walletController.change(null,
                                status: RxStatus.loading());

                            walletController.selectedUpdateWallets.clear();

                            walletController
                                .updateWalletsTextField(_controllers);

                            await walletController.walletUpdate(
                                authController.firebaseUser.value!.uid,
                                walletController.selectedUpdateWallets);
                            homeController.listBindStream();

                            walletController.change(null,
                                status: RxStatus.success());

                            Get.back();
                          } else {
                            QuickAlert.show(
                                context: context,
                                type: QuickAlertType.warning,
                                text:
                                    'Please enable at least 1 wallet in your account.');
                          }
                        },
                        child: Text(
                          'Save',
                          style:
                              GoogleFonts.poppins(fontWeight: FontWeight.bold),
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: ColorSettings.themeColor.shade200,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            minimumSize: Size(
                                MediaQuery.of(context).size.width * 0.84,
                                MediaQuery.of(context).size.height * 0.05)),
                      ),
                    ),
                    const SizedBox()
                  ])));
    });
  }
}
