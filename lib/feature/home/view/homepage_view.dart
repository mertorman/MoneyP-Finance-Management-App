import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moneyp/product/constant/color_settings.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(),
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 80,
        centerTitle: true,
        titleTextStyle: Theme.of(context).textTheme.headlineMedium,
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.all(20),
          child: Builder(
            builder: (context) => IconButton(
              icon: const Icon(
                Icons.menu_outlined,
                color: Colors.grey,
              ),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
        ),
        elevation: 0,
        title: Text(
          'Dashboard',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: ColorSettings.themeColor.shade200,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage('assets/images/pp3.jpg'),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            Center(
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32)),
                color: Colors.grey.shade50,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  height: MediaQuery.of(context).size.height * 0.16,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 25, left: 35, right: 35, bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Balance',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400),
                            ),
                            Row(
                              children: [
                                Text('₺',
                                    style: TextStyle(
                                        color: Colors.grey.shade600,
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold)),
                                Padding(
                                  padding: const EdgeInsets.only(top: 7),
                                  child: Text('2,400',
                                      style: GoogleFonts.daysOne(
                                          textStyle: const TextStyle(
                                        fontSize: 32,
                                        color: Color(0xFF40565a),
                                        fontWeight: FontWeight.w500,
                                      ))),
                                )
                              ],
                            )
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                      color: Colors.red.shade100,
                                      borderRadius: BorderRadius.circular(15)),
                                  child: const Icon(
                                    Icons.arrow_upward_outlined,
                                    color: Colors.red,
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text('₺',
                                    style: TextStyle(
                                        color: Colors.grey.shade600,
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold)),
                                Padding(
                                  padding: const EdgeInsets.only(top: 7),
                                  child: Text('3,000',
                                      style: GoogleFonts.daysOne(
                                          textStyle: const TextStyle(
                                              fontSize: 18,
                                              color: Color(0xFF40565a),
                                              fontWeight: FontWeight.w500))),
                                )
                              ],
                            ),
                            const SizedBox(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                      color: Colors.green.shade100,
                                      borderRadius: BorderRadius.circular(15)),
                                  child: const Icon(
                                    Icons.arrow_downward_outlined,
                                    color: Colors.green,
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text('₺',
                                    style: TextStyle(
                                        color: Colors.grey.shade600,
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold)),
                                Padding(
                                  padding: const EdgeInsets.only(top: 7),
                                  child: Text('600',
                                      style: GoogleFonts.daysOne(
                                          textStyle: const TextStyle(
                                              fontSize: 18,
                                              color: Color(0xFF40565a),
                                              fontWeight: FontWeight.w500))),
                                )
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Cards",
                    style: GoogleFonts.daysOne(
                      textStyle: const TextStyle(
                          color: Color(0xFF40565a),
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ))
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              height: 165,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return const CardWidget();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CardWidget extends StatelessWidget {
  const CardWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      color: Colors.indigoAccent.shade200,
      child: Container(
        width: 140,
        height: 165,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'VISA',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 35,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('₺',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w500)),
                  Padding(
                    padding: const EdgeInsets.only(top: 7),
                    child: Text('600',
                        style: GoogleFonts.daysOne(
                            textStyle: const TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.w500))),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
