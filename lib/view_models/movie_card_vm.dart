import 'package:du_an_cntt/helper/navigator.dart';
import 'package:du_an_cntt/services/FilmService.dart';
import 'package:du_an_cntt/views/detailed%20movie/detailed_movie_screen.dart';
import 'package:flutter/cupertino.dart';

import '../models/film_model.dart';

class MovieCardViewModel extends ChangeNotifier{

  final List<FilmModel> _films = [];

  List<FilmModel> get films => _films;

  void onTap(BuildContext context, String movieID){
    NavigatorHelper.navigateTo(context, DetailedMovieScreen(movieID: movieID));
  }

  Future<String> getImageUrl(String id) async {
    print(id);
    return FilmService().getImageUrl(id);
  }
}