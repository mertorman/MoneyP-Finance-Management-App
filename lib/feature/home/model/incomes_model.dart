import 'package:cloud_firestore/cloud_firestore.dart';

class IncomesModel {
  String? uid;
  Timestamp? date;
  DateTime? incomesDate;
  int? incomesYear;
  int? incomesMonth;
  int? incomesDay;
  String? type;
  String? incomesTitle;
  String? incomesDescription;
  String? incomesAmount;
  String? incomesIcon;
  String? incomesColor;

  IncomesModel({
    this.type,
    this.incomesTitle,
    this.incomesDescription,
    this.incomesAmount,
    this.incomesColor,
    this.uid,
  });

  IncomesModel.fromDocumentSnapshot(DocumentSnapshot data) {
    uid = data.id;
    date = data["incomesDate"];
    incomesDate = (date?.toDate()) ?? DateTime(0);
    incomesYear = (date?.toDate().year) ?? 0;
    incomesMonth = (date?.toDate().month) ?? 0;
    incomesDay = (date?.toDate().day) ?? 0;
    type = 'Incomes';
    incomesTitle = data["incomesTitle"];
    incomesDescription = data["incomesDesc"];
    incomesAmount = data["incomesAmount"];
    incomesIcon = 'assets/images/incomes.png';
    incomesColor = '4283215696';
  }
}
