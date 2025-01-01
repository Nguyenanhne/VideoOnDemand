import 'package:du_an_cntt/models/film_model.dart';
import 'package:du_an_cntt/view_models/home_vm.dart';
import 'package:du_an_cntt/widgets/home/main_poster.dart';
import 'package:du_an_cntt/widgets/movie_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../services/FilmService.dart';

class HomeScreenMobile extends StatefulWidget {
  const HomeScreenMobile({super.key});

  @override
  State<HomeScreenMobile> createState() => _HomeScreenMobileState();
}

class _HomeScreenMobileState extends State<HomeScreenMobile> {
  late Future<List<FilmModel>> films;
  late ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    // films = FilmService().fetchListFilm();
  }

  @override
  void dispose() {
    scrollController.dispose();
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
      color: Colors.white
    );

    final provider = Provider.of<HomeViewModel>(context, listen: false);

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: CustomScrollView(
        controller: scrollController
          ..addListener(() {
            final offset = scrollController.offset;
            provider.updateAppBarColor(offset);
          }),
        slivers: [
          Consumer<HomeViewModel>(
            builder: (context, provider, child){
              return SliverAppBar(
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
                            style: TextStyle(
                              fontFamily: GoogleFonts.roboto().fontFamily,
                              color: Colors.white,
                              fontSize: 13.sp,
                            ),
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
                              style: TextStyle(
                                fontFamily: GoogleFonts.roboto().fontFamily,
                                color: Colors.white,
                                fontSize: 13.sp,
                              ),
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
                            style: TextStyle(
                              fontFamily: GoogleFonts.roboto().fontFamily,
                              color: Colors.white,
                              fontSize: 13.sp,
                            ),
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
                height: heightScreen*0.7,
                child: MainPoster()
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: heightScreen*0.3,
              child: MovieCardWidget(movies: films, headerLineText: "Phim đang chiếu"),
            ),
          ),
          // SliverToBoxAdapter(
          //   child: SizedBox(
          //     height: heightScreen*0.3,
          //     child: MovieCardWidget(movie: upComingMovies, headerLineText: "Upcoming Movies"),
          //   ),
          // ),
        ],
      ),
    );
  }
}
