import 'package:du_an_cntt/views/home/home_mobile.dart';
import 'package:du_an_cntt/views/home/home_tablet.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final Widget mobileBody = HomeScreenMobile();
  final Widget tabletBody = HomeScreenTablet();
  final Widget webBody = HomeScreenTablet();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 500) {
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