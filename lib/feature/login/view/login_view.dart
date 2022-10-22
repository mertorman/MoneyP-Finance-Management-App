import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:moneyp/feature/forgot_password/view/forgot_password_view.dart';
import 'package:moneyp/feature/home/view/homepage_view.dart';
import 'package:moneyp/feature/login/view/sign_up_view.dart';
import 'package:moneyp/product/constant/color_settings.dart';
//import 'package:sign_button/sign_button.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).padding.bottom,
              left: 20,
              right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AnimatedContainer(
                duration: Duration(milliseconds: 300),
                height: context.isKeyBoardOpen ? 0 : 275,
                child: Image(
                  width: MediaQuery.of(context).size.width,
                  height: 275,
                  image: Svg("assets/images/login.svg"),
                ),
              ),
              Text(
                "Login",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: ColorSettings.themeColor.shade200),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Icon(Icons.mail_lock_outlined),
                      SizedBox(
                        width: 12,
                      ),
                      Expanded(
                          child: TextField(
                        controller: _usernameController,
                        decoration: InputDecoration(hintText: "Enter username"),
                      ))
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Icon(Icons.lock_outline),
                      SizedBox(
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ForgotPasswordView(),
                          ));
                    },
                    child: Text("Forgot Password?"),
                  )
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  if (_usernameController.text == "admin" &&
                      _passwordController.text == "123") {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage(),
                        ));
                  }
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
                    TextSpan(
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
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignUp(),
                                ));
                          })
                  ],
                )),
              ),
              SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
