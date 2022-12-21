import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:moneyp/feature/wallet_onboard/controller/wallet_controller.dart';

import '../../../services/firestoredb.dart';

class AuthController extends GetxService {
  late Rx<User?> firebaseUser;
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;
  RxBool loggedIn = false.obs;
  RxBool walletIsEmpty = false.obs;

  @override
  void onInit() async{
   
    super.onInit();
    firebaseUser = Rx<User?>(auth.currentUser);
    firebaseUser.bindStream(auth.authStateChanges());
   
  }

  @override
  void onReady() {
    super.onReady();
    //change(null, status: RxStatus.success());
  //  firebaseUser = Rx<User?>(auth.currentUser);
  //  firebaseUser.bindStream(auth.authStateChanges());
    ever(firebaseUser, _initialScreen);
  }

  _initialScreen(User? user) async{
    if (user == null) {
      Get.offAllNamed('/login');
    } else if (user != null && walletIsEmpty.value == true) {
      Get.offAllNamed('/walletonboard');
    } else if (user != null && walletIsEmpty.value == false) {
      walletIsEmpty.value= await FireStoreDb().walletIsEmptyCheck(firebaseUser.value!.uid).then((value) => value);
      if(walletIsEmpty.value){
         Get.offAllNamed('/walletonboard');
      }else{
      Get.offAllNamed('/home');
      }

    }
  }

  void signIn(String email, password) async {
    // change(null, status: RxStatus.loading());
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      //walletIsEmpty.value= await FireStoreDb().walletIsEmptyCheck(firebaseUser.value!.uid).then((value) => value);
    } catch (e) {
      //change(null, status: RxStatus.success());
      Get.snackbar("About Login", "Login message",
          titleText: const Text('Login Failed.'));
    }
  }

  void createUser(String uid, String email, String name) async {
    await db.collection("users").doc(uid).set({
      'email': email,
      'name': name,
    });
  }

  void signUp(String email, password, name) async {
    try {
      walletIsEmpty.value = true;
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
