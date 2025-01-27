import 'package:du_an_cntt/helper/navigator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickalert/quickalert.dart';
import '../../services/firebase_authentication.dart';
import '../../utils.dart';
import '../sign_in/sign_in_screen.dart';

class ForgotPasswordWeb extends StatefulWidget {
  const ForgotPasswordWeb({super.key});

  @override
  State<ForgotPasswordWeb> createState() => _ForgotPasswordWebState();
}

class _ForgotPasswordWebState extends State<ForgotPasswordWeb> {
  final TextEditingController emailController = TextEditingController();
  final firebaseAuth = Auth();
  final formKey = GlobalKey<FormState>();

  var contenPadding = 20.0;

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    var contentStyle = TextStyle(
        fontSize: 35,
        color: Colors.grey[400],
        fontFamily: GoogleFonts.roboto().fontFamily
    );
    var titleStyle = TextStyle(
        fontSize: 50,
        color: Colors.white,
        fontFamily: GoogleFonts.roboto().fontFamily,
        fontWeight: FontWeight.bold
    );
    var labelStyle = TextStyle(
        fontSize: 30,
        color: Colors.white,
        fontWeight: FontWeight.bold,
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
            icon: Icon(Icons.arrow_back, color: Color(colorAppbarIcon), size: iconTabletSize),
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                        child: Text(
                          "Vui lòng cung cấp địa chỉ email bạn đã sử dụng để đăng ký tài khoản",
                          style: titleStyle,
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Text(
                          "Chúng tôi sẽ gửi đường dẫn khôi phục mật khẩu qua email cho bạn",
                          style: contentStyle,
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
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
                            errorStyle: contentStyle,
                            fillColor: Colors.grey[800],
                            filled: true,
                            labelText: "Email",
                            labelStyle: labelStyle,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                            contentPadding: EdgeInsets.all(contenPadding)
                        ),
                      ),
                    ),
                    Container(
                      width: double.maxFinite,
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(contenPadding),
                          elevation: 10,
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)
                          ),
                          side: BorderSide(
                              color: Colors.white,
                              width: 1.w
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
                          style: labelStyle
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
