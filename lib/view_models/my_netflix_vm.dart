import 'package:du_an_cntt/helper/navigator.dart';
import 'package:du_an_cntt/views/my_account/my_account_screen.dart';
import 'package:flutter/material.dart';

import '../views/sign_in/sign_in_mobile.dart';

class MyNetflixViewModel extends ChangeNotifier{
  void accountOnTap(BuildContext context){
    NavigatorHelper.navigateTo(context, MyAccountScreen());
  }
  Future<void> ontapBackToLoginScreen(BuildContext context) async {
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => SignInScreenMobile()), (route) => false);
  }
}