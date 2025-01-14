import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../helper/navigator.dart';
import '../../utils.dart';
import '../../view_models/comment_vm.dart';
import '../../widgets/comment and rating/rating_progress_indicator.dart';

class CommentScreenTablet extends StatefulWidget {
  const CommentScreenTablet({super.key, required this.filmID});
  final String filmID;
  @override
  State<CommentScreenTablet> createState() => _CommentScreenTabletState();
}

class _CommentScreenTabletState extends State<CommentScreenTablet> {
  final contentStyle = TextStyle(
    fontFamily: GoogleFonts.roboto().fontFamily,
    color: Colors.black,
    fontSize: 13.sp
  );
  var sizeIcon = 50.0;
  late String filmID;
  late Future<List<dynamic>> combinedFuture;
  late Future<void> loadLikes;
  late Future<void> loadDisLikes;

  @override
  void initState() {
    super.initState();
    filmID = widget.filmID;
    final viewModel = Provider.of<CommentViewModel>(context, listen: false);
    loadLikes = viewModel.fetchTotalLikesByFilmID(filmID);
    loadDisLikes = viewModel.fetchTotalDislikesByFilmID(filmID);
  }
  @override
  Widget build(BuildContext context) {
    final heightScreen = MediaQuery.of(context).size.height
        - AppBar().preferredSize.height
        - MediaQuery.of(context).padding.top;
    final widthScreen = MediaQuery.of(context).size.width;
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
        toolbarHeight: 50.h,
        backgroundColor: Colors.black,
        titleSpacing: 0,
        elevation: 0,
        title: Text(
          "Đánh giá phim",
          style: contentStyle.copyWith(color: Colors.white, fontSize: 14.sp),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(colorAppbarIcon), size: iconTabletSize,),
          onPressed: () {
            NavigatorHelper.goBack(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(Icons.play_circle, color: Colors.blue, size: sizeIcon),
                    title: Text("500", style: contentStyle),
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
                            title: Text("error", style: contentStyle),
                          );
                        } else {
                          return Consumer<CommentViewModel>(
                            builder: (context, viewModel, child){
                              return ListTile(
                                contentPadding: EdgeInsets.zero,
                                leading: Icon(Icons.thumb_up, size: sizeIcon),
                                title: Text("${viewModel.totalLikes}", style: contentStyle),
                              );
                            },
                          );
                        }
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
                            title: Text("error", style: contentStyle),
                          );
                        } else {
                          return Consumer<CommentViewModel>(
                            builder: (context, viewModel, child){
                              return ListTile(
                                contentPadding: EdgeInsets.zero,
                                leading: Icon(Icons.thumb_down, size: sizeIcon, color: Colors.red),
                                title: Text("${viewModel.totalDislikes}",style: contentStyle),
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

