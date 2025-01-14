import 'package:flutter/foundation.dart';

import '../services/RatingService.dart';

class CommentViewModel extends ChangeNotifier {
  final RatingService ratingService = RatingService();

  int _totalLikes = 0;
  int _totalDislikes = 0;
  bool _isLoading = false;

  int get totalLikes => _totalLikes;
  int get totalDislikes => _totalDislikes;
  bool get isLoading => _isLoading;

  Future<void> fetchTotalLikesByFilmID(String filmID) async {
    _isLoading = true;
    try {
      _totalLikes = await ratingService.getTotalLikesByFilmID(filmID);
    } catch (e) {
      print("Error fetching total likes: $e");
    } finally {
      _isLoading = false;
    }
  }
  Future<void> fetchTotalDislikesByFilmID(String filmID) async {
    _isLoading = true;
    try {
      _totalDislikes = await ratingService.getTotalDisLikesByFilmID(filmID);
    } catch (e) {
      print("Error fetching total dislikes: $e");
    } finally {
      _isLoading = false;
    }
  }
}
