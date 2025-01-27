import 'package:du_an_cntt/responsive.dart';
import 'package:du_an_cntt/views/forgot_password/forgot_password_mobile.dart';
import 'package:du_an_cntt/views/forgot_password/forgot_password_tablet.dart';
import 'package:du_an_cntt/views/forgot_password/forgot_password_web.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(mobileLayout: ForgotPasswordMobile(), tabletLayout: ForgotPasswordTablet(), webLayout: ForgotPasswordWeb());
  }
}