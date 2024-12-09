import 'package:du_an_cntt/view_models/movie_card_vm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../models/movie_model.dart';
class MovieCardWidget extends StatelessWidget {
  final Future<MovieModel> movie ;
  final String headerLineText;
  const  MovieCardWidget({super.key, required this.movie, required this.headerLineText});

  @override
  Widget build(BuildContext context) {
    MovieCardViewModel viewModel = Provider.of<MovieCardViewModel>(context);
    return FutureBuilder(
      future: movie,
      builder: (context, snapshot){
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        var data = snapshot.data?.results;
        return Column(
          children: [
            Text(
              headerLineText,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20.h
            ),
            Expanded(
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: data!.length,
                itemBuilder: (context, index){
                  return InkWell(
                    onTap: (){
                      viewModel.onTap(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child: Image.network("https://image.tmdb.org/t/p/w500${data[index].posterPath}"),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(width: 5.w);
                },
              ),
            )
          ],
        );
      }
    );
  }
}
