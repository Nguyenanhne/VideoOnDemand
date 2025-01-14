import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../models/film_model.dart';

class FilmCardByTypeViewModel extends ChangeNotifier{
  List<FilmModel> _films = [];

  bool _isLoading = false;

  bool _hasMore = true;

  String? _errorMessage;

  DocumentSnapshot? _lastDocument;

  bool get hasMore => _hasMore;

  bool get isLoading => _isLoading;

  String? get errorMessage => _errorMessage;

  List<FilmModel> get films => _films;


}