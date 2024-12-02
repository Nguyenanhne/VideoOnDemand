import 'package:du_an_cntt/views/login/sign_in_mobile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import '../views/login/sign_in_screen.dart';
class EmailVerificationLinkViewModel extends ChangeNotifier{
  Timer? timer;
  bool isEmailVerified = false;
  final user = FirebaseAuth.instance.currentUser;

  Future<void> ontapBackToLoginScreen(BuildContext context) async {
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => SignInScreenMobile()), (route) => false);
  }
  void startEmailVerificationTimer(BuildContext context, VoidCallback onVerified) {
    timer = Timer.periodic(Duration(seconds: 3), (timer) async {
      print("Checking email verification status...");
      await FirebaseAuth.instance.currentUser?.reload();
      if (FirebaseAuth.instance.currentUser?.emailVerified ?? false) {
        isEmailVerified = true;
        timer.cancel();
        onVerified();
      }
    });
  }
  void cancelTimer() {
    timer?.cancel();
  }
}