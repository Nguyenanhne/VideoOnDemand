import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../helper/navigator.dart';
import '../../utils.dart';

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
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        titleSpacing: 0,
        backgroundColor: Colors.black,
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
      body: Column(
        children: [
          Expanded(
            flex: 8,
            child: ListView.separated(
              itemBuilder: (context, index){
                return SizedBox(
                  // height: heightScreen*0.1,
                  child: ListTile(
                    title: Row(
                      children: [
                        Text(
                          comment[index]["email"],
                          style: contentStyle.copyWith(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.w),
                          child: Icon(
                            Icons.star,
                            color: Colors.yellow[900],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 2.w),
                          child: Text(
                            comment[index]["rate"].toString(),
                            style: contentStyle.copyWith(
                                color: Colors.yellow[900],
                                fontSize: 14.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                    subtitle: Text(
                      comment[index]["comment"] ,
                      style: contentStyle.copyWith(
                          fontSize: 13.sp
                      ),
                    ),
                    leading: CircleAvatar(),
                  ),
                );
              },
              separatorBuilder: (context, index) => const Divider(
                color: Colors.black,
              ),
              itemCount: comment.length)
          ),
          Expanded(
            child: Container(
              color: Colors.red,
            ),
          )
        ],
      ),
    );
  }
}
