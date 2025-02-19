import 'package:du_an_cntt/helper/navigator.dart';
import 'package:du_an_cntt/views/sign_in/sign_in_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';

class ChangePasswordViewModel extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final TextEditingController currentPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();

  Future<void> changePasswordOnTap(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;

    // Hiển thị loading
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    String? message = await changePassword();
    if(context.mounted){
      Navigator.pop(context);
    }

    if (message == null) {
      if(context.mounted){
        QuickAlert.show(
          context: context,
          type: QuickAlertType.success,
          title: "Thành công",
          text: "Mật khẩu đã được cập nhật!",
          onConfirmBtnTap: () async {
            await FirebaseAuth.instance.signOut();
            NavigatorHelper.navigateAndRemoveUntil(context, SignInScreen());
          },
        );
      }
    } else {
      if(context.mounted){
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          title: "Lỗi",
          text: "Mật khẩu hiện tại không đúng",
        );
      }
    }
  }

  Future<String?> changePassword() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null && user.email != null) {
        String currentPassword = currentPasswordController.text.trim();
        String newPassword = newPasswordController.text.trim();

        AuthCredential credential = EmailAuthProvider.credential(
          email: user.email!,
          password: currentPassword,
        );
        await user.reauthenticateWithCredential(credential);

        await user.updatePassword(newPassword);

        currentPasswordController.clear();
        newPasswordController.clear();

        return null;
      }
      return "Không tìm thấy người dùng.";
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == "wrong-password") {
        return "Mật khẩu hiện tại không đúng!";
      } else if (e.code == "weak-password") {
        return "Mật khẩu mới quá yếu!";
      }
      return "Có lỗi xảy ra: ${e.code}";
    }
  }
}
