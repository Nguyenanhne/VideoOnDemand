import 'package:du_an_cntt/responsive.dart';
import 'package:flutter/material.dart';

import 'my_account_mobile.dart';
import 'my_account_tablet.dart';

class MyAccountScreen extends StatelessWidget {
  MyAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(mobileLayout: MyAccountScreenMobile(), tabletLayout: MyAccountScreenTablet(), webLayout: MyAccountScreenTablet());
  }
}