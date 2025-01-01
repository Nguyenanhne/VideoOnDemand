import 'package:du_an_cntt/views/detailed%20movie/detailed_movie_mobile.dart';
import 'package:du_an_cntt/views/detailed%20movie/detailed_movie_tablet.dart';
import 'package:flutter/material.dart';

class DetailedMovieScreen extends StatelessWidget {
  final String movieID;

  DetailedMovieScreen({super.key, required this.movieID});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 500) {
          // Mobile Layout
          return DetailedMovieScreenMobile(movieID: movieID);
        } else if (constraints.maxWidth < 1100) {
          // Tablet Layout
          return DetailedMovieScreenTablet(movieID: movieID);
        } else {
          // Web Layout
          return DetailedMovieScreenTablet(movieID: movieID);
        }
      },
    );
  }
}
