import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:get/get.dart';
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
                    "Welcome Back",
                    style: TextStyle(
                        fontFamily: 'Rubik',
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: ColorSettings.themeColor.shade200),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text(
                      'I am so happy to see you. Please sign in to continue',
                      style: TextStyle(
                          fontFamily: 'Rubik',
                          color: Color(0xff565656),
                          letterSpacing: 1,
                          fontSize: 17)),
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
                        decoration: InputDecoration(hintText: "Enter password"),
                      ))
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
                    child: const Text("Forgot Password?"),
                  )
                ],
              ),
              ElevatedButton(
                onPressed: () async {
                  controller.signIn(_usernameController.text.trim(),
                      _passwordController.text.trim());
                
                },
                child: Text("Login"),
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32)),
                    primary: ColorSettings.themeColor.shade200,
                    minimumSize: Size(MediaQuery.of(context).size.width, 50)),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: const [
                  Expanded(
                      child: Divider(
                    thickness: 1,
                    color: Colors.black,
                  )),
                  SizedBox(width: 10),
                  Text(
                    "Or",
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
                      text: "Sign up with Google",
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.center,
                child: RichText(
                    text: TextSpan(
                  children: [
                    const TextSpan(
                        text: "Don't have an account ? ",
                        style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w600)),
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
