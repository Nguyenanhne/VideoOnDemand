import 'package:flutter/foundation.dart';

import '../models/film_model.dart';

class ContinueFilmCardViewModel extends ChangeNotifier{
  List<FilmModel> _film = [];


  List<FilmModel> get film => _film;
}