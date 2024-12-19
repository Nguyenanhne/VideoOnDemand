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

  void likeListOntap(BuildContext context, int index){
    switch (index){
      case 0:
        print("Danh sach");
      case 1:
        print("Danh gia");
      case 2:
        print("Chia se");
      case 3:
        NavigatorHelper.navigateTo(context, CommentScreen());
    }
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
    final filmService = FilmService();
    FilmModel? film = await FilmService().fetchFilmById(filmId);
    if (film != null) {
        return film;
    }
    print('Film not found!');
    return null;
  }
}