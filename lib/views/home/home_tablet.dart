import 'package:du_an_cntt/utils.dart';
import 'package:du_an_cntt/view_models/up_coming_film_card_vm.dart';
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

import '../../view_models/search_vm.dart';
import '../../widgets/film_card.dart';
class HomeScreenTablet extends StatefulWidget {
  const HomeScreenTablet({super.key});

  @override
  State<HomeScreenTablet> createState() => _HomeScreenTabletState();
}

class _HomeScreenTabletState extends State<HomeScreenTablet> {
  late ScrollController homeScrollController;
  late ScrollController upComingFilmsController;
  late ScrollController randomFilmController;

  late Future<void> fetchUpComing;
  late Future<void> fetchRandomType;

  @override
  void initState() {
    super.initState();
    homeScrollController = ScrollController();

    final upComingFilmsViewModel = Provider.of<UpComingFilmsCardViewModel>(context, listen: false);
    final searchViewModel = Provider.of<SearchViewModel>(context, listen: false);

    fetchRandomType = searchViewModel.searchFilmsByType("Hài hước");

    if (upComingFilmsViewModel.films.isEmpty) {
      fetchUpComing = upComingFilmsViewModel.fetchFilms();
    } else {
      fetchUpComing = Future.value();
    }
    upComingFilmsController = ScrollController()..addListener(upComingFilmsOnScroll);
    randomFilmController = ScrollController()..addListener(randomFilmOnScroll);
  }

  void upComingFilmsOnScroll() {
    final upComingFilmsViewModel = Provider.of<UpComingFilmsCardViewModel>(context, listen: false);
    if (upComingFilmsController.position.pixels == upComingFilmsController.position.maxScrollExtent && !upComingFilmsViewModel.isLoading && upComingFilmsViewModel.hasMore) {
      upComingFilmsViewModel.fetchMoreFilms();
    }
  }
  void randomFilmOnScroll(){
    final searchViewModel = Provider.of<SearchViewModel>(context, listen: false);
    if (randomFilmController.position.pixels == randomFilmController.position.maxScrollExtent && !searchViewModel.isLoading && searchViewModel.hasMore) {
      searchViewModel.searchMoreFilmsByType();
    }
  }

  @override
  void dispose() {
    homeScrollController.dispose();
    upComingFilmsController.dispose();
    randomFilmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final heightScreen = MediaQuery.of(context).size.height
        - AppBar().preferredSize.height
        - MediaQuery.of(context).padding.top;

    final widthScreen = MediaQuery.of(context).size.width;

    final style = TextStyle(
      fontFamily: GoogleFonts.roboto().fontFamily,
      color: Colors.white,
      fontSize: 18
    );

    final homeViewModel = Provider.of<HomeViewModel>(context, listen: false);

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: CustomScrollView(
        controller: homeScrollController
          ..addListener(() {
            final offset = homeScrollController.offset;
            homeViewModel.updateAppBarColor(offset);
          }),
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
                              style: style

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
                              style: style
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
                              style: style
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
                padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 15.h),
                height: heightScreen*0.7,
                child: MainPoster()
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
              child: Text(
                "Phim đang chiếu",
                style: style.copyWith(fontSize: 30),
              ),
            ),
          ),
          FutureBuilder(
              future: fetchUpComing,
              builder: (context, snapshot){
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SliverToBoxAdapter(
                    child: Center(child: CircularProgressIndicator()),
                  );
                } else if (snapshot.hasError) {
                  return SliverToBoxAdapter(
                    child: Center(child: Text('Error: ${snapshot.error}', style: style)),
                  );
                }
                else{
                  return  Consumer<UpComingFilmsCardViewModel>(
                    builder: (context, upComingFilmViewModel, child){
                      final movies = upComingFilmViewModel.films;
                      if (movies.isEmpty) {
                        return SliverToBoxAdapter(
                          child: Center(child: Text('Không có phim', style: style,)),
                        );
                      }
                      return SliverToBoxAdapter(
                        child: SizedBox(
                          height: heightScreen*0.3,
                          child: ListView.separated(
                            controller: upComingFilmsController,
                            scrollDirection: Axis.horizontal,
                            separatorBuilder: (context, index) => SizedBox(width: 10.w),
                            itemCount: movies.length + (upComingFilmViewModel.isLoading ? 1 : 0),
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
                                  upComingFilmViewModel.onTap(context, movie.id);
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
          FutureBuilder(
              future: fetchRandomType,
              builder: (context, snapshot){
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SliverToBoxAdapter(child: CupertinoActivityIndicator());
                }
                return SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                    child: Text(
                      "Hài hước",
                      style: style.copyWith(fontSize: 30),

                  ),
                  ),
                );
              }
          ),
          FutureBuilder(
              future: fetchRandomType,
              builder: (context, snapshot){
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SliverToBoxAdapter(
                    child: Center(child: CupertinoActivityIndicator()),
                  );
                } else if (snapshot.hasError) {
                  return SliverToBoxAdapter(
                    child: Center(child: Text('Error: ${snapshot.error}', style: style,)),
                  );
                }
                else{
                  return  Consumer<SearchViewModel>(
                    builder: (context, searchViewModel, child){
                      final movies = searchViewModel.films;
                      if (movies.isEmpty) {
                        return SliverToBoxAdapter(
                          child: Center(child: Text('Không có phim', style: style)),
                        );
                      }
                      return SliverToBoxAdapter(
                        child: SizedBox(
                          height: heightScreen*0.3,
                          child: ListView.separated(
                            controller: randomFilmController,
                            scrollDirection: Axis.horizontal,
                            separatorBuilder: (context, index) => SizedBox(width: 10.w),
                            itemCount: movies.length + (searchViewModel.isLoading ? 1 : 0),
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
                                  searchViewModel.onTap(context, movie.id);
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
          // SliverToBoxAdapter(
          //   child: SizedBox(
          //     height: heightScreen*0.23,
          //     child: MovieCardWidget(),
          //   ),
          // ),
        ],
      ),
    );
  }
}
