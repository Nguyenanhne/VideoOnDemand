import 'package:du_an_cntt/views/home/home_mobile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import '../helper/navigator.dart';
import '../services/firebase_authentication.dart';
import '../views/email_verification_link/email_verification_link_mobile.dart';
class SignInViewModel extends ChangeNotifier{
  Future<void> Login({required BuildContext context, required String email, required String password}) async {
    final user = await Auth().loginUserWithEmailAndPassword(email: email, password: password);

    if (user != null){
      QuickAlert.show(
          context: context,
          type: QuickAlertType.success,
          text: "Đăng nhập thành công",
          title: "THÀNH CÔNG",
          onConfirmBtnTap: () async {
            if (await Auth().isEmailVerified()){
              await NavigatorHelper.navigateAndRemoveUntil(context, HomeScreenMobile());
            }
            else{
              await NavigatorHelper.navigateAndRemoveUntil(context, EmailVerificationLinkMobile());
            }
          }
      );
    }
    else{
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        text: "Tên đăng nhập hoặc mật khẩu không hợp lệ",
        title: "THẤT BẠI",
        onConfirmBtnTap: () async {
          NavigatorHelper.goBack(context);
        }
      );
    }
  }
}