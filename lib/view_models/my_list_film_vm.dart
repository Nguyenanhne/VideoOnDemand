import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helper/navigator.dart';
import '../models/film_model.dart';
import '../services/film_service.dart';
import '../services/my_list_service.dart';
import '../views/detailed film/detailed_film_screen.dart';

class MyListFilmViewModel extends ChangeNotifier{
  final MyListService _myListService = MyListService();
  final FilmService _filmService = FilmService();

  ScrollController myListScrollController = ScrollController();

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

  void onTap(BuildContext context, FilmModel film){
    NavigatorHelper.navigateTo(context, DetailedFilmScreen(film: film));
  }


  void _onScroll() {
    if (myListScrollController.position.pixels == myListScrollController.position.maxScrollExtent &&
        !isLoading &&
        hasMore) {
      fetchMoreMyList();
    }
  }

  // }
  Future<void> fetchMyList({int limit = 10}) async {
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
        _filmIDs = await _myListService.fetchMyListFilmIDs(userID);
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
      myListScrollController = ScrollController()..addListener(_onScroll);
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
      int endIndex = startIndex + 10;

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
    myListScrollController.dispose();
    super.dispose();
  }
}