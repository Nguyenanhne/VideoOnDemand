import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../views/bottom_navbar.dart';
import '../views/welcome/welcome_screen.dart';

class SplashViewModel extends ChangeNotifier{

  bool checkUser(){
    User? user = FirebaseAuth.instance.currentUser;
    if(user != null){
      return true;
    }
    return false;
  }
  void handleNavigation(BuildContext context) {
    bool isSignIn = checkUser();
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => isSignIn ? BottomNavBar() : WelcomeScreen(),
        ),
      );
    });
  }
}