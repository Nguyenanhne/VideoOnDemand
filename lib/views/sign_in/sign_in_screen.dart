import 'package:du_an_cntt/responsive.dart';
import 'package:du_an_cntt/views/sign_in/sign_in_mobile.dart';
import 'package:du_an_cntt/views/sign_in/sign_in_tablet.dart';
import 'package:du_an_cntt/views/sign_in/sign_in_web.dart';
import 'package:flutter/material.dart';

import '../forgot_password/forgot_password_tablet.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(mobileLayout: SignInScreenMobile(), tabletLayout: SignInScreenTablet(), webLayout: SignInScreenWeb());
  }
}