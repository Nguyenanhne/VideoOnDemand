import 'package:du_an_cntt/views/responsive.dart';
import 'package:du_an_cntt/view_models/signup_vm.dart';
import 'package:du_an_cntt/views/sign_up/sign_up_mobile.dart';
import 'package:du_an_cntt/views/sign_up/sign_up_screen_web.dart';
import 'package:du_an_cntt/views/sign_up/sign_up_tablet.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  void initState() {
    super.initState();
    final viewmodel = Provider.of<SignUpViewModel>(context, listen: false);
    viewmodel.reset();
  }
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(mobileLayout: SignUpScreenMobile(), tabletLayout: SignUpScreenTablet(), webLayout: SignUpScreenWeb(),
    );
  }
}