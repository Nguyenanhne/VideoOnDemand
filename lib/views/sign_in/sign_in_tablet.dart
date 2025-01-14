import 'package:du_an_cntt/helper/navigator.dart';
import 'package:du_an_cntt/utils.dart';
import 'package:du_an_cntt/view_models/sign_in_vm.dart';
import 'package:du_an_cntt/views/forgot_password/forgot_password_mobile.dart';
import 'package:du_an_cntt/views/sign_up/sign_up_mobile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';
import 'package:tap_debouncer/tap_debouncer.dart';

import '../../services/firebase_authentication.dart';
import '../bottom_navbar.dart';
import '../email_verification_link/email_verification_link_screen.dart';
class SignInScreenTablet extends StatefulWidget {
  const SignInScreenTablet({super.key});

  @override
  State<SignInScreenTablet> createState() => _SignInScreenTabletState();
}

class _SignInScreenTabletState extends State<SignInScreenTablet> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final SignInViewModel signInViewModel = SignInViewModel();

  var contentStyle = TextStyle(
      fontSize: 16.sp,
      color: Colors.grey[400],
      fontFamily: GoogleFonts.roboto().fontFamily
  );
  var contenPadding = 30.0;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<SignInViewModel>(context);

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
              icon: Icon(Icons.arrow_back, color: Color(colorAppbarIcon),size: iconTabletSize,),
              onPressed: () {
                NavigatorHelper.goBack(context);
              },
            ),
          ),
          body: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                      child: TextFormField(
                        controller: emailController,
                        style: contentStyle,
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
                        controller: passwordController,
                        obscureText: true,
                        style: contentStyle,
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
                    // TapDebouncer(
                    //   onTap: () async => await () async {
                    //     showDialog(
                    //         context: context,
                    //         barrierDismissible: false,
                    //         builder: (context){
                    //           return Center(child: CircularProgressIndicator());
                    //         }
                    //     );
                    //     User? user = await viewModel.Login(context: context, email: emailController.text.trim(), password: passwordController.text.trim());
                    //     Navigator.pop(context);
                    //     await Future.delayed(Duration(milliseconds: 500));
                    //     if (user != null){
                    //       QuickAlert.show(
                    //           context: context,
                    //           type: QuickAlertType.success,
                    //           text: "Đăng nhập thành công",
                    //           title: "THÀNH CÔNG",
                    //           onConfirmBtnTap: () async {
                    //             if (await Auth().isEmailVerified()){
                    //               await NavigatorHelper.navigateAndRemoveUntil(context, BottomNavBar());
                    //             }
                    //             else{
                    //               await NavigatorHelper.navigateAndRemoveUntil(context, EmailVerificationLink());
                    //             }
                    //           }
                    //       );
                    //     }
                    //     else{
                    //       QuickAlert.show(
                    //           context: context,
                    //           type: QuickAlertType.error,
                    //           text: "Tên đăng nhập hoặc mật khẩu không hợp lệ",
                    //           title: "THẤT BẠI",
                    //           onConfirmBtnTap: () async {
                    //             NavigatorHelper.goBack(context);
                    //           }
                    //       );
                    //     }
                    //   },
                    //   builder: (BuildContext context, Future<void> Function()? onTap) {
                    //     return Container(
                    //       width: double.maxFinite,
                    //       padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                    //       child: ElevatedButton(
                    //         style: ElevatedButton.styleFrom(
                    //             padding: EdgeInsets.symmetric(vertical: 10.h),
                    //             elevation: 10,
                    //             backgroundColor: Colors.black12,
                    //             shape: RoundedRectangleBorder(
                    //                 borderRadius: BorderRadius.circular(5)
                    //             ),
                    //             side: BorderSide(
                    //                 color: Colors.white,
                    //                 width: 1
                    //             )
                    //         ),
                    //         onPressed: onTap,
                    //         child: Text(
                    //           "Bắt đầu",
                    //           style: TextStyle(
                    //             color: Colors.white,
                    //             fontSize: 16.sp,
                    //             fontWeight: FontWeight.bold,
                    //             fontFamily: GoogleFonts.roboto().fontFamily,
                    //           ),
                    //         ),
                    //       ),
                    //     );
                    //   },
                    // ),
                    TapDebouncer(
                      onTap: () async {
                        // Hiển thị dialog chờ xử lý
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) {
                            return Center(child: CircularProgressIndicator());
                          },
                        );

                        // Gọi hàm đăng nhập
                        User? user = await viewModel.Login(
                          context: context,
                          email: emailController.text.trim(),
                          password: passwordController.text.trim(),
                        );

                        // Đóng dialog chờ
                        Navigator.pop(context);

                        // Tạm dừng ngắn để cải thiện trải nghiệm người dùng
                        await Future.delayed(Duration(milliseconds: 500));

                        if (user != null) {
                          // Hiển thị thông báo thành công
                          QuickAlert.show(
                            context: context,
                            type: QuickAlertType.success,
                            text: "Đăng nhập thành công",
                            title: "THÀNH CÔNG",
                            onConfirmBtnTap: () async {
                              if (await Auth().isEmailVerified()) {
                                await NavigatorHelper.navigateAndRemoveUntil(context, BottomNavBar());
                              } else {
                                await NavigatorHelper.navigateAndRemoveUntil(context, EmailVerificationLink());
                              }
                            },
                          );
                        } else {
                          // Hiển thị thông báo thất bại
                          QuickAlert.show(
                            context: context,
                            type: QuickAlertType.error,
                            text: "Tên đăng nhập hoặc mật khẩu không hợp lệ",
                            title: "THẤT BẠI",
                            onConfirmBtnTap: () {
                              NavigatorHelper.goBack(context);
                            },
                          );
                        }
                      },
                      builder: (BuildContext context, Future<void> Function()? onTap) {
                        return Container(
                          width: double.maxFinite,
                          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 10.h),
                              elevation: 10,
                              backgroundColor: Colors.black12,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              side: BorderSide(
                                color: Colors.white,
                                width: 1.sp,
                              ),
                            ),
                            onPressed: onTap,
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
                        );
                      },
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
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
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
                                width: 1.sp
                            )
                        ),
                        onPressed: (){
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Coming soon")));
                        },
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
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                      child: GestureDetector(
                        onTap: (){
                          NavigatorHelper.navigateTo(context, ForgotPasswordMobile());
                        },
                        child: Text(
                          "Bạn quên mật khẩu?",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontFamily: GoogleFonts.roboto().fontFamily,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                      child: GestureDetector(
                        onTap: (){
                          NavigatorHelper.navigateTo(context, SignUpScreenMobile());
                        },
                        child: Text(
                          "Bạn mới sử dụng Netflix. Đăng ký ngay!",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontFamily: GoogleFonts.roboto().fontFamily,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          )
      ),
    );
  }
}
