import 'package:du_an_cntt/utils.dart';
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
import '../../view_models/showing_film_card_vm.dart';
import '../../widgets/film_card.dart';
class HomeScreenWeb extends StatefulWidget {
  const HomeScreenWeb({super.key});

  @override
  State<HomeScreenWeb> createState() => _HomeScreenWebState();
}

class _HomeScreenWebState extends State<HomeScreenWeb> {
  late ScrollController homeScrollController;
  late ScrollController upComingFilmsController;
  late ScrollController randomFilmController;

  late Future<void> fetchUpComing;
  late Future<void> fetchRandomType;

  @override
  void initState() {
    super.initState();
    homeScrollController = ScrollController();

    final upComingFilmsViewModel = Provider.of<ShowingFilmsCardViewModel>(context, listen: false);
    final searchViewModel = Provider.of<SearchViewModel>(context, listen: false);

    // fetchRandomType = searchViewModel.searchFilmsByTypeAndYear("Hài hước");

    if (upComingFilmsViewModel.films.isEmpty) {
      fetchUpComing = upComingFilmsViewModel.fetchFilms();
    } else {
      fetchUpComing = Future.value();
    }
    upComingFilmsController = ScrollController()..addListener(upComingFilmsOnScroll);
    randomFilmController = ScrollController()..addListener(randomFilmOnScroll);
  }

  void upComingFilmsOnScroll() {
    final upComingFilmsViewModel = Provider.of<ShowingFilmsCardViewModel>(context, listen: false);
    if (upComingFilmsController.position.pixels == upComingFilmsController.position.maxScrollExtent && !upComingFilmsViewModel.isLoading && upComingFilmsViewModel.hasMore) {
      upComingFilmsViewModel.fetchMoreFilms();
    }
  }
  void randomFilmOnScroll(){
    final searchViewModel = Provider.of<SearchViewModel>(context, listen: false);
    if (randomFilmController.position.pixels == randomFilmController.position.maxScrollExtent && !searchViewModel.isLoading && searchViewModel.hasMore) {
      searchViewModel.searchMoreFilmsByTypeAndYear();
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
      appBar: AppBar (
        titleSpacing: 0,
        elevation: 100,
        backgroundColor: Colors.transparent,
        flexibleSpace: FlexibleSpaceBar(
          background: Container(
            color: Colors.transparent,
          ),
        ),
        title: Container(
          padding: EdgeInsets.zero,
          child: Image.asset(
            "assets/logo.png",
            width: 50.w,
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
      ),
      body: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: MainPoster(fontSize: 16, iconSize: 30)
            ),
          ),
          Expanded(
            flex: 3,
            child: CustomScrollView(
              controller: homeScrollController
                ..addListener(() {
                  final offset = homeScrollController.offset;
                  homeViewModel.updateAppBarColor(offset);
                }),
              slivers: [
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
                        return  Consumer<ShowingFilmsCardViewModel>(
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
                                          width: widthScreen*0.15,
                                          color: Colors.grey[800],
                                        ),
                                      );
                                    }
                                    final movie = movies[index];
                                    return FilmCard(
                                      width: 0.15,
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
                                  separatorBuilder: (context, index) => SizedBox(height: 10.h),
                                  itemCount: movies.length + (searchViewModel.isLoading ? 1 : 0),
                                  itemBuilder: (context, index) {
                                    if (index == movies.length) {
                                      return ClipRRect(
                                        borderRadius: BorderRadius.circular(5),
                                        child: Container(
                                          width: widthScreen*0.15,
                                          color: Colors.grey[800],
                                        ),
                                      );
                                    }
                                    final movie = movies[index];
                                    return FilmCard(
                                      width: 0.15,
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
          ),
        ],
      ),
    );
  }
}
