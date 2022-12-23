import 'package:cloud_firestore/cloud_firestore.dart';

class ListItemModel {
  String? uid;
  Timestamp? date;
  DateTime? expenseDate;
  int? expenseYear;
  int? expenseMonth;
  int? expenseDay;
  String? expenseType;
  String? expenseTitle;
  String? expenseDescription;
  String? expenseTotal;
  String? expenseIcon;
  String? expenseColor;
  ListItemModel(
      {this.expenseType,
      this.expenseTitle,
      this.expenseDescription,
      this.expenseTotal,
      this.expenseIcon,
      this.expenseColor});

  ListItemModel.fromDocumentSnapshot(DocumentSnapshot data) {
    uid = data.id;
    date = data["expenseDate"];
    expenseDate = (date?.toDate()) ?? DateTime(0);
    expenseYear = (date?.toDate().year) ?? 0;
    expenseMonth = (date?.toDate().month) ?? 0;
    expenseDay = (date?.toDate().day) ?? 0;
    expenseType = data["expenseType"];
    expenseTitle = data["expenseTitle"];
    expenseDescription = data["expenseDesc"];
    expenseTotal = data["expenseTotal"];
    expenseIcon = data["expenseIcon"];
    expenseColor = data["expenseColor"];
  }
}
