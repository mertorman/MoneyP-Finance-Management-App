import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:moneyp/services/firestoredb.dart';
import 'package:moneyp/feature/home/controller/home_controller.dart';
import '../../../product/constant/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:moneyp/feature/home/view/homepage_view.dart';
import 'package:moneyp/feature/login/view/login_view.dart';

class AuthController extends GetxController {
  late Rx<User?> firebaseUser;
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;
  RxBool isLoading = false.obs;

  @override
  void onReady() {
    super.onReady();
    firebaseUser = Rx<User?>(auth.currentUser);
    firebaseUser.bindStream(auth.userChanges());
    ever(firebaseUser, _initialScreen);
  }

  _initialScreen(User? user) {
    if (user == null) {
      Get.toNamed('/login');
      print('Login Page');
    } else {
      Get.toNamed('/home');
    }
  }

  void signIn(String email, password) async {
    isLoading.value = true;
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("About Login", "Login message",
          titleText: Text('Login Failed.'));
    }
  }

  void createUser(String uid, String email, String name) async {
    await db.collection("users").doc(uid).set({
      'email': email,
      'name': name,
      'money': '0',
      'totalMoney': '0',
      'totalSpent': '0'
    });
  }

  void signUp(String email, password, name) async {
    try {
      UserCredential result = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      createUser(result.user!.uid, email, name);
    } catch (e) {
      Get.snackbar('About SignUp', 'Sign Up Message',
          titleText: Text('Sign Up Failed.'));
    }
  }

  void logOut() async {
    await auth.signOut();
  }
}
