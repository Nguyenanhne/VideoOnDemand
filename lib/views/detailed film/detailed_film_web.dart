import 'package:better_player_enhanced/better_player.dart';
import 'package:chewie/chewie.dart';
import 'package:du_an_cntt/utils.dart';
import 'package:du_an_cntt/view_models/home_vm.dart';
import 'package:du_an_cntt/widgets/movie_detail/movie_detail_button.dart';
import 'package:du_an_cntt/widgets/movie_detail/movie_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tap_debouncer/tap_debouncer.dart';

import '../../helper/navigator.dart';
import '../../view_models/film_detail_vm.dart';
import '../../view_models/search_vm.dart';
import '../../widgets/flim_card_vertical.dart';
class DetailedMovieScreenWeb extends StatefulWidget {
  final String filmID;
  const DetailedMovieScreenWeb({super.key, required this.filmID});

  @override
  State<DetailedMovieScreenWeb> createState() => _DetailedMovieScreenTablet();
}

class _DetailedMovieScreenTablet extends State<DetailedMovieScreenWeb> {
  late String filmID;
  late String filmUrlVideo;
  late String userID;
  int activeEpisode = 0;
  List optionList = ["Các tập", "Trailer", "Nội dung tương tự"];

  late Future filmDetailsFuture;
  late Future<void> fetchSameFilms;
  late Future isFilmInMyList;
  late Future<List<dynamic>> combinedFuture;

  late ScrollController sameFilmsController;
  late BetterPlayerController betterPlayerController;
  late BetterPlayerDataSource betterPlayerDataSource;

  final contentStyle = TextStyle(
      fontFamily: GoogleFonts.roboto().fontFamily,
      fontSize: 25,
      color: Colors.white
  );


  void sameFilmsOnScroll() {
    final searchVM = Provider.of<SearchViewModel>(context, listen: false);
    if (sameFilmsController.position.pixels == sameFilmsController.position.maxScrollExtent && !searchVM.isLoading && searchVM.hasMore) {
      searchVM.searchMoreFilmsByMultiType();
    }
  }

