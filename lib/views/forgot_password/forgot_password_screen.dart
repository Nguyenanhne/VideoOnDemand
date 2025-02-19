import 'package:du_an_cntt/views/responsive.dart';
import 'package:du_an_cntt/views/forgot_password/forgot_password_mobile.dart';
import 'package:du_an_cntt/views/forgot_password/forgot_password_tablet.dart';
import 'package:du_an_cntt/views/forgot_password/forgot_password_web.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../view_models/forgot_password_vm.dart';

class ForgotPasswordScreen extends StatefulWidget {
  ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  @override
  void initState() {
    super.initState();
    final viewmodel = Provider.of<ForgotPasswordViewModel>(context, listen: false);
    viewmodel.reset();
  }
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(mobileLayout: ForgotPasswordMobile(), tabletLayout: ForgotPasswordTablet(), webLayout: ForgotPasswordWeb());
  }
}