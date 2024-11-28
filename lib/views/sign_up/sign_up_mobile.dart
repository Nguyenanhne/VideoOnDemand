import 'package:du_an_cntt/helper/navigator.dart';
import 'package:du_an_cntt/view_models/signup_vm.dart';
import 'package:du_an_cntt/views/email_verification_link/email_verification_link_mobile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usenameController = TextEditingController();

  final Auth firebaseAuth = Auth();

  var errorStyle = TextStyle(
      fontSize: 12,
      color: Colors.red,
      fontFamily: GoogleFonts.roboto().fontFamily
  );

  var contentStyle = TextStyle(
      fontSize: 14,
      color: Colors.black,
      fontFamily: GoogleFonts.roboto().fontFamily
  );
  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passwordController.dispose();
    usenameController.dispose();
    super.dispose();
  }
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
              onPressed: (){
                NavigatorHelper.goBack(context);
              },
              icon: const Icon(
                Icons.close
              ),
            )
          ],
        ),
        body: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: true,
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(height: MediaQuery.of(context).size.height/20),
                    Flexible(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Text(
                          "Bạn đã sẵn sàng xem chưa",
                          style: TextStyle(
                              fontSize: 28,
                              fontFamily: GoogleFonts.roboto().fontFamily,
                              fontWeight: FontWeight.bold,
                              color: Colors.black
                          ),
                          maxLines: 1,
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
                    Flexible(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                        child: TextFormField(
                          controller: emailController,
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
                            labelStyle: TextStyle(color: Colors.black, fontFamily: GoogleFonts.roboto().fontFamily, fontSize: 16),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                            errorStyle: errorStyle
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: TextFormField(
                          controller: passwordController,
                          obscureText: true,
                          style: contentStyle,
                          decoration: InputDecoration(
                            fillColor: Colors.grey[100],
                            filled: true,
                            labelText: "Nhập mật khẩu",
                            labelStyle: TextStyle(color: Colors.black, fontFamily: GoogleFonts.roboto().fontFamily, fontSize: 16),
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
                    ),
                    Flexible(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                        child: TextFormField(
                          controller: usenameController,
                          style: contentStyle,
                          decoration: InputDecoration(
                            fillColor: Colors.grey[100],
                            filled: true,
                            labelText: "Nhập tên hiển thị",
                            labelStyle: TextStyle(color: Colors.black, fontFamily: GoogleFonts.roboto().fontFamily, fontSize: 16),
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
                    ),
                    Flexible(
                      child: Container(
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
                            if (formKey.currentState! .validate()) {
                              await firebaseAuth.createUserWithEmailAndPassword(email: emailController.text, password: passwordController.text);
                              QuickAlert.show(
                                context: context,
                                type: QuickAlertType.success,
                                title: "Còn 1 bước nữa",
                                text: "Vui lòng kiểm tra email và xác thực tài khoản",
                                onConfirmBtnTap: () async {
                                  await NavigatorHelper.navigateAndRemoveUntil(context, const EmailVerificationLinkMobile());
                                }
                              );
                            }
                          },
                          child: Text(
                            "Bắt đầu",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: GoogleFonts.roboto().fontFamily,
                            ),
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
