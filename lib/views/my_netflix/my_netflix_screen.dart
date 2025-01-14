import 'package:du_an_cntt/responsive.dart';
import 'package:du_an_cntt/views/sign_up/sign_up_mobile.dart';
import 'package:du_an_cntt/views/sign_up/sign_up_tablet.dart';
import 'package:flutter/material.dart';

import 'my_netflix_mobile.dart';
import 'my_netflix_tablet.dart';

class MyNetflixScreen extends StatelessWidget {
  MyNetflixScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(mobileLayout: MyNetflixScreenMobile(), webLayout: MyNetflixScreenTablet(), tabletLayout: MyNetflixScreenTablet(),);
  }
}