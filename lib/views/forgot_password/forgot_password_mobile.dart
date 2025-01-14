import 'package:du_an_cntt/helper/navigator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickalert/quickalert.dart';
import '../../services/firebase_authentication.dart';
import '../../utils.dart';
import '../sign_in/sign_in_screen.dart';

class ForgotPasswordMobile extends StatefulWidget {
  const ForgotPasswordMobile({super.key});

  @override
  State<ForgotPasswordMobile> createState() => _ForgotPasswordMobileState();
}

class _ForgotPasswordMobileState extends State<ForgotPasswordMobile> {
  final TextEditingController emailController = TextEditingController();
  final firebaseAuth = Auth();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    super.dispose();
  }
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
            onPressed: () {
              NavigatorHelper.goBack(context);
            },
          ),
        ),
        body: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                        child: Text(
                          "Vui lòng cung cấp địa chỉ email bạn đã sử dụng để đăng ký tài khoản",
                          style: TextStyle(
                              fontFamily: GoogleFonts.roboto().fontFamily,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.sp
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Text(
                          "Chúng tôi sẽ gửi đường dẫn khôi phục mật khẩu qua email cho bạn",
                          style: TextStyle(
                              fontFamily: GoogleFonts.roboto().fontFamily,
                              color: Colors.white,
                              fontSize: 16.sp
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                      child: TextFormField(
                        controller: emailController,
                        style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.grey[400],
                            fontFamily: GoogleFonts.roboto().fontFamily
                        ),
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
                          errorStyle: TextStyle(
                            color: Colors.red[400],
                            fontSize: 12.sp
                          ),
                          fillColor: Colors.grey[800],
                          filled: true,
                          labelText: "Email",
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
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            elevation: 10,
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)
                            ),
                            side: BorderSide(
                                color: Colors.white,
                                width: 1
                            ),
                        ),
                        onPressed: () async{
                          if (formKey.currentState!.validate()){
                            await firebaseAuth.sendPasswordResetEmail(emailController.text.trim());
                            QuickAlert.show(
                              context: context,
                              type: QuickAlertType.success,
                              title: "THÀNH CÔNG",
                              text: "Vui lòng kiểm tra email",
                              onConfirmBtnTap: (){
                                NavigatorHelper.navigateAndRemoveUntil(context, SignInScreen());
                              }
                            );
                          }
                        },
                        child: Text(
                          "Khôi phục mật khẩu",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            fontFamily: GoogleFonts.roboto().fontFamily,
                          ),
                        ),
                      ),
                    ),
                    Expanded(flex: 2, child: Container())
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
