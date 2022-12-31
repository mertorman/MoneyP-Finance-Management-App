import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttermoji/fluttermoji.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
              topLeft: Radius.circular(14), topRight: Radius.circular(14)),
          gradient: LinearGradient(
              colors: [Color(0xFFdfe9f3), Color(0xFFffffff)],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_outlined),
            onPressed: () {
              Get.back();
            },
            color: Colors.blueAccent.shade100,
          ),
          title: Text(
            'Avatar Customize',
            style: GoogleFonts.poppins(
                color: Colors.blueAccent.shade100,
                fontWeight: FontWeight.w500,
                fontSize: 21),
          ),
          centerTitle: true,
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: Container(
                    width: MediaQuery.of(context).size.height * 0.24,
                    height: MediaQuery.of(context).size.width * 0.38,
                    decoration: BoxDecoration(
                        color: Colors.white70,
                        shape: BoxShape.circle,
                        border:
                            Border.all(color: Colors.blue.shade300, width: 5)),
                    child: FluttermojiCircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 85,
                    ),
                  ),
                ),
                SizedBox(
                  width: min(600, width * 0.85),
                  child: Row(
                    children: [
                      Text(
                        "Customize:",
                        style: GoogleFonts.poppins(
                color: Colors.blueAccent.shade100,
                fontWeight: FontWeight.w500,
                fontSize: 18),
                      ),
                      Spacer(),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 30),
                  child: FluttermojiCustomizer(
                  
                    scaffoldWidth: min(600, width * 0.85),
                    autosave: true,
                    theme: FluttermojiThemeData(
                      labelTextStyle: GoogleFonts.poppins(color: Colors.blueAccent.shade100),
                      iconColor: Colors.blueAccent.shade100,
                      selectedIconColor: Colors.blue,
                      unselectedIconColor: Colors.blue.shade200
                      ,
                      boxDecoration: BoxDecoration(borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(14), topRight: Radius.circular(14))),
                      secondaryBgColor: Colors.transparent,
                      primaryBgColor: Colors.white70
                        ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
