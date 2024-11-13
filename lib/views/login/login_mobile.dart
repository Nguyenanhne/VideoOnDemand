import 'package:du_an_cntt/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
class LoginScreenMobile extends StatefulWidget {
  const LoginScreenMobile({super.key});

  @override
  State<LoginScreenMobile> createState() => _LoginScreenMobileState();
}

class _LoginScreenMobileState extends State<LoginScreenMobile> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Container(
            child: Image.asset(
              "assets/logo.png",
              height: 50.h,
              width: 120.w,
            ),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Color(colorAppbarIcon)),
            onPressed: () {  },
          ),
        ),
        body: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                      child: TextFormField(
                        style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.grey[400],
                            fontFamily: GoogleFonts.roboto().fontFamily
                        ),
                        decoration: InputDecoration(
                          fillColor: Colors.grey[800],
                          filled: true,
                          labelText: "Email hoặc số điện thoại",
                          labelStyle: TextStyle(color: Colors.grey[400], fontFamily: GoogleFonts.roboto().fontFamily, fontSize: 16.sp),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: TextFormField(
                        obscureText: true,
                        style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.grey[400],
                            fontFamily: GoogleFonts.roboto().fontFamily
                        ),
                        decoration: InputDecoration(
                          fillColor: Colors.grey[800],
                          filled: true,
                          labelText: "Mật khẩu",
                          labelStyle: TextStyle(color: Colors.grey[400], fontFamily: GoogleFonts.roboto().fontFamily, fontSize: 16.sp),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                        ),
                      ),
                    ),
                    Container(
                      width: double.maxFinite,
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          elevation: 10,
                          backgroundColor: Colors.black12,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)
                          ),
                          side: BorderSide(
                            color: Colors.white,
                            width: 1
                          )
                        ),
                        onPressed: (){},
                        child: Text(
                          "Bắt đầu",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            fontFamily: GoogleFonts.roboto().fontFamily,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Text(
                        "Hoặc",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontFamily: GoogleFonts.roboto().fontFamily,
                        ),
                      ),
                    ),
                    Container(
                      width: double.maxFinite,
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            elevation: 10,
                            backgroundColor: Colors.grey[900],
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)
                            ),
                            side: BorderSide(
                                color: Colors.white,
                                width: 1
                            )
                        ),
                        onPressed: (){},
                        child: Text(
                          "Dùng mã đăng nhập",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            fontFamily: GoogleFonts.roboto().fontFamily,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                      child: Text(
                        "Bạn quên mật khẩu?",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontFamily: GoogleFonts.roboto().fontFamily,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                      child: Text(
                        "Bạn mới sử dụng Netflix. Đăng ký ngay!",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontFamily: GoogleFonts.roboto().fontFamily,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        )
      ),
    );
  }
}
