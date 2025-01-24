import 'package:du_an_cntt/view_models/rating_vm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../helper/navigator.dart';
import '../../utils.dart';

class CommentScreenMobile extends StatefulWidget {
  CommentScreenMobile({super.key, required this.filmID});
  final String filmID;
  @override
  State<CommentScreenMobile> createState() => _CommentScreenMobileState();
}

class _CommentScreenMobileState extends State<CommentScreenMobile> {
  final contentStyle = TextStyle(
    fontFamily: GoogleFonts.roboto().fontFamily,
    color: Colors.black,
  );
  var sizeIcon = 50.0;
  late String filmID;
  late Future<List<dynamic>> combinedFuture;
  late Future<void> loadLikes;
  late Future<void> loadDisLikes;
  late Future<void> loadTotalView;

  @override
  void initState() {
    super.initState();
    filmID = widget.filmID;
    final viewModel = Provider.of<RatingViewModel>(context, listen: false);
    loadLikes = viewModel.fetchTotalLikesByFilmID(filmID);
    loadDisLikes = viewModel.fetchTotalDislikesByFilmID(filmID);
    loadTotalView = viewModel.fetchTotalViewByFilmID(filmID);
  }
  @override
  Widget build(BuildContext context) {

    List comment =[
      {"email": "anhlop755@gmai.com", "comment":"Phim hay qua a oi", "rate": 1},
      {"email": "anhlop755@gmai.com", "comment":"Phim hay qua a oi", "rate": 3},
      {"email": "anhlop755@gmai.com", "comment":"Phim hay qua a oi", "rate": 4},
      {"email": "anhlop755@gmai.com", "comment":"Phim hay qua a oi", "rate": 5},
      {"email": "anhlop755@gmai.com", "comment":"Phim hay qua a oi", "rate": 3},
      {"email": "anhlop755@gmai.com", "comment":"Phim hay qua a oi", "rate": 1},
      {"email": "anhlop755@gmai.com", "comment":"Phim hay qua a oi", "rate": 1},
      {"email": "anhlop755@gmai.com", "comment":"Phim hay qua a oi", "rate": 1},
      {"email": "anhlop755@gmai.com", "comment":"Phim hay qua a oi", "rate": 1},
      {"email": "anhlop755@gmai.com", "comment":"Phim hay qua a oi", "rate": 1},
      {"email": "anhlop755@gmai.com", "comment":"Phim hay qua a oi", "rate": 1},
      {"email": "anhlop755@gmai.com", "comment":"Phim hay qua a oi", "rate": 1},

    ];
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        titleSpacing: 0,
        elevation: 0,
        title: Text(
          "Đánh giá phim",
          style: contentStyle.copyWith(color: Colors.white),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(colorAppbarIcon)),
          onPressed: () {
            NavigatorHelper.goBack(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        child: Column(
          children: [
            Row(
              children: [
                // Expanded(
                //   child: ListTile(
                //     contentPadding: EdgeInsets.zero,
                //     leading: Icon(Icons.play_circle, color: Colors.blue, size: sizeIcon),
                //     title: Text("500"),
                //   ),
                // ),
                Expanded(
                  child: FutureBuilder<void>(
                      future: loadTotalView,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: Icon(Icons.play_circle, size: sizeIcon),
                            title: CupertinoActivityIndicator(),
                          );
                        } else if (snapshot.hasError) {
                          return ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: Icon(Icons.play_circle, size: sizeIcon),
                            title: Text("error"),
                          );
                        } else {
                          return Consumer<RatingViewModel>(
                            builder: (context, viewModel, child){
                              return ListTile(
                                contentPadding: EdgeInsets.zero,
                                leading: Icon(Icons.play_circle, size: sizeIcon),
                                title: Text("${viewModel.viewTotal}"),
                              );
                            },
                          );
                        }
                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: Icon(Icons.thumb_up, color: Colors.grey,),
                          title: Text("500"),
                        );
                      }
                  ),
                ),
                Expanded(
                  child: FutureBuilder<void>(
                    future: loadLikes,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: Icon(Icons.thumb_up, size: sizeIcon),
                          title: CupertinoActivityIndicator(),
                        );
                      } else if (snapshot.hasError) {
                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: Icon(Icons.thumb_up, size: sizeIcon),
                          title: Text("error"),
                        );
                      } else {
                        return Consumer<RatingViewModel>(
                          builder: (context, viewModel, child){
                            return ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: Icon(Icons.thumb_up, size: sizeIcon),
                              title: Text("${viewModel.totalLikes}"),
                            );
                          },
                        );
                      }
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Icon(Icons.thumb_up, color: Colors.grey,),
                        title: Text("500"),
                      );
                    }
                  ),
                ),
                Expanded(
                  child: FutureBuilder<void>(
                      future: loadDisLikes,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: Icon(Icons.thumb_down, size: sizeIcon, color: Colors.red),
                            title: CupertinoActivityIndicator(),
                          );
                        } else if (snapshot.hasError) {
                          return ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: Icon(Icons.thumb_down, size: sizeIcon, color: Colors.red),
                            title: Text("error"),
                          );
                        } else {
                          return Consumer<RatingViewModel>(
                            builder: (context, viewModel, child){
                              return ListTile(
                                contentPadding: EdgeInsets.zero,
                                leading: Icon(Icons.thumb_down, size: sizeIcon, color: Colors.red),
                                title: Text("${viewModel.totalDislikes}"),
                              );
                            },
                          );
                        }
                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: Icon(Icons.thumb_up, color: Colors.grey,),
                          title: Text("500"),
                        );
                      }
                  ),
                ),

              ],
            ),
            SizedBox(height: 20.h),
            Expanded(
              flex: 8,
              child: ListView.separated(
                itemBuilder: (context, index){
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        title: Text(
                          comment[index]["email"],
                          softWrap: true,
                          style: contentStyle.copyWith(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        leading: Image.asset(
                          "assets/user.jpg",
                          fit: BoxFit.fitWidth,
                        ),
                        subtitle: Text(
                          comment[index]["comment"],
                          softWrap: true,
                          style: contentStyle.copyWith(
                            fontSize: 13.sp,
                          ),
                        ),
                      ),
                    ],
                  );
                },
                separatorBuilder: (context, index) => SizedBox(
                  height: 10.h,
                ),
                itemCount: comment.length)
            ),
          ],
        ),
      ),
    );
  }
}

