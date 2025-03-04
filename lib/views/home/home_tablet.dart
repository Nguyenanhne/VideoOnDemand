import 'package:du_an_cntt/utils/utils.dart';
import 'package:du_an_cntt/view_models/showing_film_card_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:du_an_cntt/view_models/home_vm.dart';
import 'package:du_an_cntt/widgets/home/main_poster.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import '../../view_models/main_poster_vm.dart';
import '../../widgets/film_card.dart';

class HomeScreenTablet extends StatefulWidget {
  final Future<void> fetchShowing;
  final Future<void> getAllTypes;
  final Future<void> fetchMainPoster;
  const HomeScreenTablet({super.key, required this.fetchShowing, required this.getAllTypes, required this.fetchMainPoster});

  @override
  State<HomeScreenTablet> createState() => _HomeScreenTabletState();
}

class _HomeScreenTabletState extends State<HomeScreenTablet> {

  // late Future<void> fetchShowing;
  // late Future<void> getAllTypes;
  // late Future<void> fetchFilmsByType;
  // late Future<void> fetchMainPoster;
  //
  // @override
  // void initState() {
  //   super.initState();
  //
  //   SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  //
  //   final showingFilmsViewModel = Provider.of<ShowingFilmsCardViewModel>(context, listen: false);
  //
  //   final mainPosterViewModel = Provider.of<MainPosterViewModel>(context, listen: false);
  //
  //   final homeViewModel = Provider.of<HomeViewModel>(context, listen: false);
  //
  //   fetchShowing = showingFilmsViewModel.fetchFilms();
  //
  //   fetchMainPoster = mainPosterViewModel.fetchRandomFilm();
  //   getAllTypes = homeViewModel.getAllTypes();
  //
  //   getAllTypes.then((_){
  //     fetchFilmsByType = homeViewModel.searchFilmsByAllTypes();
  //   });
  //
  // }
  //
  // @override
  // void dispose() {
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final heightScreen = MediaQuery.of(context).size.height
        - AppBar().preferredSize.height
        - MediaQuery.of(context).padding.top;

    final widthScreen = MediaQuery.of(context).size.width;

    final homeViewModel = Provider.of<HomeViewModel>(context, listen: false);

    final contentStyle = TextStyle(
        fontFamily: GoogleFonts.roboto().fontFamily,
        fontSize: 12.sp,
        color: Colors.white
    );
    final titleStyle = TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    );

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: CustomScrollView(
        controller: homeViewModel.homeScrollController,
        slivers: [
          Consumer<HomeViewModel>(
            builder: (context, provider, child){
              return SliverAppBar (
                titleSpacing: 0,
                elevation: 100,
                floating: false,
                pinned: true,
                backgroundColor: provider.appBarColor,
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
                  ),
                ),
                actions: [
                  InkWell(
                    onTap: () {},
                    child: Icon(
                      LineAwesomeIcons.download_solid,
                      size: iconTabletSize,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 15.w),
                  InkWell(
                    onTap: () {},
                    child: Icon(
                      Icons.search,
                      size: iconTabletSize,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 20.w),
                ],
                // Dùng Consumer cho màu AppBar
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(50.h),
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
                            style: contentStyle
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
                              style: contentStyle
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
                            style: contentStyle
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          FutureBuilder(
              future: widget.fetchMainPoster,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SliverToBoxAdapter(child: Center(child: CircularProgressIndicator()));
                }
                return SliverToBoxAdapter(
                  child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 15.h),
                      height: heightScreen*0.75,
                      child: MainPoster(fontSize: 13.sp, iconSize: 50.0)
                  ),
                );
              }
          ),
          FutureBuilder(
              future: widget.fetchShowing,
              builder: (context, snapshot){
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SliverToBoxAdapter(
                    child: Center(child: CircularProgressIndicator()),
                  );
                } else if (snapshot.hasError) {
                  return SliverToBoxAdapter(
                    child: Center(child: Text('Error: ${snapshot.error}', style: contentStyle)),
                  );
                }
                else{
                  return  Consumer<ShowingFilmsCardViewModel>(
                    builder: (context, showingFilmViewModel, child){
                      final movies = showingFilmViewModel.films;
                      if (movies.isEmpty) {
                        return SliverToBoxAdapter(
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
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                                child: Text('Hiện tại không có phim nào đang chiếu',
                                  style: contentStyle,
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                      return SliverToBoxAdapter(
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
                            SizedBox(
                              height: heightScreen*0.25,
                              child: ListView.separated(
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
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
              }
          ),
          FutureBuilder(
            future: widget.getAllTypes,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SliverToBoxAdapter(
                  child: Center(child: CircularProgressIndicator()),
                );
              } else if (snapshot.hasError) {
                return SliverToBoxAdapter(
                  child: Center(child: Text('Error: ${snapshot.error}', style: contentStyle)),
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
                                style: titleStyle
                              ),
                            ),
                            homeViewModel.isLoading[typeName] == true
                                ? Center(child: CircularProgressIndicator())
                                : (homeViewModel.filmsTypes[typeName]?.isEmpty ?? true)
                                ? Padding(padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w), child: Text("Hiện tại không có phim ${typeName} nào được chiếu!", style: contentStyle))
                                : SizedBox(
                                height: heightScreen * 0.25,
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
        ],
      ),
    );
  }
}
