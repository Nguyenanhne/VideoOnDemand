import 'dart:async';
import 'dart:typed_data';

import 'package:du_an_cntt/helper/navigator.dart';
import 'package:du_an_cntt/utils.dart';
import 'package:du_an_cntt/view_models/email_verification_link_vm.dart';
import 'package:du_an_cntt/views/home/home_mobile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart'
;

import '../../services/firebase_authentication.dart';
class EmailVerificationLinkMobile extends StatefulWidget {
  const EmailVerificationLinkMobile({super.key});

  @override
  State<EmailVerificationLinkMobile> createState() => _EmailVerificationLinkMobileState();
}

class _EmailVerificationLinkMobileState extends State<EmailVerificationLinkMobile> {
  EmailVerificationLinkViewModel viewModel = EmailVerificationLinkViewModel();
  final firebaseAuth = Auth();
  User? user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    super.initState();
    firebaseAuth.sendEmailVerificationLink();
    viewModel.startEmailVerificationTimer(
      context,
      () {
          NavigatorHelper.navigateAndRemoveUntil(context, HomeScreenMobile());
        }
    );
  }
  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: Color(colorBg),
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
        body:  Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 50.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Row(),
              Image.asset(
                "assets/open-mail.png",
                height: 100.w,
                width: 100.w,
                color: Colors.white,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h),
                child: Text(
                  "VUI LÒNG XÁC THỰC EMAIL",
                  style: TextStyle(
                      fontFamily: GoogleFonts.roboto().fontFamily,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.sp,
                      color: Colors.white
                  ),
                ),
              ),
              Flexible(
                child: Text(
                  "Vui lòng kiểm tra hộp thư email của bạn để tìm liên kết xác minh tài khoản."
                      " Nếu bạn không thấy email, hãy kiểm tra thư mục Spam hoặc Quảng cáo.",
                  style: TextStyle(
                      fontFamily: GoogleFonts.roboto().fontFamily,
                      color: Colors.white,
                      fontSize: 14.sp
                  ),
                  textAlign: TextAlign.center,
                ),
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
                onTap: () async {
                  viewModel.ontapBackToLoginScreen(context);
                  await firebaseAuth.signOut();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.arrow_back, color: Colors.blueAccent),
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
