import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../utils.dart';
class MyNetflixScreenMobile extends StatefulWidget {
  const MyNetflixScreenMobile({super.key});

  @override
  State<MyNetflixScreenMobile> createState() => _MyNetflixScreenMobileState();
}

class _MyNetflixScreenMobileState extends State<MyNetflixScreenMobile> {
  final contentStyle = TextStyle(
    fontFamily: GoogleFonts.roboto().fontFamily,
    fontSize: 14.sp,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        backgroundColor: Colors.black,
        leading: Icon(
          Icons.arrow_back,
          color: Color(colorAppbarIcon),
        ),
        title: Text(
          "Netflix của tôi",
          style: contentStyle.copyWith(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.bold),
        ),
        actions: [
          InkWell(
              onTap: (){},
              child: const Icon(
                LineAwesomeIcons.download_solid,
                size: 30,
                color: Colors.white,
              )
          ),
          SizedBox(width: 15.w),
          InkWell(
              onTap: (){},
              child: const Icon(
                Icons.search,
                size: 30,
                color: Colors.white,
              )
          ),
          SizedBox(width: 20.w)
        ],
      ),
    );
  }
}
