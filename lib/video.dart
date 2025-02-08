import 'package:du_an_cntt/helper/navigator.dart';
import 'package:du_an_cntt/utils.dart';
import 'package:du_an_cntt/view_models/video_vm.dart';
import 'package:du_an_cntt/views/detailed%20film/detailed_film_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:better_player_enhanced/better_player.dart';

class VideoPlayer extends StatefulWidget {
  final String filmID;
  VideoPlayer({super.key, required this.filmID});

  @override
  State<VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {

  @override
  void initState() {
    // BetterPlayerConfiguration betterPlayerConfiguration = BetterPlayerConfiguration(
    //   aspectRatio: 16 / 9,
    //   fit: BoxFit.contain,
    //   autoPlay: true,
    //   looping: true,
    //   fullScreenByDefault: true
    // );
    // betterPlayerDataSource = BetterPlayerDataSource(
    //   BetterPlayerDataSourceType.network,
    //   "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4",
    //   cacheConfiguration: BetterPlayerCacheConfiguration(
    //     useCache: true,
    //     maxCacheSize: 100 * 1024 * 1024, // 100 MB
    //     maxCacheFileSize: 10 * 1024 * 1024, // 10 MB
    //     preCacheSize: 5 * 1024 * 1024, // 5 MB preload
    //   ),
    //   bufferingConfiguration: BetterPlayerBufferingConfiguration(
    //       minBufferMs: 2000,
    //       maxBufferMs: 10000,
    //       bufferForPlaybackMs: 1000,
    //       bufferForPlaybackAfterRebufferMs: 2000
    //   ),
    // );
    // betterPlayerController = BetterPlayerController(betterPlayerConfiguration);
    // betterPlayerController.setupDataSource(betterPlayerDataSource);
    final videoViewModel = Provider.of<VideoViewModel>(context, listen: false);
    videoViewModel.initializeVideoPlayer(filmID: widget.filmID, videoUrl: "https://test-streams.mux.dev/x36xhzz/x36xhzz.m3u8");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(colorAppbarIcon)),
          onPressed: () {
            // NavigatorHelper.replaceWith(context, DetailedFilmScreen(film: widget.filmID));
          },
        ),
      ),
      body: PopScope(
        canPop: false,
        child: Consumer<VideoViewModel>(
          builder: (context, videoViewModel, child) {
            return BetterPlayer(controller: videoViewModel.betterPlayerController);
          }
        )
      ),
    );
  }
}
