import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moneyp/feature/home/model/incomes_model.dart';
import 'package:moneyp/feature/home/model/list_item_model.dart';
import 'package:moneyp/feature/home/model/user_model.dart';
import 'package:moneyp/feature/wallet_onboard/model/wallet_model.dart';

class FireStoreDb {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
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

  Stream<List<ListItemModel>> expenseStream(
      String uid, String currentWalletDoc) {
    return _firestore
        .collection('users')
        .doc(uid)
        .collection('wallets')
        .doc(currentWalletDoc)
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

  Stream<List<IncomesModel>> incomesStream(
      String uid, String currentWalletDoc) {
    return _firestore
        .collection('users')
        .doc(uid)
        .collection('wallets')
        .doc(currentWalletDoc)
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

  Stream<List<WalletModel>> walletStream(String uid) {
    return _firestore
        .collection('users')
        .doc(uid)
        .collection('wallets')
        .where('enabled', isEqualTo: true)
        .snapshots()
        .map((QuerySnapshot query) {
      List<WalletModel> retValue = [];
      query.docs.forEach((element) {
        retValue.add(WalletModel.fromDocumentSnapshot(element));
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
      String expenseColor,
      String currentWalletDoc) async {
    try {
      await _firestore
          .collection('users')
          .doc(uid)
          .collection('wallets')
          .doc(currentWalletDoc)
          .collection('expenses')
          .add({
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

  Future<void> addIncome(
      String uid,
      String? incomesTitle,
      String? incomesDescription,
      String? incomesAmount,
      String currentWalletDoc) async {
    try {
      await _firestore
          .collection('users')
          .doc(uid)
          .collection('wallets')
          .doc(currentWalletDoc)
          .collection('incomes')
          .add({
        'incomesTitle': incomesTitle,
        'incomesDesc': incomesDescription,
        'incomesAmount': incomesAmount,
        'incomesDate': FieldValue.serverTimestamp()
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> createWallet(
      String uid, List<Map<dynamic, dynamic>> walletDetails) async {
    var batch = _firestore.batch();

    try {
      for (var element in walletDetails) {
        var docRef = _firestore
            .collection('users')
            .doc(uid)
            .collection('wallets')
            .doc(element['walletType']);

        batch.set(docRef, {
          'budget': element['budget'],
          'enabled': element['enabled'],
          'expenseTotal': element['expenseTotal'],
          'incomesTotal': element['incomesTotal'],
          'walletType': element['walletType'],
          'walletTypeName': element['walletTypeName'],
          'walletSymbol': element['walletSymbol']
        });
      }
      batch.commit();
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> walletIsEmptyCheck(String uid) async {
    try {
      var query = await _firestore
          .collection('users')
          .doc(uid)
          .collection('wallets')
          .get();
      if (query.docs.isEmpty) {
        return Future<bool>.value(true);
      } else {
        return Future<bool>.value(false);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> walletUpdate(
      String uid, List<Map<dynamic, dynamic>> walletUpdateDetails) async {
    try {
      var batch = _firestore.batch();
      for (var element in walletUpdateDetails) {
        var docRef = _firestore
            .collection('users')
            .doc(uid)
            .collection('wallets')
            .doc(element['walletType']);

        batch.update(docRef, {
          'budget': element['budget'],
          'enabled': element['enabled'],
        });
      }
      await batch.commit();
    } catch (e) {}
  }

  Future<void> addTransactionWalletUpdate(String uid, String currentWalletDoc,
      String budget, String amount, String transactionType) async {
    try {
      await _firestore
          .collection('users')
          .doc(uid)
          .collection('wallets')
          .doc(currentWalletDoc)
          .update({'budget': budget, transactionType: amount});
    } catch (e) {
      rethrow;
    }
  }

  Future<List<ListItemModel>> statsGetExpenses(
      String uid, String currentWalletDoc) async {
    DateTime currentDate = DateTime.now();
    DateTime queryDate = currentDate.subtract(Duration(days: 30));
    Timestamp timestamp = Timestamp.fromDate(queryDate);

    try {
      QuerySnapshot query = await _firestore
          .collection('users')
          .doc(uid)
          .collection('wallets')
          .doc(currentWalletDoc)
          .collection('expenses')
          .where('expenseDate', isGreaterThanOrEqualTo: timestamp)
          .orderBy('expenseDate', descending: true)
          .get();
      List<ListItemModel> retValue = [];
      query.docs.forEach((element) {
        retValue.add(ListItemModel.fromDocumentSnapshot(element));
      });
      return retValue;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<IncomesModel>> statsGetIncomes(
      String uid, String currentWalletDoc) async {
    DateTime currentDate = DateTime.now();
    DateTime queryDate = currentDate.subtract(Duration(days: 30));
    Timestamp timestamp = Timestamp.fromDate(queryDate);

    try {
      QuerySnapshot query = await _firestore
          .collection('users')
          .doc(uid)
          .collection('wallets')
          .doc(currentWalletDoc)
          .collection('incomes')
          .where('incomesDate', isGreaterThanOrEqualTo: timestamp)
          .orderBy('incomesDate', descending: true)
          .get();
      List<IncomesModel> retValue = [];
      query.docs.forEach((element) {
        retValue.add(IncomesModel.fromDocumentSnapshot(element));
      });
      return retValue;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> transactionDelete(String uid, String currentWalletDoc,
      String transactionType, String transactionUid) async {
    try {
      await _firestore
          .collection('users')
          .doc(uid)
          .collection('wallets')
          .doc(currentWalletDoc)
          .collection(transactionType)
          .doc(transactionUid)
          .delete();
    } catch (e) {}
  }

  
}
