import 'package:du_an_cntt/helper/navigator.dart';
import 'package:du_an_cntt/views/my_account/my_account_screen.dart';
import 'package:du_an_cntt/views/sign_in/sign_in_screen.dart';
import 'package:du_an_cntt/views/sign_up/sign_up_screen.dart';
import 'package:flutter/material.dart';

import '../views/change_password/chang_password_screen.dart';
import '../views/sign_in/sign_in_mobile.dart';

class MyNetflixViewModel extends ChangeNotifier{
  void accountOnTap(BuildContext context){
    NavigatorHelper.navigateTo(context, MyAccountScreen());
  }
  Future<void> onTapBackToLoginScreen(BuildContext context) async {
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => SignInScreen()), (route) => false);
  }
  void changePWOnTap(BuildContext context){
    NavigatorHelper.navigateTo(context, ChangPasswordScreen());
  }
}