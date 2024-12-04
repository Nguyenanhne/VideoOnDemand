import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../helper/navigator.dart';
import '../../utils.dart';
import '../../widgets/comment and rating/rating_progress_indicator.dart';

class CommentScreenMobile extends StatefulWidget {
  const CommentScreenMobile({super.key});

  @override
  State<CommentScreenMobile> createState() => _CommentScreenMobileState();
}

class _CommentScreenMobileState extends State<CommentScreenMobile> {
  final contentStyle = TextStyle(
    fontFamily: GoogleFonts.roboto().fontFamily,
    color: Colors.black
  );
  var rate = 4.8;
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
      {"email": "anhlop755@gmai.com", "comment":"Phim hay qua a oi, Phim hay qua a oi,Phim hay qua a oi", "rate": 1},
      {"email": "anhlop755@gmai.com", "comment":"Phim hay qua a oi", "rate": 1},
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        titleSpacing: 0,
        elevation: 0,
        title: Text(
          "Đánh giá phim Titan",
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
        padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        rate.toString(),
                        style: contentStyle.copyWith(
                          fontSize: 50.sp,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      RatingBar.readOnly(
                        filledIcon: Icons.star,
                        emptyIcon: Icons.star_border,
                        initialRating: 4,
                        maxRating: 5,
                        size: 20,
                        alignment: Alignment.center,
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      RatingProgressIndicator(rating: '5', realValue: 0.5),
                      RatingProgressIndicator(rating: '4', realValue: 0.3),
                      RatingProgressIndicator(rating: '3', realValue: 0.1),
                      RatingProgressIndicator(rating: '2', realValue: 0.3),
                      RatingProgressIndicator(rating: '1', realValue: 0.4),
                    ],
                  )
                )
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
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              comment[index]["email"],
                              softWrap: true,
                              style: contentStyle.copyWith(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        leading: Image.asset(
                          "assets/user.jpg",
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 5.h),
                        child: Row(
                          children: [
                            RatingBar.readOnly(
                              filledIcon: Icons.star,
                              emptyIcon: Icons.star_border,
                              initialRating: 4,
                              maxRating: 5,
                              size: 20,
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.w),
                                child: Text(
                                  "01 Nov 2023",
                                  style: contentStyle.copyWith(fontSize: 13.sp),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Text(
                        comment[index]["comment"] ,
                        style: contentStyle.copyWith(
                            fontSize: 13.sp
                        ),
                      )
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

