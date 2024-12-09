import 'package:du_an_cntt/views/detailed%20movie/detailed_movie_mobile.dart';
import 'package:du_an_cntt/views/detailed%20movie/detailed_movie_tablet.dart';
import 'package:flutter/material.dart';

class DetailedMovieScreen extends StatelessWidget {
  DetailedMovieScreen({super.key});
  final Widget mobileBody = DetailedMovieScreenMobile();
  final Widget tabletBody = DetailedMovieScreenTablet();
  final Widget webBody = DetailedMovieScreenTablet();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 500) {
            return mobileBody;
          } else if (constraints.maxWidth < 1100) {
            return tabletBody;
          } else {
            return webBody;
          }
        }
    );
  }
}