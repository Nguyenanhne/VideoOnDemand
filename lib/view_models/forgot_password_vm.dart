import 'package:flutter/cupertino.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import '../helper/navigator.dart';
import '../services/firebase_authentication.dart';
import '../views/sign_in/sign_in_screen.dart';

class ForgotPasswordViewModel extends ChangeNotifier{
  final TextEditingController emailController = TextEditingController();
  final firebaseAuth = Auth();
  final formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }
  void reset(){
    emailController.clear();
  }
  void onTap(BuildContext context) async{
    if (formKey.currentState!.validate()){
      await firebaseAuth.sendPasswordResetEmail(emailController.text.trim());
      if(context.mounted){
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
    }
  }
}