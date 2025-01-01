import 'package:cached_network_image/cached_network_image.dart';
import 'package:du_an_cntt/models/film_model.dart';
import 'package:du_an_cntt/view_models/movie_card_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class MovieCardWidget extends StatelessWidget {
  final Future<List<FilmModel>> movies;
  final String headerLineText;

  const MovieCardWidget({
    super.key,
    required this.movies,
    required this.headerLineText,
  });

  @override
  Widget build(BuildContext context) {
    MovieCardViewModel viewModel = Provider.of<MovieCardViewModel>(context, listen: false);

    final heightScreen = MediaQuery.of(context).size.height
        - AppBar().preferredSize.height
        - MediaQuery.of(context).padding.top;

    return FutureBuilder<List<FilmModel>>(
      future: movies,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No movies available'));
        }
        var data = snapshot.data;
        return Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              child: Text(
                headerLineText,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
                ),
              ),
            ),
            Expanded(
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: data!.length,
                itemBuilder: (context, index) {
                  FilmModel movie = data[index];
                  return InkWell(
                    onTap: () {
                      viewModel.onTap(context, movie.id);
                    },
                    child: SizedBox(
                      width: heightScreen * 0.15,
                      child: Column(
                        children: [
                          Expanded(
                            child: CachedNetworkImage(
                              imageUrl: movie.url,
                              placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator(),
                              ),
                              errorWidget: (context, url, error) => const Icon(
                                Icons.error,
                                color: Colors.red,
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(height: 5.h),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(width: 10.w);
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
