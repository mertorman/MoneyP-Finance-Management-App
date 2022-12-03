import 'package:cloud_firestore/cloud_firestore.dart';

class HomeModel {
  String? money;
  String? totalMoney;
  String? totalSpent;
  String? name;
  String? email;
  HomeModel(
      {this.money, this.totalMoney, this.totalSpent, this.name, this.email});

  HomeModel.fromDocumentSnapshot(DocumentSnapshot data) {
    money = data["money"];
    totalMoney = data["totalMoney"];
    totalSpent = data["totalSpent"];
    name = data["name"];
    email = data["email"];
  }
}
