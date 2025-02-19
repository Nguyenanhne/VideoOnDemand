import 'package:du_an_cntt/view_models/change_password_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tap_debouncer/tap_debouncer.dart';

import '../../helper/navigator.dart';
import '../../services/firebase_authentication.dart';
import '../../utils/utils.dart';
import '../forgot_password/forgot_password_screen.dart';
import '../sign_up/sign_up_screen.dart';
class ChangPasswordMobile extends StatefulWidget {
  const ChangPasswordMobile({super.key});

  @override
  State<ChangPasswordMobile> createState() => _ChangPasswordMobileState();
}

class _ChangPasswordMobileState extends State<ChangPasswordMobile> {

  final Auth firebaseAuth = Auth();
  var errorStyle = TextStyle(
      fontSize: 13,
      color: Colors.red,
      fontFamily: GoogleFonts.roboto().fontFamily
  );

  var contentStyle = TextStyle(
      fontSize: 14,
      color: Colors.black,
      fontFamily: GoogleFonts.roboto().fontFamily
  );

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ChangePasswordViewModel>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.black,
          leading:IconButton(
            onPressed: (){
              NavigatorHelper.goBack(context);
            },
            icon: const Icon(
              Icons.arrow_back, color: Colors.white,
            ),
          )
        ),
        body: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Form(
                key: viewModel.formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(height: MediaQuery.of(context).size.height/20),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                        child: Text(
                          "Thay đổi mật khẩu",
                          style: TextStyle(
                              fontSize: 28,
                              fontFamily: GoogleFonts.roboto().fontFamily,
                              fontWeight: FontWeight.bold,
                              color: Colors.black
                          ),
                          maxLines: 1,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: TextFormField(
                          controller: viewModel.currentPasswordController,
                          obscureText: true,
                          style: contentStyle,
                          decoration: InputDecoration(
                              fillColor: Colors.grey[100],
                              filled: true,
                              labelText: "Mật khẩu hiện tại",
                              hintText: "Vui lòng mật khẩu hiện tại",
                              labelStyle: TextStyle(color: Colors.black, fontFamily: GoogleFonts.roboto().fontFamily, fontSize: 16),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                              errorStyle: errorStyle
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Vui lòng nhập mật khẩu hiện tại';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                        child: TextFormField(
                          controller: viewModel.newPasswordController,
                          obscureText: true,
                          style: contentStyle,
                          decoration: InputDecoration(
                              fillColor: Colors.grey[100],
                              filled: true,
                              labelText: "Mật khẩu mới",
                              hintText: "Vui lòng mật khẩu mới",
                              labelStyle: TextStyle(color: Colors.black, fontFamily: GoogleFonts.roboto().fontFamily, fontSize: 16),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                              errorStyle: errorStyle
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Vui lòng nhập mật khẩu mới';
                            } else if (value.length < 6) {
                              return 'Mật khẩu phải có ít nhất 6 ký tự';
                            } else if (!RegExp(r'^(?=.*?[#?!@$%^&*-])').hasMatch(value)) {
                              return 'Mật khẩu cần chứa ít nhất một ký tự đặc biệt';
                            }
                            return null;
                          },
                        ),
                      ),
                      Container(
                        width: double.maxFinite,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 10),
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
                            viewModel.changePasswordOnTap(context);
                          },
                          child: Text(
                            "Thay đổi mật khẩu",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: GoogleFonts.roboto().fontFamily,
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
