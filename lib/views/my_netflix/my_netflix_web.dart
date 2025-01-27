import 'package:flutter/material.dart';
import 'package:du_an_cntt/view_models/my_netflix_vm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tap_debouncer/tap_debouncer.dart';

import '../../services/firebase_authentication.dart';
import '../../utils.dart';
import '../../view_models/film_watched_card_vm.dart';
import '../../view_models/my_list_film_vm.dart';
import '../../widgets/film_card.dart';

class MyNetflixScreenWeb extends StatefulWidget {
  const MyNetflixScreenWeb({super.key});

  @override
  State<MyNetflixScreenWeb> createState() => _MyNetflixScreenWebState();
}

class _MyNetflixScreenWebState extends State<MyNetflixScreenWeb> {
  late Future<void> fetchMyList;
  late Future<void> fetchFilmWatched;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final myListFilmsViewModel = Provider.of<MyListFilmViewModel>(context, listen: false);
    final myFilmWatched = Provider.of<FilmWatchedCardViewModel>(context, listen: false);

    fetchMyList = myListFilmsViewModel.fetchMyList();
    fetchFilmWatched = myFilmWatched.fetchMyListFilmWatched();
  }
  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final heightScreen = MediaQuery.of(context).size.height
        - AppBar().preferredSize.height
        - MediaQuery.of(context).padding.top;

    final firebaseAuth = Auth();

    final widthScreen = MediaQuery.of(context).size.width;

    final contentStyle = TextStyle(
        fontFamily: GoogleFonts.roboto().fontFamily,
        fontSize: 20,
        color: Colors.white
    );

    final leadingTitle = TextStyle(
        fontSize: 35,
        fontFamily: GoogleFonts.roboto().fontFamily,
        color: Colors.white,
        fontWeight: FontWeight.bold
    );

    final titleStyle = TextStyle(
      fontSize: 25,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    );

    final viewModel = Provider.of<MyNetflixViewModel>(context);

    final heightBottomSheet = (MediaQuery.of(context).size.height - AppBar().preferredSize.height)/2;

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
                InkWell(
                  onTap: (){},
                  child: ListTile(
                    leading: Icon(
                      LineAwesomeIcons.edit_solid,
                      size: iconTabletSize,
                      color: Colors.white,
                    ),
                    title: Text(
                      "Quản lý hồ sơ",
                      style: titleStyle,
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.settings,
                    size: iconTabletSize,
                    color: Colors.white,
                  ),
                  title: Text(
                    "Quản lý ứng dụng",
                    style: titleStyle,
                  ),
                ),
                InkWell(
                  onTap: (){
                    viewModel.accountOnTap(context);
                  },
                  child: ListTile(
                    leading: Icon(
                      LineAwesomeIcons.user,
                      size: iconTabletSize,
                      color: Colors.white,
                    ),
                    title: Text(
                      "Tài khoản",
                      style: titleStyle,
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.help,
                    size: iconTabletSize,
                    color: Colors.white,
                  ),
                  title: Text(
                    "Trợ giúp",
                    style: titleStyle,
                  ),
                ),
                TapDebouncer(
                  onTap: () async {
                    viewModel.ontapBackToLoginScreen(context);
                    await firebaseAuth.signOut();
                  }, // your tap handler moved here
                  builder: (BuildContext context, TapDebouncerFunc? onTap) {
                    return InkWell(
                        onTap: onTap,
                        child: ListTile(
                          leading: Icon(
                            LineAwesomeIcons.sign_out_alt_solid,
                            size: iconTabletSize,
                            color: Colors.white,
                          ),
                          title: Text(
                            "Đăng xuất",
                            style: titleStyle,

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
    }
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 10.w,
        backgroundColor: Colors.black,
        leading: InkWell(
          child: Icon(
            Icons.arrow_back,
            color: Color(colorAppbarIcon),
            size: iconTabletSize,
          ),
        ),
        title: Text(
          "Netflix của tôi",
          style: leadingTitle,
        ),
        actions: [
          InkWell(
              child: const Icon(
                Icons.search,
                size: iconTabletSize,
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
                  size: iconTabletSize,
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
          // FutureBuilder(
          //     future: fetchMyList,
          //     builder: (context, snapshot){
          //       if (snapshot.connectionState == ConnectionState.waiting) {
          //         return SliverToBoxAdapter(
          //           child: Center(child: CircularProgressIndicator()),
          //         );
          //       } else if (snapshot.hasError) {
          //         return SliverToBoxAdapter(
          //           child: Center(child: Text('Error: ${snapshot.error}')),
          //         );
          //       }
          //       else{
          //         return  Consumer<MyListFilmViewModel>(
          //           builder: (context, myListFilmsViewModel, child){
          //             final movies = myListFilmsViewModel.films;
          //             if (movies.isEmpty) {
          //               return SliverToBoxAdapter(
          //                 child: Center(child: Text("Bạn không có danh sách xem sau nào", style: contentStyle)),
          //               );
          //             }
          //             return SliverToBoxAdapter(
          //               child: SizedBox(
          //                 height: heightScreen*0.23,
          //                 child: ListView.separated(
          //                   controller: myListFilmController,
          //                   scrollDirection: Axis.horizontal,
          //                   separatorBuilder: (context, index) => SizedBox(width: 10.w),
          //                   itemCount: movies.length + (myListFilmsViewModel.isLoading ? 1 : 0),
          //                   itemBuilder: (context, index) {
          //                     if (index == movies.length) {
          //                       return ClipRRect(
          //                         borderRadius: BorderRadius.circular(5),
          //                         child: Container(
          //                           width: widthScreen*0.3,
          //                           color: Colors.grey[800],
          //                         ),
          //                       );
          //                     }
          //                     final movie = movies[index];
          //                     return FilmCard(
          //                       movie: movie,
          //                       onTap: () {
          //                         myListFilmsViewModel.onTap(context, movie.id);
          //                       },
          //                     );
          //                   },                  ),
          //               ),
          //             );
          //           },
          //         );
          //       }
          //     }
          // ),
          FutureBuilder(
              future: fetchMyList,
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
                          height: heightScreen*0.25,
                          child: ListView.separated(
                            controller: myListFilmsViewModel.myListScrollController,
                            scrollDirection: Axis.horizontal,
                            separatorBuilder: (context, index) => SizedBox(width: 5.w),
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
                                width: 0.15,
                                movie: movie,
                                onTap: () {
                                  myListFilmsViewModel.onTap(context, movie.id);
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
              future: fetchFilmWatched,
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
                          height: heightScreen*0.3,
                          child: ListView.separated(
                            controller: filmWatchedViewModel.filmWatchedScrollController,
                            scrollDirection: Axis.horizontal,
                            separatorBuilder: (context, index) => SizedBox(width: 5.w),
                            itemCount: films.length + (filmWatchedViewModel.isLoading ? 1 : 0),
                            itemBuilder: (context, index) {
                              if (index == films.length) {
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: Container(
                                    width: widthScreen*0.15,
                                    color: Colors.grey[800],
                                  ),
                                );
                              }
                              final movie = films[index];
                              return FilmCard(
                                width: 0.15,
                                movie: movie,
                                onTap: () {
                                  filmWatchedViewModel.onTap(context, movie.id);
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
