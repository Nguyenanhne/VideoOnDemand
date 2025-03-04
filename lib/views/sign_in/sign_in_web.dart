import 'package:du_an_cntt/helper/navigator.dart';
import 'package:du_an_cntt/utils/utils.dart';
import 'package:du_an_cntt/view_models/sign_in_vm.dart';
import 'package:du_an_cntt/views/forgot_password/forgot_password_mobile.dart';
import 'package:du_an_cntt/views/forgot_password/forgot_password_screen.dart';
import 'package:du_an_cntt/views/sign_up/sign_up_mobile.dart';
import 'package:du_an_cntt/views/sign_up/sign_up_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';
import 'package:tap_debouncer/tap_debouncer.dart';

import '../../services/firebase_authentication.dart';
import '../bottom_navbar.dart';
import '../email_verification_link/email_verification_link_screen.dart';
class SignInScreenWeb extends StatefulWidget {
  const SignInScreenWeb({super.key});

  @override
  State<SignInScreenWeb> createState() => _SignInScreenWebState();
}

class _SignInScreenWebState extends State<SignInScreenWeb> {
  // final TextEditingController emailController = TextEditingController();
  // final TextEditingController passwordController = TextEditingController();
  // final SignInViewModel signInViewModel = SignInViewModel();


  final contentPadding = 20.0;
  final horizontalPadding = 40.w;
  // @override
  // void dispose() {
  //   emailController.dispose();
  //   passwordController.dispose();
  //   super.dispose();
  // }
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<SignInViewModel>(context, listen: false);

    final labelStyle = TextStyle(
        fontSize: 30,
        color: Colors.grey[400],
        fontFamily: GoogleFonts.roboto().fontFamily
    );
    final contentStyle = TextStyle(
        fontSize: 20,
        color: Colors.grey[400],
        fontFamily: GoogleFonts.roboto().fontFamily
    );
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            titleSpacing: 0,
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Container(
              child: Image.asset(
                "assets/logo.png",
                width: 50.w,
              ),
            ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Color(colorAppbarIcon),size: iconTabletSize),
              onPressed: () {
                SystemNavigator.pop();
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
                      padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 20.h),
                      child: TextFormField(
                        controller: viewModel.emailController,
                        style: contentStyle,
                        decoration: InputDecoration(
                          fillColor: Colors.grey[800],
                          filled: true,
                          labelText: "Email hoặc số điện thoại",
                          labelStyle: labelStyle,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          contentPadding: EdgeInsets.all(contentPadding)
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                      child: TextFormField(
                        controller: viewModel.passwordController,
                        obscureText: true,
                        style: contentStyle,
                        decoration: InputDecoration(
                          fillColor: Colors.grey[800],
                          filled: true,
                          labelText: "Mật khẩu",
                          labelStyle: labelStyle,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          contentPadding: EdgeInsets.all(contentPadding)
                        ),
                      ),
                    ),
                    TapDebouncer(
                      onTap: () async {
                        viewModel.signInOnTap(context);
                        // // Hiển thị dialog chờ xử lý
                        // showDialog(
                        //   context: context,
                        //   barrierDismissible: false,
                        //   builder: (context) {
                        //     return Center(child: CircularProgressIndicator());
                        //   },
                        // );
                        //
                        // // Gọi hàm đăng nhập
                        // User? user = await viewModel.Login(
                        //   context: context,
                        //   email: viewModel.emailController.text.trim(),
                        //   password: viewModel.passwordController.text.trim(),
                        // );
                        //
                        // // Đóng dialog chờ
                        // Navigator.pop(context);
                        //
                        // // Tạm dừng ngắn để cải thiện trải nghiệm người dùng
                        // await Future.delayed(Duration(milliseconds: 500));
                        //
                        // if (user != null) {
                        //   // Hiển thị thông báo thành công
                        //   QuickAlert.show(
                        //     context: context,
                        //     type: QuickAlertType.success,
                        //     text: "Đăng nhập thành công",
                        //     title: "THÀNH CÔNG",
                        //     onConfirmBtnTap: () async {
                        //       if (await Auth().isEmailVerified()) {
                        //         await NavigatorHelper.navigateAndRemoveUntil(context, BottomNavBar());
                        //       } else {
                        //         await NavigatorHelper.navigateAndRemoveUntil(context, EmailVerificationLink());
                        //       }
                        //     },
                        //   );
                        // } else {
                        //   // Hiển thị thông báo thất bại
                        //   QuickAlert.show(
                        //     context: context,
                        //     type: QuickAlertType.error,
                        //     text: "Tên đăng nhập hoặc mật khẩu không hợp lệ",
                        //     title: "THẤT BẠI",
                        //     onConfirmBtnTap: () {
                        //       NavigatorHelper.goBack(context);
                        //     },
                        //   );
                        // }
                      },
                      builder: (BuildContext context, Future<void> Function()? onTap) {
                        return Container(
                          width: double.maxFinite,
                          padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 20.h),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.all(contentPadding),
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
                              style: labelStyle.copyWith(fontWeight: FontWeight.bold)
                            ),
                          ),
                        );
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Text(
                        "Hoặc",
                        style: labelStyle.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      width: double.maxFinite,
                      padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 20.h),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.all(contentPadding),
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
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Coming soon", style: contentStyle)));
                        },
                        child: Text(
                          "Dùng mã đăng nhập",
                          style: labelStyle.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 20.h),
                      child: GestureDetector(
                        onTap: (){
                          NavigatorHelper.navigateTo(context, ForgotPasswordScreen());
                        },
                        child: Text(
                          "Bạn quên mật khẩu?",
                          style: labelStyle.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                      child: GestureDetector(
                        onTap: (){
                          NavigatorHelper.navigateTo(context, SignUpScreen());
                        },
                        child: Text(
                          "Bạn mới sử dụng Netflix. Đăng ký ngay!",
                          style: labelStyle.copyWith(fontWeight: FontWeight.bold),
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
