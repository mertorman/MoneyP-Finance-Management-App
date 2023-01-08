import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moneyp/product/constant/color_settings.dart';
import 'package:kartal/kartal.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});

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
          icon: Icon(Icons.chevron_left),
          color: ColorSettings.themeColor.shade200,
          iconSize: 34,
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
              'Forgot Password',
              style: GoogleFonts.poppins(
                  fontSize: 34,
                  fontWeight: FontWeight.w700,
                  color: ColorSettings.themeColor.shade200),
            ),
            Text(
              'Dont worry if you forgot your password! You can easily reset your password by entering your e-mail address in the box below.',
              style: GoogleFonts.poppins(
                  color: Color(0xff565656), letterSpacing: 1, fontSize: 16),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Icon(Icons.mail_lock_outlined),
                SizedBox(
                  width: 12,
                ),
                Expanded(
                    child: TextField(
                  style: GoogleFonts.poppins(fontSize: 16),
                  decoration: InputDecoration(hintText: 'Enter email'),
                ))
              ],
            ),
            const SizedBox(),
            ElevatedButton(
              onPressed: () {},
              child: Text("Submit",
                  style: GoogleFonts.poppins(
                      fontSize: 16, fontWeight: FontWeight.w500)),
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
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
