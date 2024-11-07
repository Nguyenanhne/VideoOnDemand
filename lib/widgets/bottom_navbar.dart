import 'package:du_an_cntt/views/home/home_mobile.dart';
import 'package:du_an_cntt/views/home/home_screen.dart';
import 'package:du_an_cntt/views/home/home_tablet.dart';
import 'package:du_an_cntt/views/login/login_mobile.dart';
import 'package:du_an_cntt/views/login/login_screen.dart';
import 'package:du_an_cntt/views/login/login_tablet.dart';
import 'package:du_an_cntt/views/news_and_hot/news_and_hot_mobile.dart';
import 'package:du_an_cntt/views/news_and_hot/news_and_hot_screen.dart';
import 'package:du_an_cntt/views/news_and_hot/news_and_hot_tablet.dart';
import 'package:du_an_cntt/views/search/search_mobile.dart';
import 'package:du_an_cntt/views/search/search_screen.dart';
import 'package:du_an_cntt/views/search/search_tablet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        bottomNavigationBar: Container(
          child: Container(
            child: const TabBar(
              tabs: [
                Tab(
                  icon: Icon(LineAwesomeIcons.home_solid),
                  text: "Home",
                ),
                Tab(
                  icon: Icon(LineAwesomeIcons.search_solid),
                  text: "Search",
                ),
                Tab(
                  icon: Icon(Icons.photo_library),
                  text: "New & Hot",
                ),
              ],
              indicatorColor: Colors.transparent,
              labelColor: Colors.white,
              unselectedLabelColor: Color(0x38CCCCCC),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            HomeScreen(mobileBody: HomeScreenMobile(), tabletBody: HomeScreenTablet(), webBody: Text("webBody")),
            SearchScreen(mobileBody: SearchScreenMobile(), tabletBody: SearchScreenTablet(), webBody: Text("webBody")),
            NewsAndHotScreen(mobileBody: NewsAndHotScreenMobile(), tabletBody: NewsAndHotScreenTablet(), webBody: Text("webBody"))
          ],
        ),
      )
    );
  }
}
