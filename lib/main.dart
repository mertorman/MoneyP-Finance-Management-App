import 'package:flutter/material.dart';
import 'package:moneyp/feature/home/view/homepage_view.dart';
import 'package:moneyp/feature/login/view/login_view.dart';
import 'package:moneyp/product/constant/color_settings.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) => ResponsiveWrapper.builder(
        child,
        maxWidth: 1200,
        minWidth: 480,
        defaultScale: true,
        breakpoints: [
          ResponsiveBreakpoint.resize(480, name: MOBILE),
          ResponsiveBreakpoint.autoScale(800, name: TABLET),
          ResponsiveBreakpoint.resize(1000, name: DESKTOP),
        ],
      ),
      theme: ThemeData(primarySwatch: ColorSettings.themeColor),
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
