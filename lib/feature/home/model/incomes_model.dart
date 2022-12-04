import 'package:cloud_firestore/cloud_firestore.dart';

class IncomesModel {
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

  IncomesModel(
      {this.type,
      this.incomesTitle,
      this.incomesDescription,
      this.incomesAmount,
      
      this.incomesColor});

  IncomesModel.fromDocumentSnapshot(DocumentSnapshot data) {
    date = data["incomesDate"];
    incomesDate = (date?.toDate()) ?? DateTime(0);
    incomesYear = (date?.toDate().year) ?? 0;
    incomesMonth = (date?.toDate().month) ?? 0;
    incomesDay = (date?.toDate().day) ?? 0;
    type = data["incomesType"];
    incomesTitle = data["incomesTitle"];
    incomesDescription = data["incomesDesc"];
    incomesAmount = data["incomesAmount"];
    incomesIcon = 'assets/images/incomes.png';
    incomesColor = '4283215696';
  }
}
