import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:moneyp/product/constant/color_settings.dart';
import 'package:kartal/kartal.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.light
            .copyWith(statusBarColor: ColorSettings.themeColor.shade200),
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new_outlined),
          color: Colors.black,
        ),
      ),
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).padding.bottom,
            left: 20,
            right: 20,
            top: MediaQuery.of(context).padding.top),
        child: Column(
          mainAxisAlignment: context.isKeyBoardOpen
              ? MainAxisAlignment.spaceEvenly
              : MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: context.isKeyBoardOpen ? 0 : 275,
              child: Image(
                image: const Svg('assets/images/forgot_password.svg'),
                width: MediaQuery.of(context).size.width,
                height: 275,
                fit: BoxFit.contain,
              ),
            ),
            Text(
              'Forgot\nPassword',
              style: TextStyle(
                  color: ColorSettings.themeColor.shade200,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
            const Text(
              'Dont worry if you forgot your password! You can easily reset your password by entering your e-mail address in the box below.',
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                  fontWeight: FontWeight.w600),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: const [
                Icon(Icons.mail_lock_outlined),
                SizedBox(
                  width: 12,
                ),
                Expanded(
                    child: TextField(
                  decoration: InputDecoration(hintText: 'Enter e-mail'),
                ))
              ],
            ),
            const SizedBox(),
            ElevatedButton(
              onPressed: () {},
              child: Text("Submit"),
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32)),
                  primary: ColorSettings.themeColor.shade200,
                  minimumSize: Size(MediaQuery.of(context).size.width, 50)),
            ),
            const SizedBox()
          ],
        ),
      ),
    );
  }
}
