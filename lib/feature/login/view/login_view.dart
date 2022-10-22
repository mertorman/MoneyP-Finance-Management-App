import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:moneyp/product/constant/color_settings.dart';
import 'package:sign_button/sign_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
              right: 20,
              ),
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
                    color: ColorSettings.themeColor.shade100),
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
                    onPressed: () {},
                    child: Text("Forgot Password?"),
                  )
                ],
              ),
              ElevatedButton(
                onPressed: () {},
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
                        buttonType: ButtonType.google,
                        buttonSize:
                            ButtonSize.small, // small(default), medium, large
                        onPressed: () {
                          print('click');
                        }),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
