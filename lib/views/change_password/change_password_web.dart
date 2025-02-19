import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../helper/navigator.dart';
import '../../services/firebase_authentication.dart';
import '../../utils/utils.dart';
import '../../view_models/change_password_vm.dart';
class ChangePasswordWeb extends StatefulWidget {
  const ChangePasswordWeb({super.key});

  @override
  State<ChangePasswordWeb> createState() => _ChangePasswordWebState();
}

class _ChangePasswordWebState extends State<ChangePasswordWeb> {
  final Auth firebaseAuth = Auth();

  @override
  Widget build(BuildContext context) {
    final errorStyle = TextStyle(
        fontSize: 20,
        color: Colors.red,
        fontFamily: GoogleFonts.roboto().fontFamily
    );
    var labelStyle = TextStyle(
        fontSize: 30,
        color: Colors.black,
        fontFamily: GoogleFonts.roboto().fontFamily
    );
    var contentStyle = TextStyle(
        fontSize: 20,
        color: Colors.black,
        fontFamily: GoogleFonts.roboto().fontFamily
    );

    final contentPadding = 20.0;
    final horizontalPadding = 40.w;

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
                Icons.arrow_back, color: Colors.white, size: iconTabletSize,
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
                        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: horizontalPadding),
                        child: Text(
                          "Thay đổi mật khẩu",
                          style: TextStyle(
                              fontSize: 50,
                              fontFamily: GoogleFonts.roboto().fontFamily,
                              fontWeight: FontWeight.bold,
                              color: Colors.black
                          ),
                          maxLines: 1,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                        child: TextFormField(
                          controller: viewModel.currentPasswordController,
                          obscureText: true,
                          style: contentStyle,
                          decoration: InputDecoration(
                              fillColor: Colors.grey[100],
                              filled: true,
                              labelText: "Mật khẩu hiện tại",
                              hintText: "Vui lòng mật khẩu hiện tại",
                              labelStyle: labelStyle,
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
                        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: horizontalPadding),
                        child: TextFormField(
                          controller: viewModel.newPasswordController,
                          obscureText: true,
                          style: contentStyle,
                          decoration: InputDecoration(
                              fillColor: Colors.grey[100],
                              filled: true,
                              labelText: "Mật khẩu mới",
                              hintText: "Vui lòng mật khẩu mới",
                              labelStyle: labelStyle,
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
                        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            elevation: 10,
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            side: BorderSide(
                              color: Colors.white,
                              width: 1.sp,
                            ),
                          ),
                          onPressed: () async {
                            viewModel.changePasswordOnTap(context);
                          },
                          child: Text(
                              "Thay đổi mật khẩu",
                              style: labelStyle.copyWith(fontWeight: FontWeight.bold)
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
