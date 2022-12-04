import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moneyp/feature/onboard/models/onboard_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moneyp/product/constant/color_settings.dart';

class OnboardPage extends StatefulWidget {
  const OnboardPage({super.key});

  @override
  State<OnboardPage> createState() => _OnboardPageState();
}

class _OnboardPageState extends State<OnboardPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  PageController pageController = PageController();

  bool opacity = false;

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
              style: GoogleFonts.pacifico(
                  textStyle: TextStyle(
                      color: ColorSettings.themeColor,
                      fontSize: 30,
                      letterSpacing: 2,
                      fontWeight: FontWeight.w500)),
            ),
          ),
        ),
        systemOverlayStyle: SystemUiOverlayStyle.light
            .copyWith(statusBarColor: ColorSettings.themeColor.shade200),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: pageController,
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
                        style: TextStylesOnBoard.onBoardTitleText,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        OnBoardModels.onBoardModels[index].desc,
                        style: TextStylesOnBoard.onBoardDescriptionText,
                        textAlign: TextAlign.center,
                      ),
                     
                    ],
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FloatingActionButton(
                  backgroundColor: Colors.white,
                  onPressed: () {
                    pageController.previousPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut);
                  },
                  child: const Icon(Icons.arrow_back,
                      color: Color.fromRGBO(0, 125, 168, 1)),
                ),
                TabPageSelector(
                  controller: _tabController,
                ),
                FloatingActionButton(
                  backgroundColor: Colors.white,
                  onPressed: () {
                    pageController.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut);
                  },
                  child: const Icon(Icons.arrow_forward,
                      color: Color.fromRGBO(0, 125, 168, 1)),
                )
              ],
            ),
            const SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }
}

class TextStylesOnBoard {
  static TextStyle onBoardTitleText = const TextStyle(
      color: Color(0xFF007DA8), //App Theme Color Here
      fontWeight: FontWeight.w700,
      fontFamily: 'OpenSans',
      fontSize: 25);

  static TextStyle onBoardDescriptionText = const TextStyle(
      color: Color(0xff585858),
      fontWeight: FontWeight.w500,
      fontFamily: 'Poppins',
      fontSize: 18);
}
