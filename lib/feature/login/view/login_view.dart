import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kartal/kartal.dart';
import 'package:lottie/lottie.dart';
import 'package:moneyp/feature/forgot_password/view/forgot_password_view.dart';
import 'package:moneyp/feature/home/controller/auth_controller.dart';
import 'package:moneyp/feature/login/view/sign_up_view.dart';
import 'package:moneyp/feature/wallet_onboard/controller/wallet_controller.dart';
import 'package:moneyp/product/constant/color_settings.dart';

import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:moneyp/services/firestoredb.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  AuthController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    // return controller.obx(
    //    onLoading: Scaffold(
    //      body: Center(
    //          child:
    //              Lottie.asset('assets/loading.json', width: 300, height: 300)),
    //    ), (state) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: context.isKeyBoardOpen ? 0 : 275,
                child: Image(
                  width: MediaQuery.of(context).size.width,
                  height: 275,
                  image: const Svg("assets/images/login.svg"),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome back",
                    style: GoogleFonts.poppins(
                        fontSize: 34,
                        fontWeight: FontWeight.w700,
                        color: ColorSettings.themeColor.shade200),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text('I am so happy to see you. Please sign in to continue',
                      style: GoogleFonts.poppins(
                          color: Color(0xff565656),
                          letterSpacing: 1,
                          fontSize: 16)),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const Icon(Icons.mail_lock_outlined),
                      const SizedBox(
                        width: 12,
                      ),
                      Expanded(
                          child: TextField(
                        controller: _usernameController,
                        decoration: InputDecoration(hintText: "Enter email"),
                        style: GoogleFonts.poppins(fontSize: 16),
                      ))
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const Icon(Icons.lock_outline),
                      const SizedBox(
                        width: 12,
                      ),
                      Expanded(
                          child: TextField(
                              controller: _passwordController,
                              obscureText: true,
                              decoration:
                                  InputDecoration(hintText: "Enter password"),
                              style: GoogleFonts.poppins(fontSize: 16)))
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Get.to(() => const ForgotPasswordView());
                    },
                    child: Text("Forgot Password?",
                        style: GoogleFonts.poppins(fontSize: 16)),
                  )
                ],
              ),
              ElevatedButton(
                onPressed: () async {
                  controller.signIn(_usernameController.text.trim(),
                      _passwordController.text.trim());
                },
                child: Text("Login",
                    style: GoogleFonts.poppins(
                        fontSize: 16, fontWeight: FontWeight.w500)),
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    primary: ColorSettings.themeColor.shade200,
                    minimumSize: Size(MediaQuery.of(context).size.width, 50)),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                      child: Divider(
                    thickness: 1,
                    color: Colors.black,
                  )),
                  SizedBox(width: 10),
                  Text(
                    "Or",
                    style: GoogleFonts.poppins(fontSize: 16),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                      child: Divider(
                    thickness: 1,
                    color: Colors.black,
                  )),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: SignInButton(
                      Buttons.Google,
                      text: "Sign in with Google",
                      onPressed: () async {
                        await controller.signInWithGoogle();
                      },
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.center,
                child: RichText(
                    text: TextSpan(
                  children: [
                    TextSpan(
                        text: "Don't have an account ? ",
                        style: GoogleFonts.poppins(
                            color: Colors.black54,
                            fontSize: 15,
                            fontWeight: FontWeight.w400)),
                    TextSpan(
                        text: "Register here!",
                        style: Theme.of(context).textTheme.button!.apply(
                            fontWeightDelta: 3,
                            color: ColorSettings.themeColor.shade200),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Get.to(SignUp());
                          })
                  ],
                )),
              ),
              const SizedBox()
            ],
          ),
        ),
      ),
    );
    //}
  }
}
