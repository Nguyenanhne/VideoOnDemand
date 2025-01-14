import 'package:du_an_cntt/responsive.dart';
import 'package:du_an_cntt/views/detailed%20film/detailed_film_mobile.dart';
import 'package:du_an_cntt/views/detailed%20film/detailed_film_tablet.dart';
import 'package:du_an_cntt/views/detailed%20film/detailed_film_web.dart';
import 'package:flutter/material.dart';

class DetailedFilmScreen extends StatelessWidget {
  final String filmID;
  late final Widget mobileBody = DetailedMovieScreenMobile(filmID: filmID);
  late final Widget tabletBody = DetailedMovieScreenTablet(filmID: filmID);
  late final Widget webBody = DetailedMovieScreenTablet(filmID: filmID);
  DetailedFilmScreen({super.key, required this.filmID});
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(mobileLayout: DetailedMovieScreenMobile(filmID: filmID), tabletLayout: DetailedMovieScreenTablet(filmID: filmID), webLayout:DetailedMovieScreenWeb(filmID: filmID));
  }
}
