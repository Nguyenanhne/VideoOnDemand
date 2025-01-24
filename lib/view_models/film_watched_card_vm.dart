import 'package:du_an_cntt/services/FilmService.dart';
import 'package:du_an_cntt/services/MyFilmWatchedService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import '../helper/navigator.dart';
import '../models/film_model.dart';
import '../views/detailed film/detailed_film_screen.dart';

class FilmWatchedCardViewModel extends ChangeNotifier{
  MyFilmWatchedService _myFilmWatchedService =  MyFilmWatchedService();
  FilmService _filmService = FilmService();

  ScrollController filmWatchedScrollController = ScrollController();

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

  void _onScroll() {
    if (filmWatchedScrollController.position.pixels == filmWatchedScrollController.position.maxScrollExtent &&
        !isLoading &&
        hasMore) {
      fetchMoreFilmWatched();
    }
  }
  Future<void> fetchMyListFilmWatched({int limit = 5}) async {
    _filmIDs = [];
    _films = [];
    _countFetch = 0;
    try {
      _isLoading = true;

      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        print('User is not logged in');
        _isLoading = false;
        return;
      }
      String userID = user.uid;
      if (_filmIDs.isEmpty) {
        _filmIDs = await _myFilmWatchedService.getListFilmIDbyUserID("userID");
        print(_filmIDs.length);
      }

      _films = [];
      for (var i = 0; i < limit && i < _filmIDs.length; i++) {
        FilmModel? film = await _filmService.fetchFilmByID(_filmIDs[i]);
        if (film != null) {
          _films.add(film);
        }
        _countFetch ++;
      }
      filmWatchedScrollController = ScrollController()..addListener(_onScroll);
      _hasMore = _countFetch < _filmIDs.length;
    } catch (e) {
      _errorMessage = 'Lỗi khi tải phim: $e';
    }finally {
      _isLoading = false;
    }
  }
  Future<void> fetchMoreFilmWatched() async {
    print(_filmIDs.length);
    if (_isLoading || !_hasMore) return;
    try {
      _isLoading = true;
      notifyListeners();

      int startIndex = _countFetch;
      int endIndex = startIndex + 5;

      for (var i = startIndex; i < endIndex && i < _filmIDs.length; i++) {
        FilmModel? film = await _filmService.fetchFilmByID(_filmIDs[i]);
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
  @override
  void dispose() {
    filmWatchedScrollController.dispose();
    super.dispose();
  }
}