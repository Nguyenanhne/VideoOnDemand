import 'package:du_an_cntt/helper/navigator.dart';
import 'package:du_an_cntt/models/film_rating.dart';
import 'package:du_an_cntt/services/MyListService.dart';
import 'package:du_an_cntt/views/comment/comment_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/film_model.dart';
import '../resume_dialog.dart';
import '../services/FilmService.dart';
import '../services/RatingService.dart';
import '../services/firebase_authentication.dart';

class DetailedFilmViewModel extends ChangeNotifier {
  final myListService = MyListService();
  final ratingService = RatingService();
  final filmService = FilmService();

  bool _hasLiked = false;

  bool _hasDisliked = false;

  int _activeEpisode = 0;

  bool _hasInMyList = false;

  FilmModel? _film;

  int get activeEpisode => _activeEpisode;

  FilmModel? get film => _film;

  bool get hasInMyList => _hasInMyList;

  bool get hasLiked => _hasLiked;

  bool get hasDisliked => _hasDisliked;

  void setActiveEpisode(int index) {
    _activeEpisode = index;
    notifyListeners();
  }
  void playVideoOntap(BuildContext context, String filmID){
    NavigatorHelper.navigateTo(context, ResumeDialogPage(filmID:  filmID,));

  }
  void ratingOntap(BuildContext context, String filmID ){
    NavigatorHelper.navigateTo(context, CommentScreen(filmID: filmID));
  }

  Future<void> toggleHasInMyList(String filmID) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      print('User is not logged in');
      return;
    }
    String userID = user.uid;
    _hasInMyList = !_hasInMyList;

    if (_hasInMyList) {
      await myListService.addFilmToMyList(userID, filmID);
    } else {
      await myListService.removeFilmFromMyList(userID, filmID);
    }
    notifyListeners();
  }


  Future<void> getAddToListStatus(String filmID) async{
    final userID = await Auth().getUserID();
    _hasInMyList = await MyListService().isFilmInMyList(userID, filmID);
    // notifyListeners();
  }
  Future<void> getRating(String filmID) async {
    final userID = await Auth().getUserID();
    try {
      bool? ratingStatus = await ratingService.getRatingStatus(filmID, userID);

      if (ratingStatus != null) {
        if (ratingStatus) {
          _hasLiked = true;
          _hasDisliked = false;
        } else {
          _hasDisliked = true;
          _hasLiked = false;
        }
      } else {
        _hasLiked = false;
        _hasDisliked = false;
      }
      notifyListeners();
    } catch (e) {
      print("Error getting rating: $e");
    }
  }

  Future<void> toggleLike(String filmID) async {
    final userID = await Auth().getUserID();
    if (_hasLiked) {
      _hasLiked = false;
      await ratingService.deleteRating(filmID, userID);
    } else {
      _hasLiked = true;
      _hasDisliked = false;
      await ratingService.saveOrUpdateRating(RatingModel(id: '', filmID: filmID, userID: userID, rating: true));
      notifyListeners();
    }
  }
  Future<void> toggleDislike(String filmID) async {

    final userID = await Auth().getUserID();
    if (_hasDisliked) {
      _hasDisliked = false;
      await ratingService.deleteRating(filmID, userID);
    } else {
      _hasDisliked = true;
      _hasLiked = false;
      await ratingService.saveOrUpdateRating(RatingModel(id: '', filmID: filmID, userID: userID, rating: false));
    }
    notifyListeners();
  }

  Future<FilmModel?> getFilmDetails(String filmID) async {
    FilmModel? film = await FilmService().fetchFilmByID(filmID);
    if (film != null) {
        return film;
    }
    print('Film not found!');
    return null;
  }
  // Future<FilmModel?> getFilmDetails(FilmModel film) async {
  //   if (film != null) {
  //     return film;
  //   }
  //   print('Film not found!');
  //   return null;
  // }
  Future<void> updateViewTotal(String filmID) async{
    await filmService.updateTotalView(filmID);
  }

}