import 'package:du_an_cntt/models/film_model.dart';
import 'package:du_an_cntt/responsive.dart';
import 'package:du_an_cntt/views/detailed%20film/detailed_film_mobile.dart';
import 'package:du_an_cntt/views/detailed%20film/detailed_film_tablet.dart';
import 'package:du_an_cntt/views/detailed%20film/detailed_film_web.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../view_models/film_detail_vm.dart';
import '../../view_models/search_vm.dart';

class DetailedFilmScreen extends StatefulWidget {
  final FilmModel film;
  const DetailedFilmScreen({super.key, required this.film});

  @override
  State<DetailedFilmScreen> createState() => _DetailedFilmScreenState();
}

class _DetailedFilmScreenState extends State<DetailedFilmScreen> {
  late String filmID;
  late List<String> filmTypes;
  late String filmUrlVideo;
  late Future<void> fetchSameFilms;
  late Future<List<dynamic>> combinedFuture;
  @override
  void initState() {
    super.initState();
    final filmVM = Provider.of<DetailedFilmViewModel>(context, listen: false);
    final searchVM = Provider.of<SearchViewModel>(context, listen: false);
    filmID = widget.film.id;
    filmTypes = widget.film.type;
    //filmUrlVideo = "https://filmfinder.shop/input_video.mp4";
    combinedFuture = Future.wait([
      filmVM.getFilmDetails(filmID),
      filmVM.getAddToListStatus(filmID),
      filmVM.getRating(filmID)
    ]);
    fetchSameFilms = searchVM.searchFilmsByMultipleType(filmTypes);
    filmVM.initializeVideoPlayer(filmID: filmID);
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileLayout: DetailedMovieScreenMobile(film: widget.film, fetchSameFilms: fetchSameFilms, combinedFuture: combinedFuture),
      tabletLayout: DetailedMovieScreenTablet(film: widget.film, fetchSameFilms: fetchSameFilms, combinedFuture: combinedFuture),
      webLayout:DetailedMovieScreenWeb(film: widget.film, fetchSameFilms: fetchSameFilms, combinedFuture: combinedFuture)
    );
  }
}
