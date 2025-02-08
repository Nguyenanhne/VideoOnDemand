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

  ScrollController sameFilmsController = ScrollController();

  List<FilmModel> _films = [];

  List<String> _types = ["Thể loại"];

  List<String> _years = ["Năm"];

  String? _selectedType;

  List<String>? _selectedTypes;

  String? _selectedYear;

  bool _hasMore = true;

  String? _errorMessage;

  DocumentSnapshot? _lastDocument;

  bool _isSearching = false;

  bool _isLoading = false;

  String? get selectedType => _selectedType;

  String? get selectedYear => _selectedYear;

  List<String> get types =>_types;

  List<String> get years => _years;

  bool get hasMore => _hasMore;

  bool get isSearching => _isSearching;

  bool get isLoading => _isLoading;

  String? get errorMessage => _errorMessage;

  List<FilmModel> get films => _films;

  SearchViewModel() {
    sameFilmsController.addListener(() {
      sameFilmsOnScroll();
    });
  }

  void onTap(BuildContext context, FilmModel film){
    NavigatorHelper.navigateTo(context, DetailedFilmScreen(film: film));
  }

  Future<void> getAllTypes() async  {
    final buffer =  await typeService.getAllTypes();
    _types.addAll(buffer);
  }

  Future<void> getYears() async{
    int currentYear = DateTime.now().year;
    _years.addAll(List<String>.generate(10, (index) => (currentYear - 9 + index).toString()));
  }

  Future<void> searchFilmsByTypeAndYear({required type, required year}) async {
    _selectedYear = year;
    _selectedType = type;
    _isSearching = true;
    notifyListeners();
    _films.clear();
    try {
      if (year == "Năm"){
        year = null;
      }
      if (type == "Thể loại"){
        type = null;
      }
      final result = await FilmService().searchByTypeAndYear(type: type, year: year, limit: 5, lastDocument: null);

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

  Future<void> searchMoreFilmsByTypeAndYear( {int limit = 5}) async {
    if (_isLoading || !_hasMore) return;
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      final String? year, type;
      if (_selectedYear == "Năm"){
        year = null;
      }else{
        year = _selectedYear;
      }
      if (_selectedType == "Thể loại"){
        type = null;
      }
      else{
        type = _selectedType;
      }

      final result = await FilmService().searchByTypeAndYear(
        year: year,
        type: type,
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
      final result = await FilmService().searchByMultipleTypes(types, limit: 3, lastDocument: null);

      final List<FilmModel> films = result['films'] as List<FilmModel>;

      final DocumentSnapshot? lastDocument = result['lastDocument'] as DocumentSnapshot?;

      _films.addAll(films);

      _lastDocument = lastDocument;

      _hasMore = films.length == 3;

    } catch (e) {
      _errorMessage = 'Failed to search films: $e';
    }finally{
      _isSearching = false;
    }
  }
  void sameFilmsOnScroll() {
    if (sameFilmsController.position.pixels == sameFilmsController.position.maxScrollExtent && !isLoading && hasMore) {
      searchMoreFilmsByMultiType();
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

  Future<void> reset() async{
    films.clear();
    _selectedType = null;
    _selectedYear = null;
  }
  @override
  void dispose() {
    sameFilmsController.dispose();
    super.dispose();
  }
}
