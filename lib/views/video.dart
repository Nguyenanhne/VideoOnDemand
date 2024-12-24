import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:lecle_yoyo_player/lecle_yoyo_player.dart';
import 'package:video_player/video_player.dart';

class VideoMobileScreen extends StatefulWidget {
  const VideoMobileScreen({super.key});

  @override
  State<VideoMobileScreen> createState() => _VideoMobileScreenState();
}

class _VideoMobileScreenState extends State<VideoMobileScreen> {
  var iconColor = Colors.white;
  var iconSize = 50.0;
  final url = "https://filmfinder.shop/videos/trailer.mp4";
  List<String> videoUrls = [
    "https://filmfinder.shop/videos/trailer.mp4",
    "https://filmfinder.shop/videos/output.m3u8"
  ];
  int currentVideoIndex = 0;
  void _initializePlayer(int index) {
    // Dispose of existing controllers
    _videoPlayerController.dispose();
    _chewieController.dispose();

    // Initialize new video player and Chewie controllers
    _videoPlayerController = VideoPlayerController.network(videoUrls[index]);
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController!,
      autoPlay: true,
      looping: true,
    );

    _videoPlayerController?.initialize().then((_) {
      setState(() {}); // Update UI when initialization is complete
    });
  }

  void _switchVideo(int newIndex) {
    if (newIndex >= 0 && newIndex < videoUrls.length) {
      currentVideoIndex = newIndex;
      _initializePlayer(newIndex);
    }
  }

  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.network(
      url,
    );
    _chewieController = ChewieController(
      aspectRatio: 16 / 9,
      videoPlayerController: _videoPlayerController,
      autoPlay: true,
      looping: true,
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      // DeviceOrientation.landscapeLeft,
      // DeviceOrientation.landscapeRight,
    ]);

    return Scaffold(
      body: SafeArea(
        child: Chewie(controller: _chewieController),
        // child: YoYoPlayer(
        //   aspectRatio: 16 / 9,
        //   url: "https://filmfinder.shop/videos/trailer.mp4",
        //   videoStyle: VideoStyle(),
        //   videoLoadingStyle: VideoLoadingStyle(),
        //   displayFullScreenAfterInit: true,
        //   onFullScreen: (value){
        //     SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
        //   },
        // ),
      )
    );
  }
}
