import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
class FlickVideoPlayerTrailer extends StatefulWidget {
  const FlickVideoPlayerTrailer({super.key, required this.flickManager});
  final FlickManager flickManager;

  @override
  State<FlickVideoPlayerTrailer> createState() => _FlickVideoPlayerTrailerState();
}

class _FlickVideoPlayerTrailerState extends State<FlickVideoPlayerTrailer> {
  @override
  Widget build(BuildContext context) {
    return FlickVideoPlayer(
      flickManager: widget.flickManager,
    );
  }
}
