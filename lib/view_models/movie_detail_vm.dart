import 'package:du_an_cntt/helper/navigator.dart';
import 'package:du_an_cntt/services/MyListService.dart';
import 'package:du_an_cntt/views/comment/comment_screen_mobile.dart';
import 'package:du_an_cntt/views/comment/comment_screen_tablet.dart';
import 'package:flutter/material.dart';

import '../models/movie_model.dart';
import '../services/MovieService.dart';
import '../views/comment/comment_screen.dart';

class DetailedMovieViewModel extends ChangeNotifier {
  int _activeEpisode = 0;

  int get activeEpisode => _activeEpisode;

  MovieModel? _film;

  MovieModel? get film => _film;

  bool _hasInMyList = false;

  bool get hasInMyList => _hasInMyList;


  void setActiveEpisode(int index) {
    _activeEpisode = index;
    notifyListeners();
  }

  void toggleHasInMyList() {
    _hasInMyList = !_hasInMyList;
    notifyListeners();
  }

  void setHasInMyListFromFunction(Future<bool> Function() fetchStatus) async {
    final result = await fetchStatus();
    _hasInMyList = result;
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

  Future<MovieModel?> getFilmDetails(String filmId) async {
    MovieModel? film = await MovieService().fetchFilmById(filmId);
    if (film != null) {
        return film;
    }
    print('Film not found!');
    return null;
  }
  Future<void> getAddToListStatus(String filmID, String userID) async{
    _hasInMyList = await MyListService().isFilmInMyList(userID, filmID);
    // notifyListeners();
  }

}