import 'package:get/get.dart';
import 'package:moneyp/bindings/home_page_binding.dart';
import 'package:moneyp/bindings/login_page_binding.dart';
import 'package:moneyp/feature/home/view/homepage_view.dart';
import 'package:moneyp/feature/login/view/login_view.dart';
import 'package:moneyp/feature/login/view/sign_up_view.dart';
import 'package:moneyp/feature/onboard/view/onboard_view.dart';
import 'package:moneyp/feature/profile/view/profile_page_view.dart';

class AppRoutes {
  static final routes = [
    GetPage(
      name: '/onboard',
      page: () => const OnboardPage(),
    ),
    GetPage(
        name: '/login', page: () => LoginPage(), binding: LoginPageBinding()),
    GetPage(
      name: '/register',
      page: () => SignUp(),
    ),
    GetPage(name: '/home', page: () => const HomePage(), binding: HomePageBinding()),
    GetPage(name: '/profile', page: () => const ProfilePage()),
  ];
}
