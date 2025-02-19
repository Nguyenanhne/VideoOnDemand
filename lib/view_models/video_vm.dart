import 'dart:async';
import 'package:better_player_enhanced/better_player.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../services/film_service.dart';
import '../services/firebase_authentication.dart';
import '../services/my_film_watched_service.dart';

class VideoViewModel with ChangeNotifier {
  final MyFilmWatchedService _service = MyFilmWatchedService();
  final filmService = FilmService();
  final auth = Auth();
  BetterPlayerController? _betterPlayerController;
  BetterPlayerDataSource? _betterPlayerDataSource;
  Timer? _savePositionTimer;
  String? _videoURL;
  bool _verifyToken = true;
  bool  get verifyToken => _verifyToken;
  String? get videoURL => _videoURL;
  BetterPlayerController? get betterPlayerController => _betterPlayerController;


  Future<void> initializeVideoPlayer({required String filmID, required int position}) async{
    // _videoURL = await getVideoURL(filmID);
    // print("video url $_videoURL");
    // if (_videoURL == null){
    //   return;
    // }
    BetterPlayerConfiguration betterPlayerConfiguration = BetterPlayerConfiguration(
      aspectRatio: 16 / 9,
      fit: BoxFit.contain,
      autoPlay: true,
      looping: true,
      fullScreenByDefault: true,
      startAt: Duration(seconds: position),
    );

    _betterPlayerDataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      "https://stream-akamai.castr.com/5b9352dbda7b8c769937e459/live_2361c920455111ea85db6911fe397b9e/index.fmp4.m3u8",
      // _videoURL!,
      cacheConfiguration: BetterPlayerCacheConfiguration(
        useCache: false,
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
    _betterPlayerController!.addEventsListener((event){
      if (event.betterPlayerEventType == BetterPlayerEventType.hideFullscreen) {
      }
    });
    _betterPlayerController!.setupDataSource(_betterPlayerDataSource!);
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
        final currentPosition = _betterPlayerController!.videoPlayerController!.value.position.inSeconds ?? 0;
        if(currentPosition> 10){
          await _service.saveFilmPosition(userID: user.uid, filmID: filmID, position: currentPosition);
          print("Auto-saved position for film $filmID at $currentPosition seconds");
        }
      }catch(e){
        print("Failed to save film position $e");
      }
    });

  }

  Future<String?> getVideoURL(filmID) async {
    _verifyToken = await auth.sendTokenToServer();
    if(_verifyToken){
      return await filmService.getVideoUrl(filmID);
    }
    _verifyToken = false;
    return null;
  }

  @override
  void dispose(){
    _betterPlayerController?.dispose();
    super.dispose();
  }

}
