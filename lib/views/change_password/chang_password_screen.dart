import 'package:du_an_cntt/views/responsive.dart';
import 'package:du_an_cntt/views/change_password/chang_password_mobile.dart';
import 'package:du_an_cntt/views/change_password/change_password_tablet.dart';
import 'package:du_an_cntt/views/change_password/change_password_web.dart';
import 'package:flutter/material.dart';

class ChangPasswordScreen extends StatefulWidget {
  const ChangPasswordScreen({super.key});

  @override
  State<ChangPasswordScreen> createState() => _ChangPasswordScreenState();
}

class _ChangPasswordScreenState extends State<ChangPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(mobileLayout: ChangPasswordMobile(), tabletLayout: ChangePasswordTablet(), webLayout: ChangePasswordWeb());
  }
}
