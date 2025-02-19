import 'package:du_an_cntt/utils/utils.dart';
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
import '../../view_models/search_vm.dart';
import '../../view_models/showing_film_card_vm.dart';
import '../../widgets/film_card.dart';
class HomeScreenWeb extends StatefulWidget {
  final Future<void> fetchShowing;
  final Future<void> getAllTypes;
  final Future<void> fetchMainPoster;

  const HomeScreenWeb({super.key, required this.fetchShowing, required this.getAllTypes, required this.fetchMainPoster});
  @override
  State<HomeScreenWeb> createState() => _HomeScreenWebState();
}

class _HomeScreenWebState extends State<HomeScreenWeb> {

  @override
  Widget build(BuildContext context) {
    final heightScreen = MediaQuery.of(context).size.height
        - AppBar().preferredSize.height
        - MediaQuery.of(context).padding.top;

    final widthScreen = MediaQuery.of(context).size.width;

    final contentStyle = TextStyle(
        fontFamily: GoogleFonts.roboto().fontFamily,
        fontSize: 20,
        color: Colors.white
    );
    final bottomStyle = TextStyle(
        fontFamily: GoogleFonts.roboto().fontFamily,
        fontSize: 16,
        color: Colors.white
    );
    final titleStyle = TextStyle(
      fontSize: 25,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    );
    final homeViewModel = Provider.of<HomeViewModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar (
        titleSpacing: 0,
        elevation: 100,
        backgroundColor: Colors.black,
        title: Container(
          padding: EdgeInsets.zero,
          child: Image.asset(
            "assets/logo.png",
            width: 50.w,
          ),
        ),
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
                      style: bottomStyle
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
                        style: bottomStyle
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
                      style: bottomStyle
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
            flex: 3,
            child: FutureBuilder(
                future: widget.fetchMainPoster,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
                      child: MainPoster(fontSize: 20, iconSize: 30.0)
                  );
                }
            ),
            // child: Container(
            //     padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
            //     child: MainPoster(fontSize: 20, iconSize: 50.0)
            // ),
          ),
          Expanded(
            flex: 5,
            child: CustomScrollView(
              controller: homeViewModel.homeScrollController,
              slivers: [
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
                                      separatorBuilder: (context, index) => SizedBox(width: 5.w),
                                      itemCount: movies.length + (showingFilmViewModel.isLoading ? 1 : 0),
                                      itemBuilder: (context, index) {
                                        if (index == movies.length) {
                                          return ClipRRect(
                                            borderRadius: BorderRadius.circular(5),
                                            child: Container(
                                              width: widthScreen*0.13,
                                              color: Colors.grey[800],
                                            ),
                                          );
                                        }
                                        final movie = movies[index];
                                        return FilmCard(
                                          width: 0.13,
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
                                      style: titleStyle,
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
                                        separatorBuilder: (context, index) => SizedBox(width: 5.w),
                                        itemCount: (homeViewModel.filmsTypes[typeName]?.length ?? 0) +
                                            ((homeViewModel.isMoreLoading[typeName] ?? false) ? 1 : 0),
                                        itemBuilder: (context, index) {
                                          if (index == homeViewModel.filmsTypes[typeName]!.length) {
                                            return ClipRRect(
                                              borderRadius: BorderRadius.circular(5),
                                              child: Container(
                                                width: widthScreen * 0.13,
                                                color: Colors.grey[800],
                                              ),
                                            );
                                          }else{
                                            final movie = homeViewModel.filmsTypes[typeName]![index];
                                            return FilmCard(
                                              width: 0.13,
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
          ),
        ],
      ),
    );
  }
}
