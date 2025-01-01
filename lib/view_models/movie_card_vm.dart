import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:du_an_cntt/helper/navigator.dart';
import 'package:du_an_cntt/services/MovieService.dart';
import 'package:du_an_cntt/views/detailed%20movie/detailed_movie_screen.dart';
import 'package:flutter/cupertino.dart';

import '../models/movie_model.dart';

class MovieCardViewModel extends ChangeNotifier{

  final List<MovieModel> _films = [];

  List<MovieModel> get films => _films;

  bool _isLoading = false;
  String? _errorMessage;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  void onTap(BuildContext context, String movieID){
    NavigatorHelper.navigateTo(context, DetailedMovieScreen(movieID: movieID));
  }

  Future<String> getImageUrl(String id) async {
    print(id);
    return MovieService().getImageUrl(id);
  }

  Future<void> fetchFilms({int limit = 10, DocumentSnapshot? lastDocument}) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final List<MovieModel> films = await MovieService().fetchListFilm(limit: limit, lastDocument: lastDocument);
      _films.addAll(films);
    } catch (e) {
      _errorMessage = 'Failed to load movies: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}