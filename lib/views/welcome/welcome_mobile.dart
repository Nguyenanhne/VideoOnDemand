import 'dart:ui'; // Để sử dụng BackdropFilter
import 'package:du_an_cntt/utils.dart';
import 'package:du_an_cntt/view_models/home_vm.dart';
import 'package:du_an_cntt/views/login/sign_in_mobile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../widgets/welcome/welcome_page.dart';
import '../sign_up/sign_up_mobile.dart';

class WelcomeScreenMobile extends StatefulWidget {
  const WelcomeScreenMobile({super.key});

  @override
  State<WelcomeScreenMobile> createState() => _WelcomeScreenMobileState();
}

class _WelcomeScreenMobileState extends State<WelcomeScreenMobile> {
  final HomeViewModel homeVM = HomeViewModel();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          titleSpacing: 0,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Container(
            padding: EdgeInsets.zero,
            child: Image.asset(
              "assets/logo.png",
              height: 50.h,
              width: 120.w,
            ),
          ),
          actions: [
            InkWell(
              onTap: () {},
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Text(
                  "QUYỀN RIÊNG TƯ",
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: Color(colorAppbarText),
                    fontWeight: FontWeight.bold,
                    fontFamily: GoogleFonts.roboto().fontFamily,
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: (){
                homeVM.onTapNavigateToScreen(context, SignInScreenMobile());
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Text(
                  "ĐĂNG NHẬP",
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: Color(colorAppbarText),
                    fontWeight: FontWeight.bold,
                    fontFamily: GoogleFonts.roboto().fontFamily,
                  ),
                ),
              ),
            ),
            PopupMenuButton(
              iconColor: Color(colorAppbarIcon),
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    child: Text(
                      "HỎI ĐÁP",
                      style: TextStyle(fontFamily: GoogleFonts.roboto().fontFamily),
                    ),
                  ),
                  PopupMenuItem(
                    child: Text(
                      "TRỢ GIÚP",
                      style: TextStyle(fontFamily: GoogleFonts.roboto().fontFamily),
                    ),
                  ),
                ];
              },
            ),
          ],
        ),
        body:            Stack(
          children: [
            PageView(
              children: [
                WelcomePage(
                  backgroundImage: "assets/welcome_bg.jpg",
                  title: 'Chương trình truyền hình, phim không giới hạn và nhiều nội dung khác !',
                  subtitle: "Xem ở mọi nơi. Huỷ bất kỳ lúc nào",
                ),
                WelcomePage(
                  backgroundImage: "assets/welcome_bg1.jpg",
                  title: 'Ai cũng tìm được gói dịch vụ phù hợp !',
                  subtitle: "Gói dịch vụ có giá từ 200 \$",
                ),
                WelcomePage(
                  backgroundImage: "assets/welcome_bg2.jpg",
                  title: 'Huỷ trực tuyến bất kỳ lúc nào !',
                  subtitle: "Hãy tham gia hôm nay, còn chần chừ gì nữa",
                ),
                WelcomePage(
                  backgroundImage: "assets/welcome_bg3.jpg",
                  title: 'Xem ở mọi nơi !',
                  subtitle: "Phát trực tuyến trên điện thoại, máy tính, máy tính bảng và máy tính xách tay của bạn",
                ),
              ],
            ),

            // Background image
            Column(
              children: [
                Expanded(child: Container()),
                Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 10.w),
                  height: MediaQuery.of(context).size.height / 10,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.red.withOpacity(0.2),
                        offset: Offset(2, 2),
                        blurRadius: 30,
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red[600],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)
                        ),
                        elevation: 10
                    ),
                    onPressed: (){
                      homeVM.onTapNavigateToScreen(context, SignUpScreenMobile());
                    },
                    child: Text(
                      "Bắt đầu",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontFamily: GoogleFonts.roboto().fontFamily,
                        shadows: const [
                          Shadow(
                              offset: Offset(2.0, 2.0),
                              blurRadius: 1.0,
                              color: Colors.black
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        )
      ),
    );
  }
}
