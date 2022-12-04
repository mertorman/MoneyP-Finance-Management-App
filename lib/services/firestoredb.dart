import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moneyp/feature/home/model/incomes_model.dart';
import 'package:moneyp/feature/home/model/list_item_model.dart';
import 'package:moneyp/feature/home/model/user_model.dart';


class FireStoreDb {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<HomeModel> getUser(String uid) async {
    try {
      DocumentSnapshot doc =
          await _firestore.collection('users').doc(uid).get();

      return HomeModel.fromDocumentSnapshot(doc);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Stream<List<ListItemModel>> expenseStream(String uid) {
    return _firestore
        .collection('users')
        .doc(uid)
        .collection('expenses')
        .snapshots()
        .map((QuerySnapshot query) {
      List<ListItemModel> retValue = [];
      query.docs.forEach((element) {
        retValue.add(ListItemModel.fromDocumentSnapshot(element));
      });
      return retValue;
    });
  }

  Stream<List<IncomesModel>> incomesStream(String uid) {
    return _firestore
        .collection('users')
        .doc(uid)
        .collection('incomes')
        .snapshots()
        .map((QuerySnapshot query) {
      List<IncomesModel> retValue = [];
      query.docs.forEach((element) {
        retValue.add(IncomesModel.fromDocumentSnapshot(element));
      });
      return retValue;
    });
  }

  Future<void> addExpense(
      String uid,
      String expenseType,
      String expenseTitle,
      String expenseDesc,
      String expenseTotal,
      String expenseIcon,
      String expenseColor) async {
    try {
      await _firestore.collection('users').doc(uid).collection('expenses').add({
        'expenseType': expenseType,
        'expenseTitle': expenseTitle,
        'expenseDesc': expenseDesc,
        'expenseTotal': expenseTotal,
        'expenseIcon': expenseIcon,
        'expenseColor': expenseColor,
        'expenseDate': FieldValue.serverTimestamp()
      });
    } catch (e) {
      rethrow;
    }
  }
}
