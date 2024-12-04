import 'package:better_player/better_player.dart';
import 'package:chewie/chewie.dart';
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
  var iconColor = Colors.white;
  var iconSize = 50.0;
  @override
  void dispose() {
    super.dispose();
  }
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;

  @override
  void initState() {
    final viewModel = Provider.of<VideoViewModel>(context, listen: false);
    initializeVideoPlayerFuture = viewModel.initializeVideo(
      'http://192.168.5.1:3000/videos/input_video.mp4',
    );
    // _videoPlayerController = VideoPlayerController.network('https://www.example.com/video.mp4');
    // _chewieController = ChewieController(
    //   videoPlayerController: _videoPlayerController,
    //   autoPlay: true,
    //   looping: true,
    //   aspectRatio: 16 / 9,
    // );
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
      // body: Center(
      //   child: Chewie(
      //     controller: _chewieController,
      //   ),
      // ),
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
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: (){},
                        icon: Icon(
                          Icons.replay_10,
                          size: iconSize,
                          color: iconColor,
                        )
                      ),
                      IconButton(
                        onPressed: (){
                          if(viewModel.isPlaying){
                            viewModel.pause();
                          }
                          else{
                            viewModel.play();
                          }
                        },
                        icon: Icon(
                          Icons.pause,
                          size: iconSize,
                          color: iconColor,
                        )
                      ),
                      IconButton(
                        onPressed: (){},
                        icon: Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.rotationY(3.14159),
                          child: Icon(
                            Icons.replay_10,
                            size: iconSize,
                            color: iconColor,
                          ),
                        )
                      )
                    ],
                  ),
                )
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
