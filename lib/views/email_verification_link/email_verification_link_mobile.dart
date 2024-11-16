import 'package:du_an_cntt/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
class EmailVerificationLinkMobile extends StatefulWidget {
  const EmailVerificationLinkMobile({super.key});

  @override
  State<EmailVerificationLinkMobile> createState() => _EmailVerificationLinkMobileState();
}

class _EmailVerificationLinkMobileState extends State<EmailVerificationLinkMobile> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(colorBg),
        appBar: AppBar(
          titleSpacing: 0,
          backgroundColor: Colors.black,
          title: Container(
            padding: EdgeInsets.zero,
            child: Image.asset(
                "assets/logo.png",
                height: 50.h,
                width: 120.w
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 50.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Row(),
              Image.asset(
                "assets/open-mail.png",
                height: 100.w,
                width: 100.w,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h),
                child: Text(
                  "VUI LÒNG XÁC THỰC EMAIL",
                  style: TextStyle(
                    fontFamily: GoogleFonts.roboto().fontFamily,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.sp,
                    color: Colors.black
                  ),
                ),
              ),
              Text(
                "Vui lòng kiểm tra hộp thư email của bạn để tìm liên kết xác minh tài khoản."
                    " Nếu bạn không thấy email, hãy kiểm tra thư mục Spam hoặc Quảng cáo.",
                style: TextStyle(
                  fontFamily: GoogleFonts.roboto().fontFamily,
                  color: Colors.black,
                  fontSize: 14.sp
                ),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h),
                child: GestureDetector(
                  child: Text(
                    "Gửi lại email",
                    style: TextStyle(
                        fontFamily: GoogleFonts.roboto().fontFamily,
                        color: Colors.blueAccent,
                        fontSize: 16.sp
                    ),
                  )
                ),
              ),
              GestureDetector(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.arrow_back, color: Colors.blueAccent),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Text(
                        "Quay lại trang đăng nhập",
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontFamily: GoogleFonts.roboto().fontFamily,
                          fontSize: 16.sp
                        )
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
