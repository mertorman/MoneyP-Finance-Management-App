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
  

  bool opacity = false;

  // ignore: unused_element
  void _changeOpacity() {
    setState(() {
      opacity = !opacity;
    });
  }

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _changeOpacity();
    });
  }

  void _changeIndicator(int value) {
    _tabController.animateTo(value);
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    ThemeData theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Center(
          child: AnimatedOpacity(
            duration: const Duration(seconds: 1),
            opacity: opacity ? 1 : 0,
            child: Text(
              'MoneyP',
              style: theme.textTheme.headlineMedium!.apply(
                color: const Color(0xff017DA8),
                fontFamily: 'Arial',
              ),
            ),
          ),
        ),
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
                        height: queryData.size.height * 0.4,
                        width: queryData.size.width,
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

class TextStylesOnBoard {
  static TextStyle onBoardTitleText = const TextStyle(
      color: Color.fromRGBO(0, 125, 168, 1), //App Theme Color Here
      fontWeight: FontWeight.w700,
      fontFamily: 'OpenSans',
      fontSize: 25);

  static TextStyle onBoardDescriptionText = const TextStyle(
      color: Color(0xff585858),
      fontWeight: FontWeight.w500,
      fontFamily: 'Poppins',
      fontSize: 18);
}
