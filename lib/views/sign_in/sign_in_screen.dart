import 'package:du_an_cntt/views/responsive.dart';
import 'package:du_an_cntt/view_models/sign_in_vm.dart';
import 'package:du_an_cntt/views/sign_in/sign_in_mobile.dart';
import 'package:du_an_cntt/views/sign_in/sign_in_tablet.dart';
import 'package:du_an_cntt/views/sign_in/sign_in_web.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../forgot_password/forgot_password_tablet.dart';

class SignInScreen extends StatefulWidget {
  SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  void initState() {
    final viewmodel = Provider.of<SignInViewModel>(context, listen: false);
    viewmodel.reset();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(mobileLayout: SignInScreenMobile(), tabletLayout: SignInScreenTablet(), webLayout: SignInScreenWeb());
  }
}