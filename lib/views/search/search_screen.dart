import 'package:du_an_cntt/responsive.dart';
import 'package:du_an_cntt/views/search/search_mobile.dart';
import 'package:du_an_cntt/views/search/search_tablet.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(mobileLayout: SearchScreenMobile(), tabletLayout: SearchScreenTablet(), webLayout: SearchScreenTablet());
  }
}