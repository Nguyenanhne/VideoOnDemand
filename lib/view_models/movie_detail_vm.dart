import 'package:du_an_cntt/helper/navigator.dart';
import 'package:du_an_cntt/views/comment/comment_screen_mobile.dart';
import 'package:du_an_cntt/views/comment/comment_screen_tablet.dart';
import 'package:flutter/material.dart';

import '../models/film_model.dart';
import '../services/FilmService.dart';
import '../views/comment/comment_screen.dart';

class DetailedMovieViewModel extends ChangeNotifier {
  int _activeEpisode = 0;

  int get activeEpisode => _activeEpisode;

  FilmModel? _film;

  FilmModel? get film => _film;

  void setActiveEpisode(int index) {
    _activeEpisode = index;
    notifyListeners();
  }

  // Future<FilmModel?> fetchFilmDetails(String filmId) async {
  //   try {
  //     _film = await FilmService().fetchFilmById(filmId);
  //     notifyListeners();
  //     return _film;
  //   } catch (e) {
  //     print("Error fetching film: $e");
  //     return null;
  //   }
  // }

  Future<FilmModel?> getFilmDetails(String filmId) async {
    FilmModel? film = await FilmService().fetchFilmById(filmId);
    if (film != null) {
        return film;
    }
    print('Film not found!');
    return null;
  }

  List<Map<String, dynamic>> likesList = [
  {"icon": Icons.add, "text": "Danh sách", "liked": false},
  {"icon": Icons.thumb_up_alt_outlined, "text": "Đánh giá", "liked": false},
  {"icon": Icons.send_outlined, "text": "Chia sẻ", "liked": false},
  {"icon": Icons.comment, "text": "Bình luận", "liked": false},
  ];

  void likeListOntap(int index) {
    likesList[index]['liked'] = !likesList[index]['liked'];

  if (likesList[index]['liked']) {
    likesList[index]['icon'] = Icons.thumb_up;
  } else {
    likesList[index]['icon'] = Icons.thumb_up_alt_outlined;
  }
    notifyListeners();
  }

}