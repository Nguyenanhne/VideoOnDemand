import 'package:du_an_cntt/views/bottom_navbar.dart';
import 'package:du_an_cntt/views/home/home_mobile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import '../helper/navigator.dart';
import '../services/firebase_authentication.dart';
import '../views/email_verification_link/email_verification_link_mobile.dart';
import '../views/email_verification_link/email_verification_link_screen.dart';
class SignInViewModel extends ChangeNotifier{
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  void loading(bool status) {
    _isLoading = status;
    notifyListeners();
  }

  Future<User?> Login({required BuildContext context, required String email, required String password}) async {
    final user = await Auth().signInUserWithEmailAndPassword(email: email, password: password);
    return user;
  }
}