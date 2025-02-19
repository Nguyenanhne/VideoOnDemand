
import 'package:du_an_cntt/helper/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../utils/utils.dart';

class MyAccountScreenWeb extends StatefulWidget {
  const MyAccountScreenWeb({super.key});

  @override
  State<MyAccountScreenWeb> createState() => _MyAccountScreenWebState();
}

class _MyAccountScreenWebState extends State<MyAccountScreenWeb> {
  final contentStyle = TextStyle(
    fontFamily: GoogleFonts.roboto().fontFamily,
    fontSize: 30,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        backgroundColor: Colors.black,
        title: Stack(
            children: [
              Center(
                child: Container(
                  padding: EdgeInsets.zero,
                  child: Image.asset(
                    "assets/logo.png",
                    width: 50.w,
                  ),
                ),
              ),
              Positioned(
                left: 0,
                top: 0,
                bottom: 0,
                child: Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: InkWell(
                    onTap: (){
                      NavigatorHelper.goBack(context);
                    },
                    child: Icon(
                      size: iconTabletSize,
                      Icons.arrow_back,
                      color: Color(colorAppbarIcon),
                    ),
                  ),
                ),
              ),
            ]
        ),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    child: ListTile(
                      title: Text(
                        "Tài khoản",
                        style: contentStyle.copyWith(fontSize: 35, fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      subtitle: Row(
                        children: [
                          Icon(
                            LineAwesomeIcons.access_time,
                            color: Colors.red,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5.w),
                            child: Text(
                              "Thành viên từ tháng 5 năm 2023",
                              style: contentStyle.copyWith(fontSize: 30, color: Colors.black87),
                            ),
                          ),
                        ],
                      ),
                      trailing: Image.asset("assets/user.png"),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
