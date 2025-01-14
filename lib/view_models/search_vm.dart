import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../models/film_model.dart';
import '../../services/FilmService.dart';
import '../helper/navigator.dart';
import '../services/TypeService.dart';
import '../views/detailed film/detailed_film_screen.dart';

class SearchViewModel extends ChangeNotifier {
  final TypeService typeService = TypeService();
  final FilmService filmService = FilmService();

  List<FilmModel> _films = [];

  List<String> _types = [];

  String? _selectedType;
  List<String>? _selectedTypes;

  bool _hasMore = true;

  String? _errorMessage;

  DocumentSnapshot? _lastDocument;

  bool _isSearching = false;

  bool _isLoading = false;

  List<String> get types =>_types;

  bool get hasMore => _hasMore;

  bool get isSearching => _isSearching;

  bool get isLoading => _isLoading;

  String? get errorMessage => _errorMessage;

  List<FilmModel> get films => _films;

  //
  // Future<void> loadFilmsByType(String type) async {
  //   selectedType = type;
  //   _isLoading = true;
  //   notifyListeners();
  //
  //   try {
  //     _films = await filmService.searchByType(type);
  //   } catch (e) {
  //     _films = [];
  //   } finally {
  //     _isLoading = false;
  //     notifyListeners();
  //   }
  // }
  void onTap(BuildContext context, String movieID){
    NavigatorHelper.navigateTo(context, DetailedFilmScreen(filmID: movieID));
  }
  Future<void> getAllTypes() async {
    _types =  await typeService.getAllTypes();
  }

  Future<void> searchFilmsByType(String type) async {
    _selectedType = type;
    _isSearching = true;
    notifyListeners();
    _films.clear();
    try {
      final result = await FilmService().searchByType(type, limit: 5, lastDocument: null);

      final List<FilmModel> films = result['films'] as List<FilmModel>;

      final DocumentSnapshot? lastDocument = result['lastDocument'] as DocumentSnapshot?;

      _films.addAll(films);

      _lastDocument = lastDocument;

      _hasMore = films.length == 5;

    } catch (e) {
      _errorMessage = 'Failed to search films: $e';
    }finally{
      _isSearching = false;
      notifyListeners();
    }
  }

  Future<void> searchMoreFilmsByType( {int limit = 5}) async {
    if (_isLoading || !_hasMore) return;
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      final result = await FilmService().searchByType(
        _selectedType!,
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

  Future<void> searchFilmsByMultipleType(List<String> types) async {
    _selectedTypes = types;
    _isSearching = true;
    _films.clear();
    try {
      final result = await FilmService().searchByMultipleTypes(types, limit: 5, lastDocument: null);

      final List<FilmModel> films = result['films'] as List<FilmModel>;

      final DocumentSnapshot? lastDocument = result['lastDocument'] as DocumentSnapshot?;

      _films.addAll(films);

      _lastDocument = lastDocument;

      _hasMore = films.length == 5;

    } catch (e) {
      _errorMessage = 'Failed to search films: $e';
    }finally{
      _isSearching = false;
    }
  }

  Future<void> searchMoreFilmsByMultiType( {int limit = 5}) async {
    if (_isLoading || !_hasMore) return;
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      final result = await FilmService().searchByMultipleTypes(
        _selectedTypes!,
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

}
