import 'package:du_an_cntt/view_models/signup_vm.dart';
import 'package:du_an_cntt/views/email_verification_link/email_verification_link_mobile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:quickalert/quickalert.dart';

import '../../services/firebase_authentication.dart';
import '../../view_models/home_vm.dart';

class SignUpScreenMobile extends StatefulWidget {
  const SignUpScreenMobile({super.key});

  @override
  State<SignUpScreenMobile> createState() => _SignUpScreenMobileState();
}

class _SignUpScreenMobileState extends State<SignUpScreenMobile> {
  final SignUpViewModel signUpVM = SignUpViewModel();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usenameController = TextEditingController();

  final Auth _firebaseAuth = Auth();

  var errorStyle = TextStyle(
      fontSize: 12.sp,
      color: Colors.red,
      fontFamily: GoogleFonts.roboto().fontFamily
  );

  var contentStyle = TextStyle(
      fontSize: 14.sp,
      color: Colors.black,
      fontFamily: GoogleFonts.roboto().fontFamily
  );

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
              child: Form(
                key: _formKey,
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
                    // Padding(
                    //   padding: EdgeInsets.symmetric(horizontal: 20.w),
                    //   child: Text(
                    //     "Nhập email để tạo tài khoản của bạn.",
                    //     style: TextStyle(
                    //         fontSize: 14.sp,
                    //         fontFamily: GoogleFonts.roboto().fontFamily,
                    //         color: Colors.grey[800]
                    //     ),
                    //     textAlign: TextAlign.start,
                    //   ),
                    // ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                      child: TextFormField(
                        controller: _emailController,
                        style: contentStyle,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Vui lòng nhập email';
                          } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                            return 'Email không hợp lệ';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          fillColor: Colors.grey[100],
                          filled: true,
                          labelText: "Nhập email của bạn",
                          labelStyle: TextStyle(color: Colors.black, fontFamily: GoogleFonts.roboto().fontFamily, fontSize: 16.sp),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          errorStyle: errorStyle
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        style: contentStyle,
                        decoration: InputDecoration(
                          fillColor: Colors.grey[100],
                          filled: true,
                          labelText: "Nhập mật khẩu",
                          labelStyle: TextStyle(color: Colors.black, fontFamily: GoogleFonts.roboto().fontFamily, fontSize: 16.sp),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          errorStyle: errorStyle
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Vui lòng nhập mật khẩu';
                          } else if (value.length < 6) {
                            return 'Mật khẩu phải có ít nhất 6 ký tự';
                          } else if (!RegExp(r'^(?=.*?[#?!@$%^&*-])').hasMatch(value)) {
                            return 'Mật khẩu cần chứa ít nhất một ký tự đặc biệt';
                          }
                          return null;
                        },
                      ),
                    ),
                    // Padding(
                    //   padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                    //   child: TextFormField(
                    //     style: TextStyle(
                    //         fontSize: 14.sp,
                    //         color: Colors.black,
                    //         fontFamily: GoogleFonts.roboto().fontFamily
                    //     ),
                    //     decoration: InputDecoration(
                    //       fillColor: Colors.grey[100],
                    //       filled: true,
                    //       labelText: "Nhập số điện thoại",
                    //       labelStyle: TextStyle(color: Colors.black, fontFamily: GoogleFonts.roboto().fontFamily, fontSize: 16.sp),
                    //       border: OutlineInputBorder(
                    //         borderRadius: BorderRadius.circular(5),
                    //       ),
                    //       floatingLabelBehavior: FloatingLabelBehavior.auto,
                    //     ),
                    //   ),
                    // ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                      child: TextFormField(
                        controller: _usenameController,
                        style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.black,
                            fontFamily: GoogleFonts.roboto().fontFamily
                        ),
                        decoration: InputDecoration(
                          fillColor: Colors.grey[100],
                          filled: true,
                          labelText: "Nhập tên hiển thị",
                          labelStyle: TextStyle(color: Colors.black, fontFamily: GoogleFonts.roboto().fontFamily, fontSize: 16.sp),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          errorStyle: errorStyle
                        ),
                        validator: (value){
                          if (value == null || value.isEmpty){
                            return 'Vui lòng nhập tên hiển thị';
                          }
                        },
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
                        onPressed: () async {
                          if (_formKey.currentState! .validate()) {
                            await _firebaseAuth.createUserWithEmailAndPassword(email: _emailController.text, password: _passwordController.text);

                            await QuickAlert.show(
                              context: context,
                              type: QuickAlertType.success,
                              title: "Còn 1 bước nữa",
                              text: "Vui lòng kiểm tra email và xác thực tài khoản",
                              onConfirmBtnTap: (){
                                signUpVM.onTapNavigateToScreen(context, EmailVerificationLinkMobile());
                              }
                            );

                          }
                        },
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
            ),
          ],
        ),
      ),
    );
  }
}
