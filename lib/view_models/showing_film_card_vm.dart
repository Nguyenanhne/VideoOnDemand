import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:du_an_cntt/helper/navigator.dart';
import 'package:du_an_cntt/services/FilmService.dart';
import 'package:du_an_cntt/views/detailed%20film/detailed_film_screen.dart';
import 'package:flutter/cupertino.dart';
import '../models/film_model.dart';

class ShowingFilmsCardViewModel extends ChangeNotifier{

  ScrollController showingFilmsController = ScrollController();

  List<FilmModel> _films = [];

  bool _isLoading = false;

  bool _hasMore = true;

  String? _errorMessage;

  DocumentSnapshot? _lastDocument;

  bool get hasMore => _hasMore;

  bool get isLoading => _isLoading;

  String? get errorMessage => _errorMessage;

  List<FilmModel> get films => _films;

  void onTap(BuildContext context, FilmModel film){
    NavigatorHelper.navigateTo(context, DetailedFilmScreen(film: film));
  }

  Future<String> getImageUrl(String id) async {
    return FilmService().getImageUrl(id);
  }

  Future<void> fetchMoreFilms({int limit = 5}) async {
    if (_isLoading || !_hasMore) return;
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      final result = await FilmService().fetchListFilm(
        limit: limit,
        lastDocument: _lastDocument,
      );
      final List<FilmModel> films = result['films'] as List<FilmModel>;
      final DocumentSnapshot? lastDocument = result['lastDocument'] as DocumentSnapshot?;

      if (films.isNotEmpty) {
        _films.addAll(films);

        _lastDocument = lastDocument;

        if (films.length < limit) {
          _hasMore = false;
        }
      } else {
        _hasMore = false;
      }
    } catch (e) {
      _errorMessage = 'Failed to load movies: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchFilms() async {
    _films = [];
    try {
      final result = await FilmService().fetchListFilm(limit: 5, lastDocument: null);

      final List<FilmModel> films = result['films'] as List<FilmModel>;

      final DocumentSnapshot? lastDocument = result['lastDocument'] as DocumentSnapshot?;

      _films.addAll(films);

      _lastDocument = lastDocument;

      _hasMore = films.length == 5;

      showingFilmsController = ScrollController()..addListener(_onScroll);

    } catch (e) {
      _errorMessage = 'Failed to load movies: $e';
    }
  }

  void _onScroll() {
    if (showingFilmsController.position.pixels == showingFilmsController.position.maxScrollExtent && !isLoading && hasMore) {
      fetchMoreFilms();
    }
  }
  @override
  void dispose() {
    showingFilmsController.dispose();
    super.dispose();
  }

}