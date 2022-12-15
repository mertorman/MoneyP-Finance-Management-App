import 'package:cloud_firestore/cloud_firestore.dart';

class HomeModel {

  String? name;
  String? email;
  HomeModel(
      { this.name, this.email});

  HomeModel.fromDocumentSnapshot(DocumentSnapshot data) {
  
    name = data["name"];
    email = data["email"];
  }
}
