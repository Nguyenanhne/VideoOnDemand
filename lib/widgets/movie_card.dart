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
            // Tiêu đề của danh sách phim
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
            // Danh sách phim theo chiều ngang
            Expanded(
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: data!.length,
                itemBuilder: (context, index) {
                  FilmModel movie = data[index];
                  return InkWell(
                    onTap: () {
                      viewModel.onTap(context);
                    },
                    child: SizedBox(
                      width: 150.w,
                      child: FutureBuilder<String>(
                        future: viewModel.getImageUrl(movie.id),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          if (snapshot.hasError || !snapshot.hasData) {
                            return Center(
                              child: Icon(Icons.error), // Hiển thị khi có lỗi
                            );
                          }

                          return Image.network(
                            snapshot.data!,
                            loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              } else {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            },
                          );
                        },
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
