import 'package:du_an_cntt/helper/navigator.dart';
import 'package:du_an_cntt/views/my_account/my_account_screen.dart';
import 'package:flutter/material.dart';
class MyNetflixViewModel extends ChangeNotifier{
  void accountOnTap(BuildContext context){
    NavigatorHelper.navigateTo(context, MyAccountScreen());
  }
}