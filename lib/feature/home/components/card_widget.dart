import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moneyp/feature/home/model/card_widget_model.dart';
import '../../../product/constant/constant.dart';

class TopCardWidget extends StatefulWidget {
  const TopCardWidget({super.key});

  @override
  State<TopCardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<TopCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        color: Colors.white,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.90,
          height: MediaQuery.of(context).size.height * 0.15,
          child: Padding(
            padding:
                const EdgeInsets.only(top: 25, left: 35, right: 35, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(CardModels.cardItems[0].cardTitle,
                        style: cardTitleTextStyle),
                    Row(
                      children: [
                        Text(
                          CardModels.cardItems[0].cardMoneyIcon,
                          style: cardMoneyIconTextStyle,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 7),
                          child: Text(CardModels.cardItems[0].cardTotalMoney,
                              style: cardMoneyTextStyle),
                        )
                      ],
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(CardModels.cardItems[1].cardTitle,
                        style: const TextStyle(
                            color: Colors.red,
                            fontSize: 15,
                            fontWeight: FontWeight.w400)),
                    Row(
                      children: [
                        Text(
                          CardModels.cardItems[1].cardMoneyIcon,
                          style: const TextStyle(
                              color: Colors.red,
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 7),
                          child: Text('1000',
                              style: GoogleFonts.daysOne(
                                  textStyle: const TextStyle(
                                fontSize: 32,
                                color: Colors.red,
                                fontWeight: FontWeight.w500,
                              ))),
                        )
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
