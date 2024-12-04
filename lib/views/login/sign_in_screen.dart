import 'package:du_an_cntt/views/login/sign_in_mobile.dart';
import 'package:du_an_cntt/views/login/sign_in_tablet.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});
  final Widget mobileBody = SignInScreenMobile();
  final Widget tabletBody = SignInScreenTablet();
  final Widget webBody = Text("web");

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints) {
          print(constraints.maxWidth);
          if (constraints.maxWidth < 600) {
            return mobileBody;
          } else if (constraints.maxWidth < 1100) {
            return tabletBody;
          } else {
            return webBody;
          }
        }
    );
  }
}