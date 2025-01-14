import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../models/film_model.dart';
class FilmCard extends StatelessWidget {
  final double width;
  final FilmModel movie;
  final VoidCallback onTap;

  const FilmCard({
    Key? key,
    required this.movie,
    required this.onTap, required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final widthScreen = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: SizedBox(
          width: widthScreen*width,
          child: Column(
            children: [
              Expanded(
                child: CachedNetworkImage(
                  imageUrl: movie.url,
                  placeholder: (context, url) => Center(
                    child: Container(
                      color: Colors.grey[800],
                    ),
                  ),
                  errorWidget: (context, url, error) => const Icon(
                    Icons.error,
                    color: Colors.red,
                  ),
                  fit: BoxFit.fill,
                  width: double.infinity,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}