import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../view_models/home_vm.dart';

class SignUpScreenMobile extends StatefulWidget {
  const SignUpScreenMobile({super.key});

  @override
  State<SignUpScreenMobile> createState() => _SignUpScreenMobileState();
}

class _SignUpScreenMobileState extends State<SignUpScreenMobile> {
  final HomeViewModel homeVM = HomeViewModel();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          actions: [
            IconButton(
              onPressed: (){},
              icon: const Icon(
                Icons.close
              ),
            )
          ],
        ),
        body: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(height: MediaQuery.of(context).size.height/20),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Text(
                      "Bạn đã sẵn sàng xem chưa",
                      style: TextStyle(
                          fontSize: 28.sp,
                          fontFamily: GoogleFonts.roboto().fontFamily,
                          fontWeight: FontWeight.bold,
                          color: Colors.black
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Text(
                      "Nhập email để tạo tài khoản của bạn.",
                      style: TextStyle(
                          fontSize: 14.sp,
                          fontFamily: GoogleFonts.roboto().fontFamily,
                          color: Colors.grey[800]
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                    child: TextFormField(
                      style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.black,
                          fontFamily: GoogleFonts.roboto().fontFamily
                      ),
                      decoration: InputDecoration(
                        fillColor: Colors.grey[100],
                        filled: true,
                        labelText: "Nhập email của bạn",
                        labelStyle: TextStyle(color: Colors.black, fontFamily: GoogleFonts.roboto().fontFamily, fontSize: 16.sp),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                      ),
                    ),
                  ),
                  Container(
                    width: double.maxFinite,
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          // elevation: 10,
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)
                          ),
                          // side: BorderSide(
                          //   color: Colors.white,
                          //   width: 1
                          // )
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
                ]
              ),
            ),
          ],
        ),
      ),
    );
  }
}
