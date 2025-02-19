import 'package:du_an_cntt/views/sign_in/sign_in_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import '../views/sign_in/sign_in_mobile.dart';

class EmailVerificationLinkViewModel extends ChangeNotifier{
  Timer? _timer;
  Timer? _countdown;
  int _remainingTime = 30;

  bool _isEmailVerified = false;
  bool _isTimeUp = false;

  Timer? get timer => _timer;
  Timer? get countdown => _countdown;
  bool get isEmailVerified => _isEmailVerified;
  bool get isTimeUp => _isTimeUp;
  int get remainingTime => _remainingTime;

  final user = FirebaseAuth.instance.currentUser;

  Future<void> onTapBackToLoginScreen(BuildContext context) async {
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => SignInScreen()), (route) => false);
  }
  void startEmailVerificationTimer(BuildContext context, VoidCallback onVerified) {
    _timer = Timer.periodic(Duration(seconds: 3), (timer) async {
      print("Checking email verification status...");
      await FirebaseAuth.instance.currentUser?.reload();
      if (FirebaseAuth.instance.currentUser?.emailVerified ?? false) {
        _isEmailVerified = true;
        timer.cancel();
        onVerified();
      }
    });
  }
  void startCountdown() {
    _countdown = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
          _remainingTime--;
          notifyListeners();
        } else {
          _isTimeUp = true;
          _countdown?.cancel();
          print("Countdown finished!");
          notifyListeners();
        }
    });
  }
  void resetCountdown() {
    _remainingTime = 30;
    _isTimeUp = false;
    _timer?.cancel();
    startCountdown();
    notifyListeners();
  }

  void cancelTimer() {
    countdown?.cancel();
    timer?.cancel();
  }

}