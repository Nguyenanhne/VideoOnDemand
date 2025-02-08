import 'package:flutter/material.dart';

import '../services/my_film_watched_service.dart';

class ResumeViewModel extends ChangeNotifier{
  MyFilmWatchedService _myFilmWatchedService =  MyFilmWatchedService();

  int _position = 0;
  int get position => _position;

  Future<void> getVideoPosition(String filmID) async{
    _position = await _myFilmWatchedService.getPositionByFilmID(filmID);
  }

  String formatPosition(int positionInSeconds) {
    final int hours = positionInSeconds ~/ 3600;
    final int minutes = (positionInSeconds % 3600) ~/ 60;
    final int seconds = positionInSeconds % 60;

    if (hours > 0) {
      return "$hours:${minutes.toString().padLeft(2, '0')}:${seconds.toString()
          .padLeft(2, '0')}";
    } else {
      return "$minutes:${seconds.toString().padLeft(2, '0')}";
    }
  }
}