  @override
  void initState() {
    super.initState();
    sameFilmsController = ScrollController()..addListener(sameFilmsOnScroll);
    final filmVM = Provider.of<DetailedFilmViewModel>(context, listen: false);
    filmID = widget.filmID;
    filmUrlVideo = "https://filmfinder.shop/input_video.mp4";
    combinedFuture = Future.wait([
      filmVM.getFilmDetails(filmID),
      filmVM.getAddToListStatus(filmID),
      filmVM.getRating(filmID)
    ]);
    BetterPlayerConfiguration betterPlayerConfiguration = BetterPlayerConfiguration(
        aspectRatio: 16 / 9,
        fit: BoxFit.contain,
        autoPlay: false,
        looping: true,
        controlsConfiguration: BetterPlayerControlsConfiguration(
          enableOverflowMenu: false,
          enableFullscreen: false,
          enableProgressBar: false,
        )
    );
    betterPlayerDataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4",
      cacheConfiguration: BetterPlayerCacheConfiguration(
        useCache: true,
        maxCacheSize: 100 * 1024 * 1024, // 100 MB
        maxCacheFileSize: 10 * 1024 * 1024, // 10 MB
        preCacheSize: 5 * 1024 * 1024, // 5 MB preload
      ),
      bufferingConfiguration: BetterPlayerBufferingConfiguration(
          minBufferMs: 2000,
          maxBufferMs: 10000,
          bufferForPlaybackMs: 1000,
          bufferForPlaybackAfterRebufferMs: 2000
      ),
    );
    betterPlayerController = BetterPlayerController(betterPlayerConfiguration);
    betterPlayerController.setupDataSource(betterPlayerDataSource);

  }

  @override
  void dispose() {
    sameFilmsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final heightScreen = MediaQuery.of(context).size.height
        - AppBar().preferredSize.height
        - MediaQuery.of(context).padding.top;
    final heightBottomSheet = MediaQuery.of(context).size.height - AppBar().preferredSize.height;
    final widthScreen = MediaQuery.of(context).size.width;

    void showDesBottomSheet(BuildContext context, String title, String des) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return Container(
            height: heightBottomSheet,
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                          'Mô tả: $title',
                          style: contentStyle.copyWith(fontSize: 35, fontWeight: FontWeight.bold, overflow: TextOverflow.visible)
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(
                        Icons.close_outlined,
                        color: Colors.white,
                        size: iconTabletSize,
                      ) ,
                    )
                  ],
                ),
                SizedBox(height: 20.h),
                Text(
                  des,
                  style: contentStyle.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          );
        },
      );
    }
    void showActorBottomSheet(BuildContext context, String title, List<String> actors) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return Container(
            height: heightBottomSheet,
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16.0)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        'Diễn viên: $title',
                        style: contentStyle.copyWith(fontSize: 35, fontWeight: FontWeight.bold, overflow: TextOverflow.visible),
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.close_outlined,
                        color: Colors.white,
                        size: iconTabletSize,
                      ) ,
                    )
                  ],
                ),
                SizedBox(height: 20.h),
                Expanded(
                  child: ListView.separated(
                    separatorBuilder: (BuildContext context, int index) => const SizedBox(
                      height: 10,
                    ),
                    itemCount: actors.length,
                    itemBuilder: (BuildContext context, int index) => Text(
                      actors[index],
                      style: contentStyle.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    }
    final viewModel = Provider.of<DetailedFilmViewModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(colorAppbarIcon), size: iconTabletSize),
          onPressed: () {
            NavigatorHelper.goBack(context);
          },
        ),
        actions: [
          InkWell(
              onTap: (){},
              child: const Icon(
                LineAwesomeIcons.download_solid,
                size: iconTabletSize,
                color: Colors.white,
              )
          ),
          SizedBox(width: 15.w),
          InkWell(
              onTap: (){},
              child: const Icon(
                Icons.search,
                size: iconTabletSize,
                color: Colors.white,
              )
          ),
          SizedBox(width: 20.w)
        ],
      ),
      body: FutureBuilder<List<dynamic>>(
          future: combinedFuture,
          builder: (context, snapshot){
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError){
              return Center(
                child: Text("Lỗi khi mở phim", style: contentStyle),
              );
            }
            else{
              final film = snapshot.data![0];
              if (film == null){
                return Center(
                  child: Text("Lỗi khi mở phim", style: contentStyle),
                );
              }else{
                final searchVM = Provider.of<SearchViewModel>(context, listen: false);
                fetchSameFilms = searchVM.searchFilmsByMultipleType(film.type);
              }
              return Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: CustomScrollView(
                      slivers: [
                        SliverToBoxAdapter(
                          child: SizedBox(
                            height: heightScreen*0.4,
                            child: BetterPlayer(controller: betterPlayerController),
                          ),
                        ),
                        SliverToBoxAdapter (
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10.h),
                                  child: Text(
                                      film!.name,
                                      style: contentStyle.copyWith(fontSize: 40, fontWeight: FontWeight.bold)
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      film.year.toString(),
                                      style: contentStyle.copyWith(color: Colors.grey),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                                      child: Container(
                                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(2.r),
                                          color: Colors.grey[800],
                                        ),
                                        child: Text(
                                          ("${film.age.toString()}+"),
                                          style: contentStyle.copyWith(color: Colors.grey),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      film!.type.join(", "),
                                      style: contentStyle.copyWith(color: Colors.grey),
                                    )
                                  ],
                                ),
                                ListTile(
                                  leading: Image(
                                    image: AssetImage("assets/top10.png"),
                                    width: 20.w,
                                    height: 20.w,
                                    fit: BoxFit.fitWidth,
                                  ),
                                  title: Text(
                                    "#1 Dẫn đầu BHX trong tháng này",
                                    style: contentStyle.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                                  ),
                                  contentPadding: EdgeInsets.zero,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10.h),
                                  child: SizedBox(
                                    width: double.maxFinite,
                                    height: 40.h,
                                    child: DetailedMovieButton(
                                      textSize: 25,
                                      bgColor: Colors.white,
                                      icon: Icons.play_arrow,
                                      text: 'Phát',
                                      textColor: Colors.black,
                                      iconColor: Colors.black,
                                      onPressed: (){
                                        viewModel.playVideoOntap(context, filmID);
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: double.maxFinite,
                                  height: 40.h,
                                  child: DetailedMovieButton(
                                    textSize: 25,
                                    bgColor: Colors.grey[900],
                                    icon: LineAwesomeIcons.download_solid,
                                    text: 'Tải xuống',
                                    textColor: Colors.white,
                                    iconColor: Colors.white,
                                    onPressed: () {

                                    },
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 5.h),
                                  child: Text(
                                    "Mô tả",
                                    style: contentStyle.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                GestureDetector(
                                  child: Text(
                                    film.description,
                                    style: contentStyle.copyWith(),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 3,
                                  ),
                                  onTap: () => showDesBottomSheet(context, film.name, film.description),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 5.h),
                                  child: GestureDetector(
                                    onTap: (){
                                      showActorBottomSheet(context, film.name, film.actors);
                                    },
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Diễn viên:",
                                          style: contentStyle.copyWith(fontWeight: FontWeight.bold, color: Colors.grey),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: EdgeInsets.only(left: 10.w),
                                            child: Text(
                                              film.actors.join(", "),
                                              maxLines: 2,
                                              style: contentStyle.copyWith(),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: (){
                                    // showActorBottomSheet(context, film.name, film.actors);
                                  },
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Đạo diễn: ",
                                        style: contentStyle.copyWith(fontWeight: FontWeight.bold, color: Colors.grey),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 10.w),
                                          child: Text(
                                            film.director,
                                            style: contentStyle.copyWith(overflow: TextOverflow.ellipsis),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Consumer<DetailedFilmViewModel>(
                                  builder: (context, viewModel, child){
                                    return Padding(
                                      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          TapDebouncer(
                                            onTap: () async => await viewModel.toggleHasInMyList(filmID), // your tap handler moved here
                                            builder: (BuildContext context, TapDebouncerFunc? onTap) {
                                              return InkWell(
                                                onTap: onTap,
                                                child: Column(
                                                  children: [
                                                    Icon(
                                                      viewModel.hasInMyList ? Icons.check : Icons.add,
                                                      size: 40,
                                                      color: Colors.white.withOpacity(0.9),
                                                    ),
                                                    SizedBox(
                                                      height: 5.h,
                                                    ),
                                                    Text(
                                                        "Danh sách",
                                                        style: contentStyle.copyWith(color: Colors.grey)
                                                    )
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                          TapDebouncer(
                                            onTap: ()  async =>  await viewModel.toggleLike(filmID), // your tap handler moved here
                                            builder: (BuildContext context, TapDebouncerFunc? onTap) {
                                              return InkWell(
                                                onTap: onTap,
                                                child: Column(
                                                  children: [
                                                    Icon(
                                                      viewModel.hasLiked ? Icons.thumb_up : Icons.thumb_up_off_alt,
                                                      size: 40,
                                                      color: Colors.white.withOpacity(0.9),
                                                    ),
                                                    SizedBox(
                                                      height: 5.h,
                                                    ),
                                                    Text(
                                                        "Thích",
                                                        style: contentStyle.copyWith(color: Colors.grey)
                                                    )
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                          TapDebouncer(
                                            onTap: () async => await viewModel.toggleDislike(filmID),// your tap handler moved here
                                            builder: (BuildContext context, TapDebouncerFunc? onTap) {
                                              return InkWell(
                                                onTap: onTap,
                                                child: Column(
                                                  children: [
                                                    Icon(
                                                      viewModel.hasDisliked ? Icons.thumb_down : Icons.thumb_down_off_alt,
                                                      size: 40,
                                                      color: Colors.white.withOpacity(0.9),
                                                    ),
                                                    SizedBox(
                                                      height: 5.h,
                                                    ),
                                                    Text(
                                                        "Không thích",
                                                        style: contentStyle.copyWith(color: Colors.grey)
                                                    )
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                          InkWell(
                                            onTap: (){
                                              viewModel.ratingOntap(context, filmID);
                                            },
                                            child: Column(
                                              children: [
                                                Icon(
                                                  Icons.reviews,
                                                  size: 40,
                                                  color: Colors.white.withOpacity(0.9),
                                                ),
                                                SizedBox(
                                                  height: 5.h,
                                                ),
                                                Text(
                                                    "Đánh giá",
                                                    style: contentStyle.copyWith(color: Colors.grey)
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: CustomScrollView(
                      controller: sameFilmsController,
                      slivers: [
                        SliverToBoxAdapter(
                          child: Text(
                              "Phim tương tự",
                              style: contentStyle.copyWith(fontWeight: FontWeight.bold)
                          ),
                        ),
                        FutureBuilder(
                            future: fetchSameFilms,
                            builder: (context, snapshot){
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return SliverToBoxAdapter(
                                  child: Center(child: CircularProgressIndicator()),
                                );
                              } else if (snapshot.hasError) {
                                return SliverToBoxAdapter(
                                  child: Center(child: Text('Error: ${snapshot.error}')),
                                );
                              }
                              else{
                                return Consumer<SearchViewModel>(
                                    builder: (context, searchVM, child){
                                      final sameFilms = searchVM.films;
                                      if (sameFilms.isEmpty) {
                                        return SliverToBoxAdapter(
                                          child: Center(child: Text("Bạn không có danh sách phim tương tự nào!", style: contentStyle)),
                                        );
                                      }
                                      return SliverList.separated(
                                        itemBuilder: (BuildContext context, int index) {
                                          if (index == sameFilms.length) {
                                            return CupertinoActivityIndicator();
                                          }
                                          final sameFilm = sameFilms[index];
                                          return FilmCardVertical(
                                            fontSize: 20,
                                            height: heightScreen*0.25,
                                            width: widthScreen*0.1,
                                            url: sameFilm.url,
                                            name: sameFilm.name,
                                            types: sameFilm.type.join(", "),
                                            age: sameFilm.age,
                                            ontap: (){
                                              NavigatorHelper.replaceWith(context, DetailedMovieScreenWeb(filmID: sameFilm.id));
                                            },
                                            des: sameFilm.description
                                          );
                                        },
                                        separatorBuilder: (BuildContext context, int index) => SizedBox(height: 5.h),
                                        itemCount:  sameFilms.length + (searchVM.isLoading ? 1 : 0),
                                      );
                                    }
                                );
                              }
                            }
                        )
                      ]),
                  ),
                ],
              );
            }
          }
      ),
    );
  }
}
