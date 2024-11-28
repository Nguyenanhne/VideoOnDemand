import 'package:du_an_cntt/views/detailed%20movie/detailed_movie_mobile.dart';
import 'package:du_an_cntt/views/home/home_mobile.dart';
import 'package:du_an_cntt/views/home/home_screen.dart';
import 'package:du_an_cntt/views/home/home_tablet.dart';
import 'package:du_an_cntt/views/news_and_hot/news_and_hot_mobile.dart';
import 'package:du_an_cntt/views/news_and_hot/news_and_hot_screen.dart';
import 'package:du_an_cntt/views/news_and_hot/news_and_hot_tablet.dart';
import 'package:du_an_cntt/views/search/search_mobile.dart';
import 'package:du_an_cntt/views/search/search_screen.dart';
import 'package:du_an_cntt/views/search/search_tablet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        bottomNavigationBar: const TabBar(
          tabs: [
            Tab(
              icon: Icon(LineAwesomeIcons.home_solid),
              text: "Trang chủ",
            ),
            Tab(
              icon: Icon(Icons.photo_library),
              text: "Mới & Hot",
            ),
            Tab(
              icon: Icon(Icons.person_3),
              text: "Netflix của tôi",

            )
          ],
          indicatorColor: Colors.transparent,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white30,
        ),
        body: TabBarView(
          children: [
            HomeScreen(mobileBody: HomeScreenMobile(), tabletBody: HomeScreenTablet(), webBody: Text("webBody")),
            NewsAndHotScreen(mobileBody: NewsAndHotScreenMobile(), tabletBody: NewsAndHotScreenTablet(), webBody: Text("webBody")),
            DetailedMovieScreenMobile(),
          ],
        ),
      )
    );
  }
}
