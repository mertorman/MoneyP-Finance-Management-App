import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kartal/kartal.dart';
import 'package:moneyp/feature/home/controller/auth_controller.dart';
import 'package:moneyp/product/constant/color_settings.dart';

class SignUp extends GetWidget<AuthController> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.chevron_left),
            color: Colors.grey,
            iconSize: 30),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).padding.bottom,
              left: 20,
              right: 20,
              top: MediaQuery.of(context).padding.top),
          child: Column(children: [
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              height: context.isKeyBoardOpen ? 0 : 275,
              child: Image(
                width: MediaQuery.of(context).size.width,
                height: 275,
                image: Svg("assets/images/signUp.svg"),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Sign Up",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: ColorSettings.themeColor.shade100),
                ),
              ],
            ),
            SizedBox(height: 20),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Icon(Icons.mail_lock_outlined),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                        child: TextField(
                      controller: _emailController,
                      decoration: InputDecoration(hintText: "Email"),
                    ))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Icon(Icons.lock_clock_outlined),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                        child: TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(hintText: "Password"),
                    ))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Icon(Icons.lock_clock_outlined),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Expanded(
                        child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(hintText: "Confirm Password"),
                    ))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Icon(Icons.person_outline_outlined),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                        child: TextField(
                      controller: _nameController,
                      decoration: InputDecoration(hintText: "Full name"),
                    ))
                  ],
                ),
                SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    controller.signUp(_emailController.text,
                        _passwordController.text, _nameController.text);
                  },
                  child: Text("Sign Up"),
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32)),
                      primary: ColorSettings.themeColor.shade200,
                      minimumSize: Size(MediaQuery.of(context).size.width, 50)),
                )
              ],
            )
          ]),
        ),
      ),
    );
  }
}
