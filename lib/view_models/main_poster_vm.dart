import 'package:du_an_cntt/models/film_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../helper/navigator.dart';
import '../services/FilmService.dart';
import '../services/MyListService.dart';
import '../services/firebase_authentication.dart';
import '../views/detailed film/detailed_film_screen.dart';

class MainPosterViewModel extends ChangeNotifier {
  final myListService = MyListService();

  FilmModel? _film;
  bool _hasInMyList = false;

  FilmModel? get film => _film;
  bool get hasInMyList => _hasInMyList;

  void onTap(BuildContext context, String filmID){
    NavigatorHelper.navigateTo(context, DetailedFilmScreen(filmID: filmID));
  }

  Future<void> fetchRandomFilm() async {
    try {
      FilmModel? film = await FilmService().fetchRandomFilm();
      if (film != null) {
        _film = film;
        print('Random Film fetched: ${film.name}');
      } else {
        print('Film not found!');
        _film = null;
      }
    } catch (e) {
      print('Error fetching random film: $e');
      _film = null;
    }
  }

  Future<void> getAddToListStatus(String filmID) async{
    final userID = await Auth().getUserID();
    _hasInMyList = await MyListService().isFilmInMyList(userID, filmID);
    // notifyListeners();
  }
  Future<void> toggleHasInMyList(String filmID) async {
    final userID = await Auth().getUserID();
    _hasInMyList = !_hasInMyList;

    if (_hasInMyList) {
      await myListService.addFilmToMyList(userID, filmID);
    } else {
      await myListService.removeFilmFromMyList(userID, filmID);
    }
    notifyListeners();
  }
}
