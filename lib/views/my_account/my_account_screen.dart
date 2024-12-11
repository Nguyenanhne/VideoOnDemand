import 'package:du_an_cntt/views/login/sign_in_mobile.dart';
import 'package:du_an_cntt/views/login/sign_in_tablet.dart';
import 'package:flutter/material.dart';

import 'my_account_mobile.dart';
import 'my_account_tablet.dart';

class MyAccountScreen extends StatelessWidget {
  MyAccountScreen({super.key});
  final Widget mobileBody = MyAccountScreenMobile();
  final Widget tabletBody = MyAccountScreenTablet();
  final Widget webBody = MyAccountScreenTablet();

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