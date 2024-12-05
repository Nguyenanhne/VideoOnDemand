import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:video_player/video_player.dart';

class VideoMobileScreen extends StatefulWidget {
  const VideoMobileScreen({super.key});

  @override
  State<VideoMobileScreen> createState() => _VideoMobileScreenState();
}

class _VideoMobileScreenState extends State<VideoMobileScreen> {
  var iconColor = Colors.white;
  var iconSize = 50.0;
  final url = "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4";

  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.network(
      url,
    );
    _chewieController = ChewieController(
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
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    return Scaffold(
      // body: Chewie(
      //   controller: _chewieController!,
      // ),
      body: VideoPlayer(
        _videoPlayerController
      ),
    );
  }
}
