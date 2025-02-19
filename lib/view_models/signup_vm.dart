import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import '../helper/navigator.dart';
import '../services/firebase_authentication.dart';
import '../views/email_verification_link/email_verification_link_screen.dart';

class SignUpViewModel extends ChangeNotifier{
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  String? _message;
  String? get message => _message;
  final Auth firebaseAuth = Auth();

  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController useNameController = TextEditingController();

  void loading(bool status) {
    _isLoading = status;
    notifyListeners();
  }
  void reset(){
    _isLoading = false;
    _message = null;
    emailController.clear();
    passwordController.clear();
    useNameController.clear();
  }

  Future<String?> signUp(String email, String password, String fullName) async{
    _message = await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password, fullName: fullName);
    loading(true);
    return _message;
  }
  void signUpOnTap(BuildContext context) async{
    String? message;
    if (formKey.currentState! .validate()) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context){
          return Center(child: CircularProgressIndicator());
        });
      message = await signUp(emailController.text, passwordController.text, useNameController.text);

      Navigator.pop(context);

      if (message == 'The account already exists for that email.') {
        if(context.mounted){
            QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            title: "Đăng ký thất bại",
            text: "Email này đã được đăng ký, vui lòng thử lại với email khác",
          );
        }
      } else if (message != null && message.contains('Đăng ký thành công')) {
        if(context.mounted){
            QuickAlert.show(
            context: context,
            type: QuickAlertType.success,
            title: "Còn 1 bước nữa",
            text: message,
            onConfirmBtnTap: () async {
              await NavigatorHelper.navigateAndRemoveUntil(context, const EmailVerificationLink());
            },
          );
        }
      } else {
        if(context.mounted) {
          QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            title: "Lỗi",
            text: message ?? "Đã xảy ra lỗi không xác định.",
          );
        }
      }
    }
  }
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    useNameController.dispose();
    super.dispose();
  }
}