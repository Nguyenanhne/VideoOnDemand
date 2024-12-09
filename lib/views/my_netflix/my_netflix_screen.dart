import 'package:du_an_cntt/views/sign_up/sign_up_mobile.dart';
import 'package:du_an_cntt/views/sign_up/sign_up_tablet.dart';
import 'package:flutter/material.dart';

import 'my_netflix_mobile.dart';
import 'my_netflix_tablet.dart';

class MyNetflixScreen extends StatelessWidget {
  MyNetflixScreen({super.key});
  final Widget mobileBody = MyNetflixScreenMobile();
  final Widget tabletBody = MyNetflixScreenTablet();
  final Widget webBody = MyNetflixScreenTablet();

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