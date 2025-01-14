import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:du_an_cntt/services/MyListService.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helper/navigator.dart';
import '../models/film_model.dart';
import '../services/FilmService.dart';
import '../views/detailed film/detailed_film_screen.dart';

class MyListFilmViewModel extends ChangeNotifier{
  MyListService _myListService = MyListService();
  FilmService _filmService = FilmService();
  int _countFetch = 0;

  List<FilmModel> _films = [];

  List<String> _filmIDs = [];

  bool _isLoading = false;

  bool _hasMore = true;

  String? _errorMessage;

  bool get hasMore => _hasMore;

  bool get isLoading => _isLoading;

  String? get errorMessage => _errorMessage;

  List<FilmModel> get films => _films;

  void onTap(BuildContext context, String movieID){
    NavigatorHelper.navigateTo(context, DetailedFilmScreen(filmID: movieID));
  }

  // Future<void> fetchMyList() async {
  //   try {
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     final userID = prefs.getString("userId").toString();
  //
  //     List<String> filmIDs = await _myListService.fetchMyListFilmIDs(userID);
  //
  //     _films = [];
  //     for (var filmID in filmIDs) {
  //       FilmModel? film = await _filmService.fetchFilmById(filmID);
  //       if (film != null) {
  //         films.add(film);
  //       }
  //     }
  //   } catch (e) {
  //     _errorMessage = 'Failed to fetch films: $e';
  //   }
  // }
  Future<void> fetchMyList({int limit = 5}) async {
    _filmIDs = [];
    _films = [];
    _countFetch = 0;
    try {
      _isLoading = true;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final userID = prefs.getString("userId").toString();

      if (_filmIDs.isEmpty) {
        _filmIDs = await _myListService.fetchMyListFilmIDs(userID);
        print(_filmIDs.length);
      }

      _films = [];
      for (var i = 0; i < limit && i < _filmIDs.length; i++) {
        FilmModel? film = await _filmService.fetchFilmById(_filmIDs[i]);
        if (film != null) {
          _films.add(film);
        }
        _countFetch ++;
      }
      _hasMore = _countFetch < _filmIDs.length;
    } catch (e) {
      _errorMessage = 'Lỗi khi tải phim: $e';
    }finally {
      _isLoading = false;
    }
  }

  Future<void> fetchMoreMyList() async {
    print(_filmIDs.length);
    if (_isLoading || !_hasMore) return;
    try {
      _isLoading = true;
      notifyListeners();

      int startIndex = _countFetch;
      int endIndex = startIndex + 5;

      for (var i = startIndex; i < endIndex && i < _filmIDs.length; i++) {
        FilmModel? film = await _filmService.fetchFilmById(_filmIDs[i]);
        if (film != null) {
          _films.add(film);
        }
      }
      _countFetch ++;

      _hasMore = _films.length < _filmIDs.length;
    } catch (e) {
      _errorMessage = 'Lỗi khi tải thêm phim: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

}