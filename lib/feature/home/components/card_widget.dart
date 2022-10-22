import 'package:flutter/material.dart';
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
        elevation: 3,
        shadowColor: Colors.grey.shade400,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        color: Colors.grey.shade50,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.85,
          height: MediaQuery.of(context).size.height * 0.16,
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
                  mainAxisAlignment: MainAxisAlignment.center,
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
                        Text(CardModels.cardItems[0].cardMoneyIcon,
                            style: cardSpenMoneyIconTextStyle),
                        Padding(
                          padding: const EdgeInsets.only(top: 7),
                          child: Text(CardModels.cardItems[0].cardSpendMoney,
                              style: cardSpendMoneyTextStyle),
                        )
                      ],
                    ),
                    const SizedBox(),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
