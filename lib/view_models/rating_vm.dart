import 'package:du_an_cntt/models/film_model.dart';
import 'package:flutter/foundation.dart';

import '../services/film_service.dart';
import '../services/rating_service.dart';

class RatingViewModel extends ChangeNotifier {
  final RatingService ratingService = RatingService();
  final FilmService filmService = FilmService();

  int _totalLikes = 0;
  int _totalDislikes = 0;
  int _viewTotal = 0;

  int get totalLikes => _totalLikes;
  int get totalDislikes => _totalDislikes;
  int get viewTotal => _viewTotal;

  Future<void> fetchTotalLikes(String filmID) async {
    try {
      _totalLikes = await ratingService.getTotalLikesByFilmID(filmID);
    } catch (e) {
      print("Error fetching total likes: $e");
    }
  }
  Future<void> fetchTotalDislikes(String filmID) async {
    try {
      _totalDislikes = await ratingService.getTotalDisLikesByFilmID(filmID);
    } catch (e) {
      print("Error fetching total dislikes: $e");
    }
  }
  Future<void> fetchTotalView(String filmID) async{
    try {
      final film = await filmService.fetchFilmByID(filmID);
      if (film != null) {
        _viewTotal = film.viewTotal;
      }
    } catch(e){
      print("Error fetching total view: $e");
    }
  }
}
