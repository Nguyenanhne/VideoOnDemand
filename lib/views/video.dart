import 'dart:async';
import 'package:du_an_cntt/helper/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils.dart';

class VideoPlayerPage extends StatefulWidget {
  final int startPosition;
  const VideoPlayerPage({Key? key, required this.startPosition}) : super(key: key);

  @override
  State<VideoPlayerPage> createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  // late BetterPlayerController _betterPlayerController;
  bool isPlayerInitialized = false;

  @override
  void initState() {
    super.initState();
    // SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeRight, DeviceOrientation.landscapeLeft]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    // _initializePlayer(widget.startPosition);
  }

  // Future<void> _initializePlayer(int startPosition) async {
  //   BetterPlayerDataSource betterPlayerDataSource = BetterPlayerDataSource(
  //     BetterPlayerDataSourceType.network,
  //      "https://filmfinder.shop/input_video.mp4",
  //     cacheConfiguration: BetterPlayerCacheConfiguration(
  //       useCache: true,
  //       maxCacheSize: 100 * 1024 * 1024, // 100 MB
  //       maxCacheFileSize: 10 * 1024 * 1024, // 10 MB
  //       preCacheSize: 5 * 1024 * 1024, // 5 MB preload
  //     ),
  //     bufferingConfiguration: BetterPlayerBufferingConfiguration(
  //         minBufferMs: 2000,
  //         maxBufferMs: 10000,
  //         bufferForPlaybackMs: 1000,
  //         bufferForPlaybackAfterRebufferMs: 2000
  //     ),
  //   );
  //
  //   _betterPlayerController = BetterPlayerController(
  //     BetterPlayerConfiguration(
  //       autoDispose: false,
  //       fit: BoxFit.contain,
  //       deviceOrientationsAfterFullScreen: [
  //         DeviceOrientation.portraitUp,
  //         DeviceOrientation.portraitDown
  //       ],
  //       deviceOrientationsOnFullScreen: [
  //         DeviceOrientation.landscapeLeft,
  //         DeviceOrientation.landscapeRight,
  //       ],
  //       allowedScreenSleep: false, // Kh
  //       startAt: Duration(seconds: startPosition),
  //       autoPlay: true,
  //       controlsConfiguration: BetterPlayerControlsConfiguration(
  //         enableMute: false,
  //         enablePlayPause: false,
  //         progressBarPlayedColor: Colors.red,
  //         progressBarBufferedColor: Colors.blue,
  //         progressBarHandleColor: Colors.red,
  //         enableSubtitles: false,
  //         enableAudioTracks: false,
  //       ),
  //     ),
  //     // betterPlayerDataSource: betterPlayerDataSource,
  //   );
  //
  //   setState(() {
  //     isPlayerInitialized = true;
  //   });
  //
  //   // _startSavingPosition();
  // }

  // Hàm xử lý lưu vị trí video
  // void _startSavingPosition() {
  //   Timer.periodic(const Duration(seconds: 5), (timer) async {
  //     if (_betterPlayerController.isPlaying()!) {
  //       final position = _betterPlayerController.videoPlayerController!.value.position;
  //       SharedPreferences prefs = await SharedPreferences.getInstance();
  //       await prefs.setInt('last_video_position', position.inSeconds);
  //     }
  //   });
  // }

  @override
  void dispose() {
    // _betterPlayerController.dispose(forceDispose: true);
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown, DeviceOrientation.portraitUp, DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight],);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      child: Scaffold(
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
        body: Container(
        //   child: isPlayerInitialized
        //       ? BetterPlayer(controller: _betterPlayerController)
        //       : const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
