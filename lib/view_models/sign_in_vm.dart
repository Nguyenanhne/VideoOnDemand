import 'package:du_an_cntt/views/bottom_navbar.dart';
import 'package:du_an_cntt/views/home/home_mobile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import '../helper/navigator.dart';
import '../services/firebase_authentication.dart';
import '../views/email_verification_link/email_verification_link_mobile.dart';
import '../views/email_verification_link/email_verification_link_screen.dart';
class SignInViewModel extends ChangeNotifier{
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
  void loading(bool status) {
    _isLoading = status;
    notifyListeners();
  }
  void reset(){
    emailController.clear();
    passwordController.clear();
    _isLoading = false;
  }

  Future<User?> signIn({required BuildContext context, required String email, required String password}) async {
    final user = await Auth().signInUserWithEmailAndPassword(email: email, password: password);
    return user;
  }
  void signInOnTap(BuildContext context) async{
    // Hiển thị dialog chờ xử lý
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Center(child: CircularProgressIndicator());
      },
    );

    // Gọi hàm đăng nhập
    User? user = await signIn(
      context: context,
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );

    // Đóng dialog chờ
    if(context.mounted){
      Navigator.pop(context);
    }

    // Tạm dừng ngắn để cải thiện trải nghiệm người dùng
    await Future.delayed(Duration(milliseconds: 500));

    if (user != null) {
      if(context.mounted){
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
      }
    } else {
      if(context.mounted) {
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
    }
  }
}