import 'package:du_an_cntt/services/api_services.dart';
import 'package:du_an_cntt/widgets/movie_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../models/movie_model.dart';
class HomeScreenMobile extends StatefulWidget {
  const HomeScreenMobile({super.key});

  @override
  State<HomeScreenMobile> createState() => _HomeScreenMobileState();
}

class _HomeScreenMobileState extends State<HomeScreenMobile> {
  late Future<MovieModel> upComingMovies;
  late Future<MovieModel> nowPlayingMovies;
  ApiServices apiServices = ApiServices();
  @override
  void initState() {
    super.initState();
    upComingMovies = apiServices.getUpcomingMovies();
    nowPlayingMovies = apiServices.getNowPlayingMovies();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        backgroundColor: Colors.black,
        title: Container(
          padding: EdgeInsets.zero,
          child: Image.asset(
            "assets/logo.png",
            height: 50.h,
            width: 120.w
          ),
        ),
        actions: [
          InkWell(
            onTap: (){},
            child: const Icon(
              LineAwesomeIcons.download_solid,
              size: 30,
              color: Colors.white,
            )
          ),
          SizedBox(width: 15.w),
          InkWell(
              onTap: (){},
              child: const Icon(
                Icons.search,
                size: 30,
                color: Colors.white,
              )
          ),
          SizedBox(width: 20.w)
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: MovieCardWidget(movie: upComingMovies, headerLineText: "Upcoming Movies"),
          ),
          Expanded(
            child: MovieCardWidget(movie: upComingMovies, headerLineText: "Now Playing Movies"),
          ),
          Expanded(child: SizedBox())
        ],
      ),
    );
  }
}
