import 'dart:async';

import 'package:du_an_cntt/view_models/email_verification_link_vm.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helper/navigator.dart';
import '../../services/firebase_authentication.dart';
import '../bottom_navbar.dart';
class EmailVerificationLinkMobile extends StatefulWidget {
  const EmailVerificationLinkMobile({super.key});

  @override
  State<EmailVerificationLinkMobile> createState() => _EmailVerificationLinkMobileState();
}

class _EmailVerificationLinkMobileState extends State<EmailVerificationLinkMobile> {

  final firebaseAuth = Auth();
  User? user = FirebaseAuth.instance.currentUser;

  Timer? _timer;

  @override
  void initState()  {
    super.initState();
    firebaseAuth.sendEmailVerificationLink();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModel = Provider.of<EmailVerificationLinkViewModel>(context, listen: false);
      viewModel.startCountdown();
      viewModel.startEmailVerificationTimer(
          context,
              () {
            NavigatorHelper.navigateAndRemoveUntil(context, BottomNavBar());
          }
      );
    });

  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<EmailVerificationLinkViewModel>(context);

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
                child: viewModel.isTimeUp ? GestureDetector(
                  onTap: () async {
                    await firebaseAuth.sendEmailVerificationLink();
                    viewModel.resetCountdown();
                  },
                    child: Text(
                      "Gửi lại email",
                      style: TextStyle(
                          fontFamily: GoogleFonts.roboto().fontFamily,
                          color: Colors.blueAccent,
                          fontSize: 16.sp
                      ),
                    )
                ) : Text(
                  '${viewModel.remainingTime} giây',
                  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
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
