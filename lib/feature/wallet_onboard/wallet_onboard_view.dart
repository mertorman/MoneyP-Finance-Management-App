import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moneyp/feature/home/controller/auth_controller.dart';
import 'package:moneyp/feature/wallet_onboard/controller/wallet_controller.dart';

import 'package:lottie/lottie.dart';
import 'package:moneyp/product/constant/color_settings.dart';
import 'package:quickalert/quickalert.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class WalletOnboardPage extends StatefulWidget {
  WalletOnboardPage({super.key});

  @override
  State<WalletOnboardPage> createState() => _WalletOnboardPageState();
}

class _WalletOnboardPageState extends State<WalletOnboardPage> {
  WalletController walletController = Get.find();
  AuthController authController = Get.find();
  final List<TextEditingController> _controllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController()
  ];

  int enabledWalletAmount = 0;

  @override
  void dispose() {
    for (TextEditingController c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Welcome",
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
                    'To get started, please create at least 1 wallet in your account. (To activate the wallets you want to add, just click the button next to it.)',
                    style: GoogleFonts.poppins(
                      color: Colors.grey.shade500,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: walletController.wallets.length,
              itemBuilder: (context, index) {
                return Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 25),
                    child: Stack(
                      children: [
                        AnimatedOpacity(
                          duration: const Duration(milliseconds: 300),
                          opacity: walletController.wallets[index].enabled!
                              ? 0.9
                              : 0.65,
                          child: Container(
                            margin: const EdgeInsets.only(top: 13),
                            width: MediaQuery.of(context).size.width * 0.85,
                            height: MediaQuery.of(context).size.height * 0.09,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const SizedBox(),
                                  Container(
                                      width: 40,
                                      height: 40,
                                      child: Image.asset(walletController
                                          .wallets[index].icon!)),
                                  SizedBox(
                                    width: 130,
                                    height: 45,
                                    child: TextField(
                                      controller: _controllers[index],
                                      textAlign: TextAlign.center,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                          contentPadding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          label: Center(
                                              child: Text(
                                            'Enter budget',
                                            style: GoogleFonts.poppins(
                                                fontSize: 16),
                                          )),
                                          hintText: walletController
                                              .wallets[index].walletSymbol,
                                          hintTextDirection: TextDirection.rtl,
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10))),
                                    ),
                                  ),
                                  FlutterSwitch(
                                    width: 76,
                                    height: 30,
                                    valueFontSize: 12.0,
                                    toggleSize: 22.0,
                                    value: walletController
                                        .wallets[index].enabled!,
                                    borderRadius: 10.0,
                                    padding: 4.0,
                                    showOnOff: true,
                                    activeText: 'Disable',
                                    inactiveText: 'Enable',
                                    inactiveColor:
                                        Color.fromARGB(255, 134, 134, 134)
                                            .withOpacity(0.8),
                                    onToggle: (value) {
                                      setState(() {
                                        //Kullanılan kütüphane gereği setState yapmak zorunlu olduğundan GetX kullanılamıyor.

                                        walletController
                                            .wallets[index].enabled = value;

                                        if (value) {
                                          enabledWalletAmount =
                                              enabledWalletAmount + 1;
                                        } else {
                                          enabledWalletAmount =
                                              enabledWalletAmount - 1;
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
                          width: MediaQuery.of(context).size.width * 0.275,
                          height: MediaQuery.of(context).size.height * 0.0255,
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(left: 16),
                          padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 24),
                          decoration: BoxDecoration(
                            color: walletController.wallets[index].walletColor!
                                .withOpacity(0.65),
                            borderRadius: BorderRadius.circular(36),
                          ),
                          child: Text(
                            walletController.wallets[index].walletType!,
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
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  if (enabledWalletAmount != 0) {
                    await walletController.selectedWallet(_controllers);
                    await walletController.addWallets(
                        authController.firebaseUser.value!.uid,
                        walletController.selectedWallets);
                    Get.offAllNamed('/home');
                  } else {
                    QuickAlert.show(
                        context: context,
                        type: QuickAlertType.warning,
                        text:
                            'Please enable at least 1 wallet in your account.');
                  }
                },
                child: Text(
                  'Finished',
                  style: GoogleFonts.poppins(
                      fontSize: 14, fontWeight: FontWeight.w500),
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: ColorSettings.themeColor.shade200,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    minimumSize: Size(MediaQuery.of(context).size.width * 0.84,
                        MediaQuery.of(context).size.height * 0.05)),
              ),
            ),
            const SizedBox()
          ],
        ),
      ),
    );
  }
}
