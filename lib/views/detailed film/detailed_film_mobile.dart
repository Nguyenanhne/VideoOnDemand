import 'package:better_player_enhanced/better_player.dart';
import 'package:chewie/chewie.dart';
import 'package:du_an_cntt/utils.dart';
import 'package:du_an_cntt/view_models/search_vm.dart';
import 'package:du_an_cntt/widgets/flim_card_vertical.dart';
import 'package:du_an_cntt/widgets/movie_detail/movie_detail_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tap_debouncer/tap_debouncer.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../helper/navigator.dart';
import '../../view_models/film_detail_vm.dart';

class DetailedMovieScreenMobile extends StatefulWidget {
  final String filmID;
  DetailedMovieScreenMobile({super.key, required this.filmID});

  @override
  State<DetailedMovieScreenMobile> createState() => _DetailedMovieScreenMobileState();
}

class _DetailedMovieScreenMobileState extends State<DetailedMovieScreenMobile>  with TickerProviderStateMixin {
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
      fontSize: 14.sp,
      color: Colors.white
  );


  void sameFilmsOnScroll() {
    final searchVM = Provider.of<SearchViewModel>(context, listen: false);
    if (sameFilmsController.position.pixels == sameFilmsController.position.maxScrollExtent && !searchVM.isLoading && searchVM.hasMore) {
      print("${searchVM.hasMore}");
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
        enableProgressBar: false
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
    betterPlayerController.dispose(forceDispose: true);
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
                  children: [
                    Text(
                      'Mô tả: $title',
                      style: contentStyle.copyWith(fontSize: 18.sp, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(
                        Icons.close_outlined,
                        color: Colors.white,
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
    };
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
                  children: [
                    Text(
                      'Diễn viên: $title',
                      style: contentStyle.copyWith(fontSize: 18.sp, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.close_outlined,
                        color: Colors.white,
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
          icon: Icon(Icons.arrow_back, color: Color(colorAppbarIcon)),
          onPressed: () {
            NavigatorHelper.goBack(context);
          },
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
      body: FutureBuilder<List<dynamic>>(
        future: combinedFuture,
          builder: (context, snapshot){
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            else{
              final film = snapshot.data![0];
              if (film == null){
                return Center(
                  child: Text("Lỗi khi mở phim", style: TextStyle(color: Colors.white, fontSize: 18.sp)),
                );
              }else{
                final searchVM = Provider.of<SearchViewModel>(context, listen: false);
                fetchSameFilms = searchVM.searchFilmsByMultipleType(film.type);
              }
              return CustomScrollView(
                controller: sameFilmsController,
                slivers: [
                  SliverToBoxAdapter (
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: heightScreen*0.3,
                            child: BetterPlayer(controller: betterPlayerController),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            child: Text(
                                film!.name,
                                style: contentStyle.copyWith(fontSize: 23.sp, fontWeight: FontWeight.bold)
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
                            padding: EdgeInsets.symmetric(vertical: 10.w),
                            child: SizedBox(
                              width: double.maxFinite,
                              height: 35.h,
                              child: DetailedMovieButton(
                                textSize: 14,
                                bgColor: Colors.white,
                                icon: Icons.play_arrow,
                                text: 'Phát',
                                textColor: Colors.black,
                                iconColor: Colors.black,
                                onPressed: () async {
                                  // betterPlayerController.pause();
                                  await viewModel.updateViewTotal(filmID);
                                  viewModel.playVideoOntap(context, filmID);
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            width: double.maxFinite,
                            height: 35.h,
                            child: DetailedMovieButton(
                              textSize: 14,
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
                              style: contentStyle.copyWith(fontSize: 13.sp),
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
                                        style: contentStyle.copyWith(fontSize: 13.sp),
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
                                      style: contentStyle.copyWith(fontSize: 13.sp, overflow: TextOverflow.ellipsis),
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
                                                  size: 25.sp,
                                                  color: Colors.white.withOpacity(0.9),
                                                ),
                                                SizedBox(
                                                  height: 5.h,
                                                ),
                                                Text(
                                                    "Danh sách",
                                                    style: contentStyle.copyWith(fontSize: 13.sp, color: Colors.grey)
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
                                                  size: 25.sp,
                                                  color: Colors.white.withOpacity(0.9),
                                                ),
                                                SizedBox(
                                                  height: 5.h,
                                                ),
                                                Text(
                                                    "Thích",
                                                    style: contentStyle.copyWith(fontSize: 13.sp, color: Colors.grey)
                                                )
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                      TapDebouncer(
                                        onTap: () async => await viewModel.toggleDislike(filmID),
                                        builder: (BuildContext context, TapDebouncerFunc? onTap) {
                                          return InkWell(
                                            onTap: onTap,
                                            child: Column(
                                              children: [
                                                Icon(
                                                  viewModel.hasDisliked ? Icons.thumb_down : Icons.thumb_down_off_alt,
                                                  size: 25.sp,
                                                  color: Colors.white.withOpacity(0.9),
                                                ),
                                                SizedBox(
                                                  height: 5.h,
                                                ),
                                                Text(
                                                    "Không thích",
                                                    style: contentStyle.copyWith(fontSize: 13.sp, color: Colors.grey)
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
                                              size: 25.sp,
                                              color: Colors.white.withOpacity(0.9),
                                            ),
                                            SizedBox(
                                              height: 5.h,
                                            ),
                                            Text(
                                                "Đánh giá",
                                                style: contentStyle.copyWith(fontSize: 13.sp, color: Colors.grey)
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
                                  child: Center(child: Text("Bạn không có danh sách xem sau nào", style: contentStyle)),
                                );
                              }
                              return SliverList.separated(
                                itemBuilder: (BuildContext context, int index) {
                                  if (index == sameFilms.length) {
                                    return CupertinoActivityIndicator();
                                  }
                                  final sameFilm = sameFilms[index];
                                  return FilmCardVertical(
                                    fontSize: 16,
                                    width: widthScreen*0.4,
                                    height: heightScreen*0.3,
                                    url: sameFilm.url,
                                    name: sameFilm.name,
                                    types: sameFilm.type.join(", "),
                                    age: sameFilm.age,
                                    ontap: (){},
                                    des: sameFilm.description
                                  );
                                },
                                separatorBuilder: (BuildContext context, int index) => SizedBox(height: 10.h),
                                itemCount:  sameFilms.length + (searchVM.isLoading ? 1 : 0),
                              );
                            }
                          );
                        }
                      }
                  ),
                  // SliverToBoxAdapter(
                  //   child: Padding(
                  //     padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                  //     child: SizedBox(
                  //       height: 50.h,
                  //       child: Consumer<DetailedFilmViewModel>(
                  //         builder: (context, viewModel, child) {
                  //           return ListView.builder(
                  //             scrollDirection: Axis.horizontal,
                  //             itemCount: optionList.length,
                  //             itemBuilder: (BuildContext context, int index) {
                  //               final isActive = viewModel.activeEpisode == index;
                  //               return InkWell(
                  //                 onTap: () {
                  //                   viewModel.setActiveEpisode(index);
                  //                 },
                  //                 child: Container(
                  //                   padding: EdgeInsets.symmetric(horizontal: 20.w),
                  //                   decoration: BoxDecoration(
                  //                     border: Border(
                  //                       top: BorderSide(
                  //                         width: 4.h,
                  //                         color: isActive
                  //                             ? Colors.red.withOpacity(0.8)
                  //                             : Colors.transparent,
                  //                       ),
                  //                     ),
                  //                   ),
                  //                   child: Center(
                  //                     child: Text(
                  //                       optionList[index],
                  //                       style: TextStyle(
                  //                         fontSize: 15.sp,
                  //                         color: isActive
                  //                             ? Colors.white.withOpacity(0.9)
                  //                             : Colors.white.withOpacity(0.5),
                  //                       ),
                  //                     ),
                  //                   ),
                  //                 ),
                  //               );
                  //             },
                  //           );
                  //         },
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              );
            }
          }
      ),
    );
  }
}
