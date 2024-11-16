import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String?> createUserWithEmailAndPassword({required String email, required String password}) async {
    try {
       UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;

      if (user != null) {
       // Gửi email xác thực sau khi người dùng đăng ký thành công
       await sendEmailVerificationLink(user);
       return 'Đăng ký thành công! Email xác thực đã được gửi đến ${user.email}.';
      } else {
       return 'Đăng ký thất bại! Không thể tạo người dùng.';
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      } else {
        return e.message;
      }
    } catch (e) {
      return e.toString();
    }
  }
  Future<String?> sendEmailVerificationLink(User user) async{
    try {
      // Gửi email xác thực
      await user.sendEmailVerification();
      print("Đã gửi email xác thực đến: ${user.email}");
    } catch (e) {
      // Xử lý lỗi nếu có
      print("Lỗi khi gửi email xác thực: $e");
    }
  }
}