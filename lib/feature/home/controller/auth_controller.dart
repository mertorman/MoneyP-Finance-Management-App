import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../services/firestoredb.dart';

class AuthController extends GetxService {
  late Rx<User?> firebaseUser;
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;
  RxBool loggedIn = false.obs;
  RxBool walletIsEmpty = false.obs;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  @override
  void onInit() {
    super.onInit();
    firebaseUser = Rx<User?>(auth.currentUser);
    firebaseUser.bindStream(auth.authStateChanges());
    ever(firebaseUser, _initialScreen);
  }

  _initialScreen(User? user) async {
    if (user == null) {
      Get.offAllNamed('/login');
    } else if (user != null && walletIsEmpty.value == true) {
      Get.offAllNamed('/walletonboard');
    } else if (user != null && walletIsEmpty.value == false) {
      walletIsEmpty.value = await FireStoreDb()
          .walletIsEmptyCheck(firebaseUser.value!.uid)
          .then((value) => value);
      if (walletIsEmpty.value) {
        Get.offAllNamed('/walletonboard');
      } else {
        Get.offAllNamed('/home');
      }
    }
  }

  void signIn(String email, password) async {
    // change(null, status: RxStatus.loading());
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
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

  signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      UserCredential user =
          await FirebaseAuth.instance.signInWithCredential(credential);
      createUser(user.user!.uid, user.user!.email!, user.user!.displayName!);
    } catch (e) {
      throw (e);
    }
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
    try {
      await googleSignIn.signOut();
      await auth.signOut();
    } catch (e) {
      print('Başarisiz');
      print(e);
    }
  }

  
}
