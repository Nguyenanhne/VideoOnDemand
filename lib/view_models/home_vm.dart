import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../helper/navigator.dart';
import '../models/film_model.dart';
import '../services/FilmService.dart';
import '../services/TypeService.dart';
import '../views/detailed film/detailed_film_screen.dart';

class HomeViewModel extends ChangeNotifier{

  final ScrollController homeScrollController = ScrollController();

  HomeViewModel() {
    homeScrollController.addListener(() {
      final offset = homeScrollController.offset;
      updateAppBarColor(offset);
    });
  }

  Color? _appBarColor = Colors.transparent;

  final TypeService typeService = TypeService();

  List<String> _types = [];

  Map<String, bool> _isMoreLoading = {};

  Map<String, bool> _isLoading = {};

  Map<String, List<FilmModel>> _filmsTypes = {};

  Map<String, ScrollController> scrollControllers = {};

  Map<String, bool> _hasMore = {};

  Map<String, DocumentSnapshot?> _lastDocument = {};

  Map<String, bool> get isMoreLoading => _isMoreLoading;

  Map<String, bool> get isLoading => _isLoading;

  List<String> get types => _types;

  Color? get appBarColor => _appBarColor;

  Map<String, List<FilmModel>> get filmsTypes => _filmsTypes;


  void updateAppBarColor(double offset) {
    if (offset > 50) {
      _appBarColor = Color.fromRGBO(1,1,1, 0.8);
    } else {
      _appBarColor = Colors.transparent;
    }
    notifyListeners();
  }


  void onTapNavigateToScreen(BuildContext context, Widget targetScreen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => targetScreen),
    );
  }
  void filmOnTap(BuildContext context, String filmID){
    NavigatorHelper.navigateTo(context, DetailedFilmScreen(filmID: filmID));
  }

  Future<void> getAllTypes() async {
    final buffer = await typeService.getAllTypes();
    _types = [];
    _types.addAll(buffer);
    for (final type in _types) {
      _isMoreLoading[type] = false;
      _isLoading[type] = false;
      _filmsTypes[type] = [];
      _hasMore[type] = true;
      _lastDocument[type] = null;

      scrollControllers[type] = ScrollController()
        ..addListener(() {
          if (scrollControllers[type]!.offset >=
              scrollControllers[type]!.position.maxScrollExtent &&
              !_isMoreLoading[type]! &&
              _hasMore[type] == true) {
            searchMoreFilmsByType(type);
          }
        });
    }
  }

  Future<void> searchFilmsByAllTypes() async {
    _filmsTypes.clear();
    try {
      for (final type in _types) {
        _isLoading[type] = true;
        notifyListeners();
        try {
          final result = await FilmService().searchByTypeAndYear(
            type: type,
            limit: 5,
            lastDocument: null,
            year: null
          );

          final List<FilmModel> films = result['films'] as List<FilmModel>;

          final DocumentSnapshot? lastDocument = result['lastDocument'] as DocumentSnapshot?;

          if (films.isNotEmpty) {
            _filmsTypes[type] = films;
            _lastDocument[type] = lastDocument;
            _hasMore[type] = films.length == 5;
          } else {
            _hasMore[type] = false;
          }
          // scrollControllers[type] = ScrollController()
          //   ..addListener(() {
          //     if (scrollControllers[type]!.offset >=
          //         scrollControllers[type]!.position.maxScrollExtent &&
          //         !_isMoreLoading[type]! &&
          //         _hasMore[type] == true) {
          //       searchMoreFilmsByType(type);
          //     }
          //   });
          _isLoading[type] = false;
          notifyListeners();
        } catch (e) {
          print('Lỗi khi lấy phim cho thể loại $type: $e');
        }finally{
          _isLoading[type] = false;
          notifyListeners();
        }
      }
    } catch (e) {
      print('Lỗi khi lấy danh sách thể loại: $e');
    }
  }

  Future<void> searchMoreFilmsByType(String type, {int limit = 5}) async {
    if (_isMoreLoading[type] == true || _hasMore[type] == false) return;

    _isMoreLoading[type] = true;
    notifyListeners();

    try {
      final result = await FilmService().searchByTypeAndYear(
        type: type,
        limit: limit,
        lastDocument: _lastDocument[type],
        year: null
      );

      final List<FilmModel> films = result['films'] as List<FilmModel>;
      final DocumentSnapshot? lastDocument = result['lastDocument'] as DocumentSnapshot?;

      if (films.isNotEmpty) {
        _filmsTypes[type]!.addAll(films);
        _lastDocument[type] = lastDocument;
        _hasMore[type] = films.length == limit;
      } else {
        _hasMore[type] = false;
      }
    } catch (e) {
      print('Lỗi khi tải thêm phim cho thể loại $type: $e');
    } finally {
      _isMoreLoading[type] = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    scrollControllers.forEach((key, controller){
      controller.dispose();
    });
    super.dispose();
  }
}