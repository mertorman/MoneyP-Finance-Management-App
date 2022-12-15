import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:moneyp/feature/wallet_onboard/controller/wallet_controller.dart';

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
    } else {}
  }

  void signIn(String email, password) async {
 
    isLoading.value = true;
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
         WalletController walletController = Get.find();
bool walletCheck =await walletController.walletCheck(firebaseUser.value!.uid);
                  if (walletCheck) {
                    Get.offAllNamed('/walletonboard');
                  } else {
                    Get.offAllNamed('/home');
                  }
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("About Login", "Login message",
          titleText: const Text('Login Failed.'));
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
          titleText: const Text('Sign Up Failed.'));
    }
  }

  void logOut() async {
    await auth.signOut();
  }
}
