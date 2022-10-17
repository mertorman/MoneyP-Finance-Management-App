import 'package:flutter/material.dart';
import 'package:moneyp/feature/forgot_password/view/forgot_password_view.dart';
import 'package:moneyp/feature/login/view/login_view.dart';
import 'package:moneyp/feature/onboard/view/onboard_view.dart';
import 'package:moneyp/product/constant/color_settings.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: ColorSettings.themeColor),
      debugShowCheckedModeBanner: false,
      
      home: LoginPage(),
    );
  }
}

