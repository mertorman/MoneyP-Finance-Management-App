import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import '../../../product/constant/color_settings.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Column info(String info, String value) {
    return Column(
      children: [
        Text(
          info,
          style: TextStyle(
              color: ColorSettings.themeColor.shade200,
              fontSize: 17,
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.w400),
        ),
       const SizedBox(
          height: 8,
        ),
        Text(
          value,
          style: const TextStyle(
              fontSize: 17,
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.w700),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.chevron_left),
              color: Colors.white,
              iconSize: 40),
          centerTitle: true,
          title: const Text(
            'Profile',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 28,
            ),
          ),
          backgroundColor: Colors.blue,
          elevation: 0,
        ),
        backgroundColor: Colors.grey.shade200,
        body: Stack(fit: StackFit.expand, children: [
          FractionallySizedBox(
            alignment: Alignment.topCenter,
            heightFactor: 0.3,
            child: Container(
              decoration: const BoxDecoration(
                  borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(50)),
                  color: Colors.blue),
              child: Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Text('MoneyP',
                      style: GoogleFonts.pacifico(
                          textStyle: TextStyle(
                              color: Colors.white.withOpacity(0.4),
                              fontSize: 30,
                              letterSpacing: 50,
                              fontWeight: FontWeight.w500))),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12, right: 12),
            child: FractionallySizedBox(
              alignment: Alignment.bottomCenter,
              heightFactor: 0.8,
              child: Card(
                color: Colors.white,
                elevation: 3,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32)),
                child: Container(
                  decoration: BoxDecoration(),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Spacer(
                        flex: 2,
                      ),
                      Column(
                        children: [
                          const SizedBox(),
                          const Text(
                            'Mert Orman',
                            style: TextStyle(
                                fontSize: 28, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'mertorman22@gmail.com',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .apply(fontSizeDelta: 8),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 45),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            info('Name', 'Mert'),
                            Container(
                              width: 1,
                              height: 40,
                              color: Colors.grey,
                            ),
                            info('Expenses', '10'),
                            Container(
                              width: 1,
                              height: 40,
                              color: Colors.grey,
                            ),
                            info('Money', '1500'),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Row(
                        children:const [
                          Expanded(child: Divider(thickness: 1)),
                          SizedBox(
                            width: 10,
                          ),
                          Text('Edit Profile'),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(child: Divider(thickness: 1)),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Form(
                            child: Column(
                          children: [
                            TextFormField(
                              decoration: const InputDecoration(
                                  label: Text('Full Name'),
                                  prefixIcon: Icon(LineAwesomeIcons.user)),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                  label: Text('E-Mail'),
                                  prefixIcon:
                                      Icon(LineAwesomeIcons.envelope_1)),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                  label: Text('Password'),
                                  prefixIcon:
                                      Icon(LineAwesomeIcons.fingerprint)),
                            ),
                          ],
                        )),
                      ),
                      const Spacer(),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text("Edit Profile"),
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(32)),
                            primary: ColorSettings.themeColor.shade200,
                            minimumSize: Size(
                                MediaQuery.of(context).size.width * 0.8, 50)),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeIn,
            child: FractionallySizedBox(
              heightFactor: 0.73,
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.height * 0.13,
                        height: MediaQuery.of(context).size.width * 0.26,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: Colors.grey.shade300, width: 4)),
                        child: ClipOval(
                            child: Image.asset(
                          'assets/images/pp3.jpg',
                          fit: BoxFit.cover,
                        )),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.blue.shade200),
                          child: const Icon(LineAwesomeIcons.alternate_pencil),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ]));
  }
}
