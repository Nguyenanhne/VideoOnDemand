import 'dart:async';

import 'package:better_player_enhanced/better_player.dart';
import 'package:du_an_cntt/services/MyFilmWatchedService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VideoViewModel with ChangeNotifier {
  final MyFilmWatchedService _service = MyFilmWatchedService();
  late BetterPlayerController _betterPlayerController;
  late BetterPlayerDataSource _betterPlayerDataSource;
  Timer? _savePositionTimer;

  BetterPlayerController get betterPlayerController => _betterPlayerController;

  void initializeVideoPlayer({required String filmID, required String videoUrl}) {
    BetterPlayerConfiguration betterPlayerConfiguration = BetterPlayerConfiguration(
      aspectRatio: 16 / 9,
      fit: BoxFit.contain,
      autoPlay: true,
      looping: true,
      fullScreenByDefault: true,
    );

    _betterPlayerDataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      videoUrl,
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
        bufferForPlaybackAfterRebufferMs: 2000,
      ),
    );

    _betterPlayerController = BetterPlayerController(betterPlayerConfiguration);
    _betterPlayerController.setupDataSource(_betterPlayerDataSource);
    saveFilmPosition(filmID: filmID);
  }

  Future<void> saveFilmPosition({required String filmID})async {
    _savePositionTimer?.cancel();
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      print('User is not logged in');
      return;
    }
    _savePositionTimer = Timer.periodic(Duration(seconds: 10), (timer) async{
      try{
        final currentPosition = _betterPlayerController.videoPlayerController?.value.position.inSeconds ?? 0;
        if(currentPosition> 10){
          await _service.saveFilmPosition(userID: user.uid, filmID: filmID, position: currentPosition);
          print("Auto-saved position for film $filmID at $currentPosition seconds");
        }
      }catch(e){
        print("Failed to save film position $e");
      }
    });

  }

  @override
  void dispose(){
    _betterPlayerController.dispose(forceDispose: true);
    super.dispose();
  }

}
