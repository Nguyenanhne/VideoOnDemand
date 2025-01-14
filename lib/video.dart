import 'package:better_player_enhanced/better_player.dart';
import 'package:du_an_cntt/helper/navigator.dart';
import 'package:du_an_cntt/utils.dart';
import 'package:du_an_cntt/views/detailed%20film/detailed_film_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class VideoPlayer extends StatefulWidget {
  const VideoPlayer({super.key});

  @override
  State<VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  late BetterPlayerController betterPlayerController;
  late BetterPlayerDataSource betterPlayerDataSource;

  @override
  void initState() {
    BetterPlayerConfiguration betterPlayerConfiguration = BetterPlayerConfiguration(
      aspectRatio: 16 / 9,
      fit: BoxFit.contain,
      autoPlay: true,
      looping: true,
      fullScreenByDefault: true
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
    super.initState();
  }

  @override
  void dispose() {
    betterPlayerController.dispose(forceDispose: true);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(colorAppbarIcon)),
          onPressed: () {
            NavigatorHelper.replaceWith(context, DetailedFilmScreen(filmID: "10iPJ4Jh5omsZofD2kXW"));
          },
        ),      ),
      body: BetterPlayer(controller: betterPlayerController),
    );
  }
}
