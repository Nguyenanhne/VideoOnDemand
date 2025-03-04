import 'package:du_an_cntt/view_models/home_vm.dart';
import 'package:du_an_cntt/view_models/main_poster_vm.dart';
import 'package:du_an_cntt/view_models/my_list_film_vm.dart';
import 'package:du_an_cntt/view_models/search_vm.dart';
import 'package:du_an_cntt/widgets/home/main_poster.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../view_models/showing_film_card_vm.dart';
import '../../widgets/film_card.dart';

class HomeScreenMobile extends StatefulWidget {
  final Future<void> fetchShowing;
  final Future<void> getAllTypes;
  final Future<void> fetchMainPoster;
  const HomeScreenMobile({super.key, required this.fetchShowing, required this.getAllTypes, required this.fetchMainPoster});

  @override
  State<HomeScreenMobile> createState() => _HomeScreenMobileState();
}

class _HomeScreenMobileState extends State<HomeScreenMobile> {
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
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final heightScreen = MediaQuery.of(context).size.height
        - AppBar().preferredSize.height
        - MediaQuery.of(context).padding.top;

    final widthScreen = MediaQuery.of(context).size.width;

    final homeViewModel = Provider.of<HomeViewModel>(context, listen: false);
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: CustomScrollView(
        controller: homeViewModel.homeScrollController,
        slivers: [
          Consumer<HomeViewModel>(
            builder: (context, homeViewModel, child){
              return SliverAppBar (
                automaticallyImplyLeading: false,
                titleSpacing: 0,
                elevation: 100,
                floating: false,
                pinned: true,
                backgroundColor: homeViewModel.appBarColor,
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    color: Colors.transparent,
                  ),
                ),
                title: Container(
                  padding: EdgeInsets.zero,
                  child: Image.asset(
                    "assets/logo.png",
                    height: 50.h,
                    width: 120.w,
                  ),
                ),
                actions: [
                  InkWell(
                    onTap: () {},
                    child: const Icon(
                      LineAwesomeIcons.download_solid,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 15.w),
                  InkWell(
                    onTap: () {},
                    child: const Icon(
                      Icons.search,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 20.w),
                ],
                // Dùng Consumer cho màu AppBar
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(50),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 15.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.white),
                          ),
                          child: Text(
                            "Phim T.hình",
                            style: contentStyle,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 15.w),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.white),
                            ),
                            child: Text(
                              "Phim",
                              style: contentStyle,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 15.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.white),
                          ),
                          child: Text(
                            "Thể loại",
                            style: contentStyle,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
              height: heightScreen * 0.7,
              child: FutureBuilder(
                future: widget.fetchMainPoster,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(),
                    ));
                  }
                  return MainPoster(fontSize: 16, iconSize: 30);
                },
              ),
            ),
          ),
          // FutureBuilder(
          //   future: widget.fetchMainPoster,
          //   builder: (context, snapshot) {
          //     if (snapshot.connectionState == ConnectionState.waiting) {
          //       return SliverToBoxAdapter(child: Center(child: CircularProgressIndicator()));
          //     }
          //     return SliverToBoxAdapter(
          //       child: Container(
          //           padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
          //           height: heightScreen*0.7,
          //           child: MainPoster(fontSize: 16, iconSize: 30)
          //       ),
          //     );
          //   }
          // ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                  child: Text(
                    "Phim đang chiếu",
                    style: titleStyle,
                  ),
                ),
                FutureBuilder(
                  future: widget.fetchShowing,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(),
                      ));
                    }
                    if (snapshot.hasError){
                      return Center(child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Error", style: contentStyle),
                      ));
                    }
                    return SizedBox(
                      height: heightScreen*0.23,
                      child: Consumer<ShowingFilmsCardViewModel>(
                        builder: (context, showingFilmViewModel, child) {
                          final movies = showingFilmViewModel.films;
                          if (movies.isEmpty){
                            return Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                                  child: Text('Hiện tại không có phim nào đang chiếu', style: contentStyle,),
                                )
                            );
                          }
                          return ListView.separated(
                            controller: showingFilmViewModel.showingFilmsController,
                            scrollDirection: Axis.horizontal,
                            separatorBuilder: (context, index) => SizedBox(width: 10.w),
                            itemCount: movies.length + (showingFilmViewModel.isLoading ? 1 : 0),
                            itemBuilder: (context, index) {
                              if (index == movies.length) {
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: Container(
                                    width: widthScreen*0.3,
                                    color: Colors.grey[800],
                                  ),
                                );
                              }
                              final movie = movies[index];
                              return FilmCard(
                                width: 0.3,
                                movie: movie,
                                onTap: () {
                                  showingFilmViewModel.onTap(context, movie);
                                },
                              );
                            },
                          );
                        }
                      ),
                    );
                  }
                )
              ],
            ),
          ),
          FutureBuilder(
            future: widget.getAllTypes,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SliverToBoxAdapter(
                  child: Center(child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(),
                  )),
                );
              } else if (snapshot.hasError) {
                return SliverToBoxAdapter(
                  child: Center(child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Error: ${snapshot.error}', style: contentStyle),
                  )),
                );
              }
              return Consumer<HomeViewModel>(
                builder: (context, homeViewModel, child) {
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      childCount: homeViewModel.types.length,
                          (context, index) {
                        final typeName = homeViewModel.types[index].toString();
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                              child: Text(
                                typeName,
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            homeViewModel.isLoading[typeName] == true
                                ? Center(child: CircularProgressIndicator())
                                : (homeViewModel.filmsTypes[typeName]?.isEmpty ?? true)
                                ? Padding(padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w), child: Text("Hiện tại không có phim ${typeName} nào được chiếu!", style: contentStyle))
                                : SizedBox(
                                height: heightScreen * 0.23,
                                child: ListView.separated(
                                  controller: homeViewModel.scrollControllers[typeName],
                                  scrollDirection: Axis.horizontal,
                                  separatorBuilder: (context, index) => SizedBox(width: 10),
                                  itemCount: (homeViewModel.filmsTypes[typeName]?.length ?? 0) +
                                      ((homeViewModel.isMoreLoading[typeName] ?? false) ? 1 : 0),
                                  itemBuilder: (context, index) {
                                    if (index == homeViewModel.filmsTypes[typeName]!.length) {
                                      return ClipRRect(
                                        borderRadius: BorderRadius.circular(5),
                                        child: Container(
                                          width: widthScreen * 0.3,
                                          color: Colors.grey[800],
                                        ),
                                      );
                                    }else{
                                      final movie = homeViewModel.filmsTypes[typeName]![index];
                                      return FilmCard(
                                        width: 0.3,
                                        movie: movie,
                                        onTap: () {
                                          homeViewModel.onTap(context, movie);
                                        },
                                      );
                                    }
                                  },
                                )
                            ),
                          ],
                        );
                      },
                    ),
                  );
                },
              );
            },
          )
          // FutureBuilder(
          //   future: widget.fetchShowing,
          //   builder: (context, snapshot){
          //     if (snapshot.connectionState == ConnectionState.waiting) {
          //       return SliverToBoxAdapter(
          //         child: Center(child: CircularProgressIndicator()),
          //       );
          //     } else if (snapshot.hasError) {
          //       return SliverToBoxAdapter(
          //         child: Center(child: Text('Error: ${snapshot.error}', style: contentStyle)),
          //       );
          //     }
          //     else{
          //       return  Consumer<ShowingFilmsCardViewModel>(
          //         builder: (context, showingFilmViewModel, child){
          //           final movies = showingFilmViewModel.films;
          //           if (movies.isEmpty) {
          //             return SliverToBoxAdapter(
          //               child: Column(
          //                 crossAxisAlignment: CrossAxisAlignment.start,
          //                 children: [
          //                   Padding(
          //                     padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
          //                     child: Text(
          //                       "Phim đang chiếu",
          //                       style: titleStyle,
          //                     ),
          //                   ),
          //                   Padding(
          //                     padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
          //                     child: Text('Hiện tại không có phim nào đang chiếu',
          //                       style: contentStyle,
          //                     ),
          //                   ),
          //                 ],
          //               ),
          //             );
          //           }
          //           return SliverToBoxAdapter(
          //             child: Column(
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               children: [
          //                 Padding(
          //                   padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
          //                   child: Text(
          //                     "Phim đang chiếu",
          //                     style: titleStyle,
          //                   ),
          //                 ),
          //                 SizedBox(
          //                   height: heightScreen*0.23,
          //                   child: ListView.separated(
          //                     controller: showingFilmViewModel.showingFilmsController,
          //                     scrollDirection: Axis.horizontal,
          //                     separatorBuilder: (context, index) => SizedBox(width: 10.w),
          //                     itemCount: movies.length + (showingFilmViewModel.isLoading ? 1 : 0),
          //                     itemBuilder: (context, index) {
          //                       if (index == movies.length) {
          //                         return ClipRRect(
          //                           borderRadius: BorderRadius.circular(5),
          //                           child: Container(
          //                             width: widthScreen*0.3,
          //                             color: Colors.grey[800],
          //                           ),
          //                         );
          //                       }
          //                       final movie = movies[index];
          //                       return FilmCard(
          //                         width: 0.3,
          //                         movie: movie,
          //                         onTap: () {
          //                           showingFilmViewModel.onTap(context, movie);
          //                         },
          //                       );
          //                     },
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           );
          //         },
          //       );
          //     }
          //   }
          // ),
        ],
      ),
    );
  }
}
