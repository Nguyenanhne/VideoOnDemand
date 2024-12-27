import 'package:better_player_enhanced/better_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lecle_yoyo_player/lecle_yoyo_player.dart';

class Test extends StatefulWidget {
  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  late BetterPlayerController _betterPlayerController;

  @override
  void initState() {
    // TODO: implement initState
    BetterPlayerConfiguration betterPlayerConfiguration =
    BetterPlayerConfiguration(
      // autoPlay: true,
      aspectRatio: 16 / 9,
      fit: BoxFit.contain,
      autoDetectFullscreenDeviceOrientation: true);
    BetterPlayerDataSource dataSource = BetterPlayerDataSource(
        BetterPlayerDataSourceType.network,"http://10.0.2.2:3000/videos/master.m3u8" );
    _betterPlayerController = BetterPlayerController(betterPlayerConfiguration);
    _betterPlayerController.setupDataSource(dataSource);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.immersive,
    );
    return Scaffold(
      body: Center(
        child: BetterPlayer(controller: _betterPlayerController),
        // child: YoYoPlayer(
        //   aspectRatio: 16 / 9,
        //   allowCacheFile: true,
        //   url: "http://10.0.2.2:3000/videos/master.m3u8",
        //   videoStyle: VideoStyle(
        //     qualityStyle: const TextStyle(
        //       fontSize: 16.0,
        //       fontWeight: FontWeight.w500,
        //       color: Colors.white,
        //     ),
        //     forwardAndBackwardBtSize: 30.0,
        //     playButtonIconSize: 40.0,
        //     playIcon: const Icon(
        //       Icons.add_circle_outline_outlined,
        //       size: 40.0,
        //       color: Colors.white,
        //     ),
        //     pauseIcon: const Icon(
        //       Icons.remove_circle_outline_outlined,
        //       size: 40.0,
        //       color: Colors.white,
        //     ),
        //     videoQualityPadding: const EdgeInsets.all(5.0),
        //     // showLiveDirectButton: true,
        //     // enableSystemOrientationsOverride: false,
        //   ),
        // ),
      ),
    );
  }
}
