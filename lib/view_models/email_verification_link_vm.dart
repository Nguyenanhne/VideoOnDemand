import 'package:du_an_cntt/views/login/sign_in_mobile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:async';
class EmailVerificationLinkViewModel extends ChangeNotifier{
  late final Timer timer;
  Future<void> ontapBackToLoginScreen(BuildContext context) async {
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => SignInScreenMobile()), (route) => false);
  }
  void checkEmailVerifield(){
    timer = Timer.periodic(Duration(seconds: 5), (timer) {
      
    });
  }

}