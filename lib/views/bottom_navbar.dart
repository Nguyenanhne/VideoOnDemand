
import 'package:du_an_cntt/views/home/home_mobile.dart';
import 'package:du_an_cntt/views/home/home_screen.dart';
import 'package:du_an_cntt/views/home/home_tablet.dart';
import 'package:du_an_cntt/views/my_netflix/my_netflix_screen.dart';
import 'package:du_an_cntt/views/search/search_mobile.dart';
import 'package:du_an_cntt/views/search/search_screen.dart';
import 'package:du_an_cntt/views/search/search_tablet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class BottomNavBar extends StatefulWidget {
  BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> with TickerProviderStateMixin{

  late TabController tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 3, vsync: this);

    tabController.addListener(() {
      if (tabController.indexIsChanging) {
        _reloadTabData(tabController.index);
      }
    });
  }
  void _reloadTabData(int tabIndex) {
    print('Reloading data for tab $tabIndex');
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(
        fontFamily: GoogleFonts.roboto().fontFamily,
        fontSize: 25
    );
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
              icon: Icon(Icons.search),
              text: "Tìm kiếm",
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
            SearchScreen(),
            MyNetflixScreen() 
            // DetailedMovieScreen(mobileBody: DetailedMovieScreenMobile(), tabletBody: DetailedMovieScreenTablet(), webBody: Text("webBody")),
          ],
        ),
      )
    );
  }
}
