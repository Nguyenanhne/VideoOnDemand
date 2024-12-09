import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';

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
    final heightScreen = MediaQuery.of(context).size.height
        - AppBar().preferredSize.height
        - MediaQuery.of(context).padding.top;


    final widthScreen = MediaQuery.of(context).size.width;

    // final viewModel = Provider.of<DetailedMovieViewModel>(context);

    final heightBottomSheet = (MediaQuery.of(context).size.height - AppBar().preferredSize.height)/2.5;

    void showBottomSheet(BuildContext context) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return Container(
            height: heightBottomSheet,
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
            decoration: BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
            ),
            child: ListView(
              children: [
                ListTile(
                  leading: Icon(
                    LineAwesomeIcons.edit_solid,
                    size: 30,
                    color: Colors.white,
                  ),
                  title: Text(
                    "Quản lý hồ sơ",
                    style: contentStyle.copyWith(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.settings,
                    size: 30,
                    color: Colors.white,
                  ),
                  title: Text(
                    "Quản lý ứng dụng",
                    style: contentStyle.copyWith(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(
                    LineAwesomeIcons.user,
                    size: 30,
                    color: Colors.white,
                  ),
                  title: Text(
                    "Tài khoản",
                    style: contentStyle.copyWith(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.help,
                    size: 30,
                    color: Colors.white,
                  ),
                  title: Text(
                    "Trợ giúp",
                    style: contentStyle.copyWith(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(
                    LineAwesomeIcons.sign_out_alt_solid,
                    size: 30,
                    color: Colors.white,
                  ),
                  title: Text(
                    "Đăng xuất",
                    style: contentStyle.copyWith(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    };

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        backgroundColor: Colors.black,
        leading: InkWell(
          child: Icon(
            Icons.arrow_back,
            color: Color(colorAppbarIcon),
          ),
        ),
        title: Text(
          "Netflix của tôi",
          style: contentStyle.copyWith(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.bold),
        ),
        actions: [
          InkWell(
              onTap: (){
                showBottomSheet(context);
              },
              child: const Icon(
                Icons.search,
                size: 30,
                color: Colors.white,
              )
          ),
          InkWell(
              onTap: (){
                showBottomSheet(context);
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: const Icon(
                  Icons.menu,
                  size: 30,
                  color: Colors.white,
                ),
              )
          ),
        ],
      ),
    );
  }
}
