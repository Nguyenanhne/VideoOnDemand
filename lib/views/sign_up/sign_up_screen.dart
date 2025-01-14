import 'package:du_an_cntt/responsive.dart';
import 'package:du_an_cntt/views/sign_up/sign_up_mobile.dart';
import 'package:du_an_cntt/views/sign_up/sign_up_screen_web.dart';
import 'package:du_an_cntt/views/sign_up/sign_up_tablet.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(mobileLayout: SignUpScreenMobile(), tabletLayout: SignUpScreenTablet(), webLayout: SignUpScreenWeb(),
    );
  }
}