import 'dart:ui';
import 'package:du_an_cntt/utils.dart';
import 'package:du_an_cntt/view_models/home_vm.dart';
import 'package:du_an_cntt/views/sign_in/sign_in_screen.dart';
import 'package:du_an_cntt/views/sign_up/sign_up_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../widgets/welcome/welcome_page.dart';
import '../sign_in/sign_in_mobile.dart';
import '../sign_up/sign_up_mobile.dart';
class WelComeScreenWeb extends StatefulWidget {
  const WelComeScreenWeb({super.key});

  @override
  State<WelComeScreenWeb> createState() => _WelcomeScreenWeb();
}

class _WelcomeScreenWeb extends State<WelComeScreenWeb> {
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
                width: 50.w,
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
                      fontSize: 25,
                      color: Color(colorAppbarText),
                      fontWeight: FontWeight.bold,
                      fontFamily: GoogleFonts.roboto().fontFamily,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: (){
                  homeVM.onTapNavigateToScreen(context, SignInScreen());
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Text(
                    "ĐĂNG NHẬP",
                    style: TextStyle(
                      fontSize: 25,
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
          body: Stack(
            children: [
              PageView(
                children: [
                  WelcomePage(
                    backgroundImage: "assets/welcome_bg_landscape.png",
                    title: 'Chương trình truyền hình, phim không giới hạn và nhiều nội dung khác !',
                    subtitle: "Xem ở mọi nơi. Huỷ bất kỳ lúc nào",
                  ),
                  WelcomePage(
                    backgroundImage: "assets/welcome_bg1_landscape.png",
                    title: 'Ai cũng tìm được gói dịch vụ phù hợp !',
                    subtitle: "Gói dịch vụ có giá từ 200 \$",
                  ),
                  WelcomePage(
                    backgroundImage: "assets/welcome_bg2_landscape.png",
                    title: 'Huỷ trực tuyến bất kỳ lúc nào !',
                    subtitle: "Hãy tham gia hôm nay, còn chần chừ gì nữa",
                  ),
                  WelcomePage(
                    backgroundImage: "assets/welcome_bg3_landscape.png",
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
                        homeVM.onTapNavigateToScreen(context, SignUpScreen());
                      },
                      child: Text(
                        "Bắt đầu",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 45,
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
