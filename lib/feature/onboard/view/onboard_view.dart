import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moneyp/feature/onboard/models/onboard_model.dart';

class OnboardPage extends StatefulWidget {
  const OnboardPage({super.key});

  @override
  State<OnboardPage> createState() => _OnboardPageState();
}

class _OnboardPageState extends State<OnboardPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  OnBoardModels models = OnBoardModels();

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  void _changeIndicator(int value) {
    _tabController.animateTo(value);
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (value) => _changeIndicator(value),
                itemCount: OnBoardModels.onBoardModels.length,
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      SvgPicture.asset(
                        OnBoardModels.onBoardModels[index].getImageUrl,
                        height: queryData.size.height * 0.5,
                      ),
                       Text(
                        OnBoardModels.onBoardModels[index].title,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 50, 59, 108),
                            fontWeight: FontWeight.w700,
                            fontFamily: 'OpenSans',
                            fontSize: 28),
                            textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                       Text(
                         OnBoardModels.onBoardModels[index].desc,
                        style: const TextStyle(
                            color: Color(0xff585858),
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Poppins',
                            fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  );
                },
              ),
            ),
            TabPageSelector(
              controller: _tabController,
            ),
            SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}
