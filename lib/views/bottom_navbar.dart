import 'package:du_an_cntt/views/detailed%20movie/detailed_movie_mobile.dart';
import 'package:du_an_cntt/views/detailed%20movie/detailed_movie_screen.dart';
import 'package:du_an_cntt/views/detailed%20movie/detailed_movie_tablet.dart';
import 'package:du_an_cntt/views/home/home_mobile.dart';
import 'package:du_an_cntt/views/home/home_screen.dart';
import 'package:du_an_cntt/views/home/home_tablet.dart';
import 'package:du_an_cntt/views/my_netflix/my_netflix_screen.dart';
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
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class BottomNavBar extends StatelessWidget {
  BottomNavBar({super.key});
  final style = TextStyle(
    fontSize: 10.sp,
    fontFamily: GoogleFonts.roboto().fontFamily
  );
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        bottomNavigationBar: TabBar(
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
          labelStyle: style,
          labelPadding: EdgeInsets.zero,
          padding: EdgeInsets.zero,
          dividerColor: Colors.transparent,
        ),
        body: TabBarView(
          children: [
            HomeScreen(),
            NewsAndHotScreen(mobileBody: NewsAndHotScreenMobile(), tabletBody: NewsAndHotScreenTablet(), webBody: Text("webBody")),
            MyNetflixScreen()
            // DetailedMovieScreen(mobileBody: DetailedMovieScreenMobile(), tabletBody: DetailedMovieScreenTablet(), webBody: Text("webBody")),
          ],
        ),
      )
    );
  }
}
