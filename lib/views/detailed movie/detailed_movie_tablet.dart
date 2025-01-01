import 'package:flutter/material.dart';
class DetailedMovieScreenTablet extends StatefulWidget {
  final String movieID;
  const DetailedMovieScreenTablet({super.key, required this.movieID});

  @override
  State<DetailedMovieScreenTablet> createState() => _DetailedMovieScreenTablet();
}

class _DetailedMovieScreenTablet extends State<DetailedMovieScreenTablet> {
  @override
  Widget build(BuildContext context) {
    return Text("tablet");
  }
}
