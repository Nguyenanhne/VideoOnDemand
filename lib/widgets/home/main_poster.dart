import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:du_an_cntt/view_models/main_poster_vm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../models/film_model.dart';

class MainPoster extends StatefulWidget {
  final double fontSize;
  final double iconSize;
  MainPoster({super.key, required this.fontSize, required this.iconSize});

  @override
  State<MainPoster> createState() => _MainPosterState();
}

class _MainPosterState extends State<MainPoster> {

  var borderRadius = 20.0;
  var blur = 1.0;

  late Future<void> fetchRandomFilm;
  late Future<void> getAddToList;

  @override
  Widget build(BuildContext context) {

    final mainPosterVM = Provider.of<MainPosterViewModel>(context, listen: false);

    final style = TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: widget.fontSize,
        fontFamily: GoogleFonts.roboto().fontFamily
    );

    final double iconSize = widget.iconSize;
    return Consumer<MainPosterViewModel>(
      builder: (context, viewModel, child){
        if (viewModel.film == null){
          return CupertinoActivityIndicator();
        }
        FilmModel film = viewModel.film!;
        getAddToList = viewModel.getAddToListStatus(film.id);
        return Card(
          elevation: 5.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: BorderSide(color: Colors.white, width: 1.w),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(borderRadius),
            child: Stack(
              fit: StackFit.expand,
              children: [
                CachedNetworkImage(
                  imageUrl: film.url,
                  placeholder: (context, url) => Center(
                    child: Container(
                      color: Colors.grey[800],
                    ),
                  ),
                  errorWidget: (context, url, error) =>
                  const Icon(
                    Icons.error,
                    color: Colors.red,
                  ),
                  fit: BoxFit.fill,
                  width: double.infinity,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(bottomRight: Radius.circular(20), bottomLeft: Radius.circular(20)),
                    ),
                    child: ClipRRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
                        child: Padding(
                          padding: EdgeInsets.only(left: 15, right: 15, bottom: 15, top: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                child: TextButton.icon(
                                  onPressed: () {
                                    viewModel.onTap(context, film);
                                  },
                                  icon: Icon(Icons.play_arrow, color: Colors.black, size: iconSize),
                                  label: Text(
                                    "Phát",
                                    style: style.copyWith(color: Colors.black),
                                  ),
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(Colors.white),
                                    foregroundColor: MaterialStateProperty.all(Colors.white),
                                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    )),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Expanded(
                                child: TextButton.icon(
                                  onPressed: () {
                                    viewModel.toggleHasInMyList(film.id);
                                  },
                                  icon: FutureBuilder(
                                      future: getAddToList,
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState == ConnectionState.waiting) {
                                          return CupertinoActivityIndicator();
                                        }
                                        return Icon(viewModel.hasInMyList ? Icons.check : Icons.add, color: Colors.white, size: iconSize);
                                      }
                                  ),
                                  label: Text(
                                      "Danh sách",
                                      style: style
                                  ),
                                  style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all(Colors.grey[600]),
                                      foregroundColor: MaterialStateProperty.all(Colors.white),
                                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ))
                                  ),
                                )
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
