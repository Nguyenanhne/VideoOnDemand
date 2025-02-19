import 'package:du_an_cntt/views/responsive.dart';
import 'package:du_an_cntt/views/welcome/welcome_mobile.dart';
import 'package:du_an_cntt/views/welcome/welcome_tablet.dart';
import 'package:du_an_cntt/views/welcome/welcome_web.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(mobileLayout: WelcomeScreenMobile(), tabletLayout: WelcomeScreenTablet(), webLayout: WelComeScreenWeb());
  }

}