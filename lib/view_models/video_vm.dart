import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';


class VideoViewModel extends ChangeNotifier {
  late VideoPlayerController _controller;
  VideoPlayerController get controller => _controller;
  bool _isPlaying = false;
  bool get isPlaying => _isPlaying;

  Future<void> initializeVideo(String url) async {
    _controller = VideoPlayerController.networkUrl(Uri.parse(url));
    await _controller.initialize();
    notifyListeners();
  }

  void play() {
    if (!_controller.value.isPlaying) {
      _controller.play();
      _isPlaying = true;
      notifyListeners();
    }
  }

  // Phương thức pause
  void pause() {
    if (_controller.value.isPlaying) {
      _controller.pause();
      _isPlaying = false;
      notifyListeners();
    }
  }
  @override
  void dispose(){
    controller.dispose();
    super.dispose();
  }
}

