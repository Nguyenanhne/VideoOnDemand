import 'package:du_an_cntt/views/home/home_mobile.dart';
import 'package:du_an_cntt/views/home/home_tablet.dart';
import 'package:du_an_cntt/views/home/home_web.dart';
import 'package:flutter/material.dart';

import '../../responsive.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(mobileLayout: HomeScreenMobile(), tabletLayout: HomeScreenTablet(), webLayout: HomeScreenWeb());
  }
}