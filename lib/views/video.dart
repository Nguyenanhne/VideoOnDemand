import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import '../view_models/video_vm.dart';
class VideoMobileScreen extends StatefulWidget {
  const VideoMobileScreen({super.key});

  @override
  State<VideoMobileScreen> createState() => _VideoMobileScreenState();
}

class _VideoMobileScreenState extends State<VideoMobileScreen> {
  // late VideoPlayerController controller;
  late Future<void> initializeVideoPlayerFuture;

  @override
  void dispose() {
    // controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // controller = VideoPlayerController.networkUrl(
    //   Uri.parse(
    //     'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
    //   ),
    // );
    final viewModel = Provider.of<VideoViewModel>(context, listen: false);
    initializeVideoPlayerFuture = viewModel.initializeVideo(
      'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
    );

  }
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<VideoViewModel>(context);

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    return Scaffold(
      floatingActionButton: Center(
        child: FloatingActionButton(
          onPressed: () {
            if (viewModel.controller.value.isPlaying){
              viewModel.pause();
            }
            else{
              viewModel.play();
            }
          },
          child: Icon(
            viewModel.controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
          ),
        ),
      ),
      body: FutureBuilder(
        future: initializeVideoPlayerFuture,
        builder: (context, snapshot){
          if (snapshot.connectionState == ConnectionState.done) {
            return Stack(
              children: [
                VideoPlayer(viewModel.controller),
                Positioned(
                  bottom: 10,
                  left: 10,
                  right: 10,
                  child: VideoProgressIndicator(
                    viewModel.controller,
                    allowScrubbing: true,
                    colors: VideoProgressColors(
                      playedColor: Colors.red,
                      backgroundColor: Colors.grey,
                      bufferedColor: Colors.grey,
                    ),
                  ),
                ),
              ],
            );
          }
          else{
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
