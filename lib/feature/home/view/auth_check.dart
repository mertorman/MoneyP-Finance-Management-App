import 'package:flutter/material.dart';

//firebase
import "package:firebase_auth/firebase_auth.dart";
import 'package:moneyp/feature/home/view/homepage_view.dart';
import 'package:moneyp/feature/login/view/login_view.dart';
class AuthCheck extends StatelessWidget {
  const AuthCheck({super.key});

  @override
  Widget build(BuildContext context) {
    return 
    Scaffold(
      body:   StreamBuilder<User?>(stream:FirebaseAuth.instance.authStateChanges(),
      builder  : (context , snapshot) {
        if(snapshot.hasData) {
          print("here");
          return HomePage();
        }
        else {
          return LoginPage();
        }
      
      })
    );
  }
}