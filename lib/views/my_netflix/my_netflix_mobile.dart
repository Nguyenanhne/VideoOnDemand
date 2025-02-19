import 'package:du_an_cntt/view_models/my_netflix_vm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tap_debouncer/tap_debouncer.dart';

import '../../services/firebase_authentication.dart';
import '../../utils/utils.dart';
import '../../view_models/film_watched_card_vm.dart';
import '../../view_models/my_list_film_vm.dart';
import '../../widgets/film_card.dart';
class MyNetflixScreenMobile extends StatefulWidget {
  final Future<void> fetchMyList;
  final Future<void> fetchFilmWatched;
  const MyNetflixScreenMobile({super.key, required this.fetchMyList, required this.fetchFilmWatched});

  @override
  State<MyNetflixScreenMobile> createState() => _MyNetflixScreenMobileState();
}

class _MyNetflixScreenMobileState extends State<MyNetflixScreenMobile> {
  final contentStyle = TextStyle(
    fontFamily: GoogleFonts.roboto().fontFamily,
    fontSize: 14.sp,
    color: Colors.white
  );
  final titleStyle = TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
  final menuItemStyle = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
  @override
  Widget build(BuildContext context) {
    final heightScreen = MediaQuery.of(context).size.height
        - AppBar().preferredSize.height
        - MediaQuery.of(context).padding.top;

    final firebaseAuth = Auth();

    final widthScreen = MediaQuery.of(context).size.width;

    final viewModel = Provider.of<MyNetflixViewModel>(context);

    final heightBottomSheet = (MediaQuery.of(context).size.height - AppBar().preferredSize.height)/2.5;

    void showBottomSheet(BuildContext context) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return Container(
            height: heightBottomSheet,
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
            decoration: BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
            ),
            child: ListView(
              children: [
                ListTile(
                  leading: Icon(
                    Icons.settings,
                    size: 30,
                    color: Colors.white,
                  ),
                  title: Text(
                    "Quản lý ứng dụng",
                    style: contentStyle.copyWith(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                InkWell(
                  onTap: (){
                    viewModel.accountOnTap(context);
                  },
                  child: ListTile(
                    leading: Icon(
                      LineAwesomeIcons.user,
                      size: 30,
                      color: Colors.white,
                    ),
                    title: Text(
                      "Tài khoản",
                      style: contentStyle.copyWith(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.help,
                    size: 30,
                    color: Colors.white,
                  ),
                  title: Text(
                    "Trợ giúp",
                    style: contentStyle.copyWith(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                InkWell(
                  onTap: (){
                    viewModel.changePWOnTap(context);
                  },
                  child: ListTile(
                    leading: Icon(
                      LineAwesomeIcons.edit_solid,
                      size: 30,
                      color: Colors.white,
                    ),
                    title: Text(
                      "Đổi mật khẩu",
                      style: contentStyle.copyWith(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
                TapDebouncer(
                  onTap: () async {
                    viewModel.onTapBackToLoginScreen(context);
                    await firebaseAuth.signOut();
                  }, // your tap handler moved here
                  builder: (BuildContext context, TapDebouncerFunc? onTap) {
                    return InkWell(
                      onTap: onTap,
                      child: ListTile(
                        leading: Icon(
                          LineAwesomeIcons.sign_out_alt_solid,
                          size: 30,
                          color: Colors.white,
                        ),
                        title: Text(
                          "Đăng xuất",
                          style: contentStyle.copyWith(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      )
                    );
                  },
                ),
              ],
            ),
          );
        },
      );
    };

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 10.w,
        backgroundColor: Colors.black,
        title: Text(
          "Netflix của tôi",
          style: contentStyle.copyWith(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.bold),
        ),
        actions: [
          InkWell(
              child: const Icon(
                Icons.search,
                size: 30,
                color: Colors.white,
              )
          ),
          InkWell(
              onTap: (){
                showBottomSheet(context);
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: const Icon(
                  Icons.menu,
                  size: 30,
                  color: Colors.white,
                ),
              )
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
              child: Text(
                "Danh sách phim xem sau",
                style: titleStyle,
              ),
            ),
          ),
          FutureBuilder(
              future: widget.fetchMyList,
              builder: (context, snapshot){
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SliverToBoxAdapter(
                    child: Center(child: CircularProgressIndicator()),
                  );
                } else if (snapshot.hasError) {
                  return SliverToBoxAdapter(
                    child: Center(child: Text('Error: ${snapshot.error}', style: contentStyle,)),
                  );
                }
                else{
                  return  Consumer<MyListFilmViewModel>(
                    builder: (context, myListFilmsViewModel, child){
                      final films = myListFilmsViewModel.films;
                      if (films.isEmpty) {
                        return SliverToBoxAdapter(
                          child: Center(child: Text("Bạn không có danh sách xem sau nào", style: contentStyle)),
                        );
                      }
                      return SliverToBoxAdapter(
                        child: SizedBox(
                          height: heightScreen*0.23,
                          child: ListView.separated(
                            controller: myListFilmsViewModel.myListScrollController,
                            scrollDirection: Axis.horizontal,
                            separatorBuilder: (context, index) => SizedBox(width: 10.w),
                            itemCount: films.length + (myListFilmsViewModel.isLoading ? 1 : 0),
                            itemBuilder: (context, index) {
                              if (index == films.length) {
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: Container(
                                    width: widthScreen*0.3,
                                    color: Colors.grey[800],
                                  ),
                                );
                              }
                              final movie = films[index];
                              return FilmCard(
                                width: 0.3,
                                movie: movie,
                                onTap: () {
                                  myListFilmsViewModel.onTap(context, movie);
                                },
                              );
                            },                  ),
                        ),
                      );
                    },
                  );
                }
              }
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
              child: Text(
                "Tiếp tục xem",
                style: titleStyle,
              ),
            ),
          ),
          FutureBuilder(
              future: widget.fetchFilmWatched,
              builder: (context, snapshot){
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SliverToBoxAdapter(
                    child: Center(child: CircularProgressIndicator()),
                  );
                } else if (snapshot.hasError) {
                  return SliverToBoxAdapter(
                    child: Center(child: Text('Error: ${snapshot.error}', style: contentStyle,)),
                  );
                }
                else{
                  return  Consumer<FilmWatchedCardViewModel>(
                    builder: (context, filmWatchedViewModel, child){
                      final films = filmWatchedViewModel.films;
                      if (films.isEmpty) {
                        return SliverToBoxAdapter(
                          child: Center(child: Text("Bạn không có danh sách tiếp tục xem nào", style: contentStyle)),
                        );
                      }
                      return SliverToBoxAdapter(
                        child: SizedBox(
                          height: heightScreen*0.23,
                          child: ListView.separated(
                            controller: filmWatchedViewModel.filmWatchedScrollController,
                            scrollDirection: Axis.horizontal,
                            separatorBuilder: (context, index) => SizedBox(width: 10),
                            itemCount: films.length + (filmWatchedViewModel.isLoading ? 1 : 0),
                            itemBuilder: (context, index) {
                              if (index == films.length) {
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: Container(
                                    width: widthScreen*0.3,
                                    color: Colors.grey[800],
                                  ),
                                );
                              }
                              final movie = films[index];
                              return FilmCard(
                                width: 0.3,
                                movie: movie,
                                onTap: () {
                                  filmWatchedViewModel.onTap(context, movie);
                                },
                              );
                            },
                          ),
                        ),
                      );
                    },
                  );
                }
              }
          ),
        ],
      ),
    );
  }
}
