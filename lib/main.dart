import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:moneyp/product/constant/color_settings.dart';
import 'package:moneyp/utils/routes.dart';
import 'package:responsive_framework/responsive_framework.dart';
import "package:firebase_core/firebase_core.dart";

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp();
  await Future.delayed(const Duration(seconds: 1));
  FlutterNativeSplash.remove();
  Get.testMode = true;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      builder: (context, child) => ResponsiveWrapper.builder(
        child,
        maxWidth: 1200,
        minWidth: 480,
        defaultScale: true,
        breakpoints: const [
          ResponsiveBreakpoint.resize(480, name: MOBILE),
          ResponsiveBreakpoint.autoScale(800, name: TABLET),
          ResponsiveBreakpoint.resize(1000, name: DESKTOP),
        ],
      ),
      theme: ThemeData(primarySwatch: ColorSettings.themeColor),
      debugShowCheckedModeBanner: false,
      initialRoute: "/login",
      getPages: AppRoutes.routes,
    );
  }
}
