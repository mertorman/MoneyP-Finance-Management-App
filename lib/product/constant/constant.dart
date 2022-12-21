import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppConstants {
  static const dovizApiUrl =
      'https://api.genelpara.com/embed/para-birimleri.json';
}

const cardTitleColor = Colors.green;
const cardMoneyColor = Colors.green;
var cardMoneyIconColor = Colors.green;

var cardTitleTextStyle = const TextStyle(
    color: cardTitleColor, fontSize: 15, fontWeight: FontWeight.w400);

var cardMoneyTextStyle = GoogleFonts.daysOne(
    textStyle: const TextStyle(
  fontSize: 32,
  color: cardMoneyColor,
  fontWeight: FontWeight.w500,
));

var cardMoneyIconTextStyle = TextStyle(
    color: cardMoneyIconColor, fontSize: 22, fontWeight: FontWeight.bold);

var cardSpendMoneyTextStyle = GoogleFonts.daysOne(
    textStyle: const TextStyle(
        fontSize: 18, color: Color(0xFF40565a), fontWeight: FontWeight.w500));

var cardSpenMoneyIconTextStyle = TextStyle(
    color: Colors.grey.shade600, fontSize: 17, fontWeight: FontWeight.bold);
