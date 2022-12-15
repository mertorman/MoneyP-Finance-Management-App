import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class WalletModel {
  bool? enabled;
  String? icon;
  String? walletType;
  Color? walletColor;
  String? budget;
  String? expenseTotal;
  String? incomesTotal;
  String? walletSymbol;
  String? walletTypeName;
  WalletModel({
    this.enabled,
    this.icon,
    this.walletType,
    this.walletColor,
    this.budget,
    this.expenseTotal,
    this.incomesTotal,
    this.walletSymbol,
    this.walletTypeName,
  });

  WalletModel.fromDocumentSnapshot(DocumentSnapshot data) {
    budget = data["budget"];
    incomesTotal = data["incomesTotal"];
    expenseTotal = data["expenseTotal"];
    walletType = data["walletType"];
    enabled = data["enabled"];
    walletSymbol = data["walletSymbol"];
    walletTypeName = data["walletTypeName"];
  }
}
