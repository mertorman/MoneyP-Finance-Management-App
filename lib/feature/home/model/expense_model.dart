import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExpenseModel extends GetxController {
  String? expenseType;
  String? imagePath;
  String? color;
  String? imagePath2;
  bool? isSelected;
  ExpenseModel(
      {this.expenseType,
      this.imagePath,
      this.color,
      this.imagePath2,
      this.isSelected});

  static RxList<ExpenseModel> expenseItems = RxList<ExpenseModel>([
    ExpenseModel(
        expenseType: 'Travel',
        imagePath: 'assets/images/travel.png',
        color: Color(0xFFEA4D35).value.toString(),
        imagePath2: 'assets/images/travel2.png',
        isSelected: false),
    ExpenseModel(
        expenseType: 'Food',
        imagePath: 'assets/images/food.png',
        color: Color(0xFF3474ED).value.toString(),
        imagePath2: 'assets/images/food2.png',
        isSelected: false),
    ExpenseModel(
        expenseType: 'Shopping',
        imagePath: 'assets/images/shopping.png',
        color: Color(0xFFE8D439).value.toString(),
        imagePath2: 'assets/images/shopping2.png',
        isSelected: false),
    ExpenseModel(
        expenseType: 'Billing',
        imagePath: 'assets/images/billing.png',
        color: Color(0xFFFF8FE839).value.toString(),
        imagePath2: 'assets/images/billing2.png',
        isSelected: false),
    ExpenseModel(
        expenseType: 'Other',
        imagePath: 'assets/images/other.png',
        color: Color(0xFFFF39CFE8).value.toString(),
        imagePath2: 'assets/images/other2.png',
        isSelected: false),
  ]);
}
